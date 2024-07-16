local M = {}
local pixelDifference = 50
local menuBarInPixles = 37
local numberOfCells = 8

local function getWindow()
  local window = hs.window.focusedWindow()

  if window == nil then
    return
  else
    return window
  end
end

local function moveWindowX(direction)
  local window = getWindow()
  local frame = window:frame()

  frame.x = frame.x + direction
  window:setFrame(frame)
end

local function moveWindowY(direction)
  local window = getWindow()
  local frame = window:frame()

  frame.y = frame.y + direction
  window:setFrame(frame)
end

local function resizeWindowX(direction)
  local window = getWindow()
  local frame = window:frame()

  frame.w = frame.w + direction
  window:setFrame(frame)
end

local function resizeWindowY(direction)
  local window = getWindow()
  local frame = window:frame()

  frame.h = frame.h + direction
  window:setFrame(frame)
end

function M.centralizeWindow()
  local window = getWindow()
  local frame = window:frame()
  local max = window:screen():frame()
  local cellX = max.w / numberOfCells
  local cellY = (menuBarInPixles + max.h) / numberOfCells

  frame.w = cellX * (numberOfCells - 2)
  frame.h = cellY * (numberOfCells - 2)
  frame.x = cellX
  frame.y = cellY

  window:setFrame(frame)
end

function M.fullScreenWindow()
  local window = getWindow()
  window:maximize(0)
end

function M.moveLeft()
  moveWindowX(pixelDifference)
end

function M.moveRight()
  moveWindowX(-pixelDifference)
end

function M.moveUp()
  moveWindowY(-pixelDifference)
end

function M.moveDown()
  moveWindowY(pixelDifference)
end

function M.moveWindowLeftHalfScreen()
  local window = getWindow()
  local windowFrame = window:frame()
  local screen = window:screen()
  local max = screen:frame()

  windowFrame.x = max.x
  windowFrame.y = max.y
  windowFrame.w = max.w / 2
  windowFrame.h = max.h

  window:setFrame(windowFrame)
end

function M.moveWindowRightHalfScreen()
  local window = getWindow()
  local windowFrame = window:frame()
  local screen = window:screen()
  local max = screen:frame()

  windowFrame.x = max.x + (max.w / 2)
  windowFrame.y = max.y
  windowFrame.w = max.w / 2
  windowFrame.h = max.h

  window:setFrame(windowFrame)
end

function M.resizeLeft()
  resizeWindowX(-pixelDifference)
end

function M.resizeRight()
  resizeWindowX(pixelDifference)
end

function M.resizeUp()
  resizeWindowY(-pixelDifference)
end

function M.resizeDown()
  resizeWindowY(pixelDifference)
end

function M.reloadConfig()
  hs.reload()
end

function M.moveWindowToWestDisplay()
  hs.window.focusedWindow():moveOneScreenWest()
end

function M.moveWindowToEastDisplay()
  hs.window.focusedWindow():moveOneScreenEast()
end

function M.moveWindowToNorthDisplay()
  hs.window.focusedWindow():moveOneScreenNorth()
end

function M.moveWindowToSouthDisplay()
  hs.window.focusedWindow():moveOneScreenSouth()
end

local function hideAlreadyRunningApplication(bundleID)
  local focus = hs.window.focusedWindow()

  if focus and focus:application():bundleID() == bundleID then
    focus:application():hide()
    return true
  else
    return false
  end
end

local function activeRunningApplication(bundleID)
  local running = hs.application.applicationsForBundleID(bundleID)

  if #running > 0 and #running[1]:allWindows() > 0 then
    running[1]:activate()
    return true
  else
    return false
  end
end

local function launchApplication(bundleID)
  hs.application.launchOrFocusByBundleID(bundleID)
end

function M.toggleApplication(bundleID)
  return function()
    if hideAlreadyRunningApplication(bundleID) then
      return
    elseif activeRunningApplication(bundleID) then
      return
    else
      launchApplication(bundleID)
    end
  end
end

-- The bundle ID is fetched with the following AppleScript:
--
-- `osascript -e 'id of app "NAME OF APP"'`
--
function M.buildApplicationShortcutToBundleMapping()
  return {
    [0] = "net.kovidgoyal.kitty",
    [1] = "org.mozilla.firefox",
    [2] = "com.apple.mail",
    [3] = "com.tinyspeck.slackmacgap",
    [4] = "com.spotify.client",
    [5] = nil,
    [6] = nil,
    [7] = nil,
    [8] = nil,
    [9] = "com.google.Chrome",
    ["m"] = "com.neovide.neovide",
    ["n"] = "com.apple.Notes",
  }
end

return M
