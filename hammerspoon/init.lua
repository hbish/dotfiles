hs.hotkey.bind({"cmd", "alt"}, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f, 0)
end)

hs.hotkey.bind({"cmd", "alt"}, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f, 0)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f, 0)
end)

hs.hotkey.bind({"cmd", "alt"}, "F", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f, 0)
end)

-- Find mouse
mouseCircle = nil
mouseCircleTimer = nil

function mouseHighlight()
    -- Delete an existing highlight if it exists
    if mouseCircle then
        mouseCircle:delete()
        if mouseCircleTimer then
            mouseCircleTimer:stop()
        end
    end
    -- Get the current co-ordinates of the mouse pointer
    mousepoint = hs.mouse.getAbsolutePosition()
    -- Prepare a big red circle around the mouse pointer
    mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x-40, mousepoint.y-40, 80, 80))
    mouseCircle:setStrokeColor({["red"]=0,["blue"]=1,["green"]=1,["alpha"]=1})
    mouseCircle:setFill(false)
    mouseCircle:setStrokeWidth(3)
    mouseCircle:show()

    -- Set a timer to delete the circle after 3 seconds
    mouseCircleTimer = hs.timer.doAfter(3, function() mouseCircle:delete() end)
end
hs.hotkey.bind({"cmd","alt","shift"}, "D", mouseHighlight)

-- Caffine Replacement
caffeine = hs.menubar.new()
function setCaffeineDisplay(state)
    if state then
        caffeine:setTitle("🚀")
    else
        caffeine:setTitle("🐢")
    end
end

function caffeineClicked()
    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end

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
    return "https://slack.com/api/users.profile.set?profile=" .. hs.http.encodeForQuery(body) .."&token=<SLACK_TOKEN>"
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
          hs.http.asyncPost(getSlackString(), nil, nil, function() end)
          print("update")
        end
      end
    end
  else
    nowPlaying:removeFromMenuBar()
  end
end

function nowPlayingClicked()
    print(getSlackString())
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

-- App Watcher
function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        if (appName == "Finder") then
            -- Bring all Finder windows forward when one gets activated
            appObject:selectMenuItem({"Window", "Bring All to Front"})
        end
    end
end
appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

-- alert default
hs.alert.defaultStyle.radius = 3
hs.alert.defaultStyle.strokeColor = { white = 1, alpha = 0 }
hs.alert.defaultStyle.fillColor = { white = 0.05, alpha = 0.75 }

-- Reload Function
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
