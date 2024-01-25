-- NowPlaying
nowPlaying = hs.menubar.new()
currentSong = ""

function getSongString()
    return hs.spotify.getCurrentArtist() .. " - " .. hs.spotify.getCurrentTrack()
end

function getSlackString()
    local emoji_table = {":loud_sound:",":headsetparrot:",":headphones:",":sound:",":musical_note:"}
    local value = math.random(1, #emoji_table)
    local emoji = emoji_table[value]
    expiry = os.time(os.date('*t')) + 300
    body = '{"status_text":"' .. getSongString() .. '","status_emoji":"'.. emoji ..'","status_expiration":'.. expiry ..'}'
    return "https://slack.com/api/users.profile.set?profile=" .. hs.http.encodeForQuery(body) .."&token=xoxp-***"
end

function spotifyTimerCallback()
    apps = hs.application.applicationsForBundleID("com.spotify.client")
    if #apps > 0 then
        state = hs.spotify.getPlaybackState()
        if state ~= nil then
            if string.match(hs.spotify.state_stopped, state) ~= nil then
                nowPlaying:removeFromMenuBar()
                nowPlaying = nil
            elseif string.match(hs.spotify.state_paused, state) ~= nil then
                nowPlaying:returnToMenuBar()
                nowPlaying:setTitle("⏸ " .. getSongString())
            elseif string.match(hs.spotify.state_playing, state) ~= nil then
                local newSong = getSongString()
                nowPlaying:returnToMenuBar()
                nowPlaying:setTitle("▶️ " .. newSong)
                if currentSong ~= newSong then
                    currentSong = newSong
                    -- hs.http.asyncPost(getSlackString(), nil, nil, function() end)
                    print("update")
                end
            end
        end
    else
        nowPlaying:removeFromMenuBar()
    end
end

function nowPlayingClicked()
    hs.spotify.playpause()
    spotifyTimerCallback()
end

if nowPlaying then
    spotifyTimerCallback()
    nowPlaying:setClickCallback(nowPlayingClicked)
    nowPlayingTimer = hs.timer.new(60, spotifyTimerCallback)
    nowPlayingTimer:start()
    -- some weird issue with sleep
    -- hs.timer.doEvery(30, spotifyTimerCallback)
end
