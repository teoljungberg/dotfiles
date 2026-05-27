-- Adapted from MouseFollowsFocus.spoon by Jason Felice (MIT).
-- https://github.com/Hammerspoon/Spoons/tree/master/Source/MouseFollowsFocus.spoon
--
-- Differences from upstream:
--   - `obj` style flattened to module style.
--   - `suppress()` and `focusWindow()` added to coordinate with caller-driven
--     focus changes (see commit a4e2ccf5).
--   - Defensive zero-sized frame guard inside `updateMouse`; native-tabbed apps
--     briefly report unsized windows during tab spawn.

local M = {}

local FOCUS_DELAY = 0.05
local suppressCount = 0
local windowFilter = nil
local focusTimer = nil

local function moveMouseToWindow(window)
  local currentPos = hs.geometry(hs.mouse.absolutePosition())
  local frame = window:frame()
  if not frame or frame.w == 0 or frame.h == 0 then
    return
  end

  if not currentPos:inside(frame) then
    local currentScreen = hs.mouse.getCurrentScreen()
    local windowScreen = window:screen()
    if currentScreen and windowScreen and currentScreen ~= windowScreen then
      -- avoid getting the mouse stuck on a screen corner by moving through the center of each screen
      hs.mouse.absolutePosition(currentScreen:frame().center)
      hs.mouse.absolutePosition(windowScreen:frame().center)
    end
    hs.mouse.absolutePosition(frame.center)
  end
end

function M.updateMouse(window)
  if suppressCount > 0 then
    return
  end
  if not window then
    return
  end
  moveMouseToWindow(window)
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

  windowFilter = hs.window.filter.new():setDefaultFilter({ visible = true })
  windowFilter:subscribe({ hs.window.filter.windowFocused }, M.updateMouse)
end

function M.suppress()
  local active = true
  suppressCount = suppressCount + 1

  return function()
    if active then
      active = false
      suppressCount = suppressCount - 1
    end
  end
end

function M.focusWindow()
  local callback = function()
    M.updateMouse(hs.window.focusedWindow())
    focusTimer = nil
  end

  if focusTimer then
    focusTimer:stop()
  end
  focusTimer = hs.timer.doAfter(FOCUS_DELAY, callback)
end

return M
