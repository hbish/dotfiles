-- NowPlaying
nowPlaying = hs.menubar.new()
currentSong = ""

function getSongString()
    return hs.itunes.getCurrentArtist() .. " - " .. hs.itunes.getCurrentTrack()
end

function itunesTimerCallback()
    apps = hs.application.applicationsForBundleID("com.apple.Music")
    if #apps > 0 then
        state = hs.itunes.getPlaybackState()
        if state ~= nil then
            if string.match(hs.itunes.state_stopped, state) ~= nil then
                nowPlaying:removeFromMenuBar()
                nowPlaying = nil
            elseif string.match(hs.itunes.state_paused, state) ~= nil then
                nowPlaying:returnToMenuBar()
                nowPlaying:setTitle("⏸ " .. getSongString())
            elseif string.match(hs.itunes.state_playing, state) ~= nil then
                local newSong = getSongString()
                nowPlaying:returnToMenuBar()
                nowPlaying:setTitle("▶️ " .. newSong)
                if currentSong ~= newSong then
                    currentSong = newSong
                    print("update")
                end
            end
        end
    else
        nowPlaying:removeFromMenuBar()
    end
end

function nowPlayingClicked()
    hs.itunes.playpause()
    itunesTimerCallback()
end

if nowPlaying then
    itunesTimerCallback()
    nowPlaying:setClickCallback(nowPlayingClicked)
    nowPlayingTimer = hs.timer.new(60, itunesTimerCallback)
    nowPlayingTimer:start()
    -- some weird issue with sleep
    -- hs.timer.doEvery(30, itunesTimerCallback)
end
