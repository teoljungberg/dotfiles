local M = {}
local numberOfCells = 32

-- Mouse follows focus logic adapted from MouseFollowsFocus spoon
-- Original author: Jason Felice <jason.m.felice@gmail.com>
-- https://github.com/Hammerspoon/Spoons
-- License: MIT

-- Delay to allow window focus events to settle after hiding
local SUPPRESS_DURATION = 0.15
-- Delay to ensure window is fully unhidden before moving mouse
local FOCUS_DELAY = 0.05

local suppressMouseFollowCount = 0
local mouseFollowFilter = nil
local focusTimer = nil

local function updateMouse(window)
  if not window then
    return
  end

  local frame = window:frame()
  if not frame then
    return
  end

  local current_pos = hs.geometry(hs.mouse.absolutePosition())
  if not current_pos:inside(frame) then
    local current_screen = hs.mouse.getCurrentScreen()
    local window_screen = window:screen()
    if current_screen and window_screen and current_screen ~= window_screen then
      hs.mouse.absolutePosition(current_screen:frame().center)
      hs.mouse.absolutePosition(window_screen:frame().center)
    end
    hs.mouse.absolutePosition(frame.center)
  end
end

function M.setupMouseFollowsFocus()
  if focusTimer then
    focusTimer:stop()
    focusTimer = nil
  end

  if mouseFollowFilter then
    mouseFollowFilter:unsubscribeAll()
    mouseFollowFilter = nil
  end

  local handleWindowEvent = function(window, appName, event)
    if suppressMouseFollowCount > 0 then
      return
    end
    -- windowVisible fires for any window becoming visible (unhidden).
    -- Only move mouse if this visible window is also the focused one,
    -- otherwise we'd jump to background windows when they unhide.
    if event == "windowVisible" and window ~= hs.window.focusedWindow() then
      return
    end
    updateMouse(window)
  end

  mouseFollowFilter =
    hs.window.filter.new():setDefaultFilter({ visible = true })
  mouseFollowFilter:subscribe({
    hs.window.filter.windowFocused,
    hs.window.filter.windowVisible,
  }, handleWindowEvent)
end

hs.grid.setGrid(numberOfCells .. "x" .. numberOfCells)
hs.grid.setMargins({ w = 0, h = 0 })

function M.centralizeWindow()
  local window = hs.window.focusedWindow()
  if not window then
    return
  end
  window:moveToUnit({ x = 1 / 8, y = 1 / 8, w = 6 / 8, h = 6 / 8 })
end

function M.fullScreenWindow()
  local window = hs.window.focusedWindow()
  if not window then
    return
  end
  window:maximize(0)
end

function M.moveLeft()
  hs.grid.pushWindowLeft(hs.window.focusedWindow())
end

function M.moveRight()
  hs.grid.pushWindowRight(hs.window.focusedWindow())
end

function M.moveUp()
  hs.grid.pushWindowUp(hs.window.focusedWindow())
end

function M.moveDown()
  hs.grid.pushWindowDown(hs.window.focusedWindow())
end

function M.moveWindowLeftHalfScreen()
  local window = hs.window.focusedWindow()
  if not window then
    return
  end
  window:moveToUnit({ x = 0, y = 0, w = 1 / 2, h = 1 })
end

function M.moveWindowRightHalfScreen()
  local window = hs.window.focusedWindow()
  if not window then
    return
  end
  window:moveToUnit({ x = 1 / 2, y = 0, w = 1 / 2, h = 1 })
end

function M.resizeLeft()
  hs.grid.resizeWindowThinner(hs.window.focusedWindow())
end

function M.resizeRight()
  hs.grid.resizeWindowWider(hs.window.focusedWindow())
end

function M.resizeUp()
  hs.grid.resizeWindowShorter(hs.window.focusedWindow())
end

function M.resizeDown()
  hs.grid.resizeWindowTaller(hs.window.focusedWindow())
end

function M.reloadConfig()
  hs.reload()
end

function M.moveWindowToWestDisplay()
  local window = hs.window.focusedWindow()
  if not window then
    return
  end
  window:moveOneScreenWest()
end

function M.moveWindowToEastDisplay()
  local window = hs.window.focusedWindow()
  if not window then
    return
  end
  window:moveOneScreenEast()
end

function M.moveWindowToNorthDisplay()
  local window = hs.window.focusedWindow()
  if not window then
    return
  end
  window:moveOneScreenNorth()
end

function M.moveWindowToSouthDisplay()
  local window = hs.window.focusedWindow()
  if not window then
    return
  end
  window:moveOneScreenSouth()
end

function M.toggleApplication(bundleID)
  local toggle = function()
    local front = hs.application.frontmostApplication()
    if front and front:bundleID() == bundleID then
      local decrementSuppressCount = function()
        suppressMouseFollowCount = math.max(0, suppressMouseFollowCount - 1)
      end

      suppressMouseFollowCount = suppressMouseFollowCount + 1
      front:hide()
      hs.timer.doAfter(SUPPRESS_DURATION, decrementSuppressCount)
    else
      local focusAndUpdateMouse = function()
        local win = hs.window.focusedWindow()
        if win then
          updateMouse(win)
        end
        focusTimer = nil
      end

      hs.application.launchOrFocusByBundleID(bundleID)
      if focusTimer then
        focusTimer:stop()
      end
      focusTimer = hs.timer.doAfter(FOCUS_DELAY, focusAndUpdateMouse)
    end
  end

  return toggle
end

-- The bundle ID is fetched with the following AppleScript:
--
-- `osascript -e 'id of app "NAME OF APP"'`
--
function M.buildApplicationShortcutToBundleMapping()
  return {
    [0] = "com.mitchellh.ghostty",
    [1] = "org.mozilla.firefox",
    [2] = "com.apple.mail",
    [3] = "com.tinyspeck.slackmacgap",
    [4] = "com.spotify.client",
    [5] = nil,
    [6] = nil,
    [7] = nil,
    [8] = nil,
    [9] = "com.google.Chrome",
    ["c"] = "com.anthropic.claudefordesktop",
    ["m"] = "org.vim.MacVim",
    ["n"] = "com.apple.Notes",
  }
end

return M
