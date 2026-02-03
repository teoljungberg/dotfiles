-- Mouse follows focus logic adapted from MouseFollowsFocus spoon
-- Original author: Jason Felice <jason.m.felice@gmail.com>
-- https://github.com/Hammerspoon/Spoons
-- License: MIT

local M = {}

local SUPPRESS_DURATION = 0.15
local FOCUS_DELAY = 0.05

local suppressCount = 0
local windowFilter = nil
local focusTimer = nil

local function updateMouse(window)
  if not window then
    return
  end

  local frame = window:frame()
  if not frame then
    return
  end

  local currentPos = hs.geometry(hs.mouse.absolutePosition())
  if not currentPos:inside(frame) then
    local currentScreen = hs.mouse.getCurrentScreen()
    local windowScreen = window:screen()
    if currentScreen and windowScreen and currentScreen ~= windowScreen then
      hs.mouse.absolutePosition(currentScreen:frame().center)
      hs.mouse.absolutePosition(windowScreen:frame().center)
    end
    hs.mouse.absolutePosition(frame.center)
  end
end

function M.setup()
  if focusTimer then
    focusTimer:stop()
    focusTimer = nil
  end

  if windowFilter then
    windowFilter:unsubscribeAll()
    windowFilter = nil
  end

  local handleWindowEvent = function(window, _, event)
    if suppressCount > 0 then
      return
    end
    if event == "windowVisible" and window ~= hs.window.focusedWindow() then
      return
    end
    updateMouse(window)
  end

  windowFilter = hs.window.filter.new():setDefaultFilter({ visible = true })
  windowFilter:subscribe({
    hs.window.filter.windowFocused,
    hs.window.filter.windowVisible,
  }, handleWindowEvent)
end

function M.suppress()
  suppressCount = suppressCount + 1
  hs.timer.doAfter(SUPPRESS_DURATION, function()
    suppressCount = math.max(0, suppressCount - 1)
  end)
end

function M.focusWindow()
  if focusTimer then
    focusTimer:stop()
  end
  focusTimer = hs.timer.doAfter(FOCUS_DELAY, function()
    local window = hs.window.focusedWindow()
    if window then
      updateMouse(window)
    end
    focusTimer = nil
  end)
end

return M
