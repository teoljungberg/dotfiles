local M = {}
local pixelDifference = 50
local numberOfCells = 8
local minWindowWidth = 200
local minWindowHeight = 120

local function getWindow()
  local window = hs.window.focusedWindow()

  if window == nil then
    return
  else
    return window
  end
end

local function clamp(value, min, max)
  if value < min then
    return min
  end
  if value > max then
    return max
  end
  return value
end

local function setClampedFrame(window, frame)
  local screenFrame = window:screen():frame()
  local maxWidth = screenFrame.w
  local maxHeight = screenFrame.h

  frame.w = clamp(frame.w, minWindowWidth, maxWidth)
  frame.h = clamp(frame.h, minWindowHeight, maxHeight)

  local maxX = screenFrame.x + screenFrame.w - frame.w
  local maxY = screenFrame.y + screenFrame.h - frame.h
  frame.x = clamp(frame.x, screenFrame.x, maxX)
  frame.y = clamp(frame.y, screenFrame.y, maxY)

  window:setFrame(frame)
end

local function moveWindowX(direction)
  local window = getWindow()
  if not window then
    return
  end
  local frame = window:frame()

  frame.x = frame.x + direction
  setClampedFrame(window, frame)
end

local function moveWindowY(direction)
  local window = getWindow()
  if not window then
    return
  end
  local frame = window:frame()

  frame.y = frame.y + direction
  setClampedFrame(window, frame)
end

local function resizeWindowX(direction)
  local window = getWindow()
  if not window then
    return
  end
  local frame = window:frame()

  frame.w = frame.w + direction
  setClampedFrame(window, frame)
end

local function resizeWindowY(direction)
  local window = getWindow()
  if not window then
    return
  end
  local frame = window:frame()

  frame.h = frame.h + direction
  setClampedFrame(window, frame)
end

function M.centralizeWindow()
  local window = getWindow()
  if not window then
    return
  end
  local frame = window:frame()
  local max = window:screen():frame()
  local cellX = max.w / numberOfCells
  local cellY = max.h / numberOfCells

  frame.w = cellX * (numberOfCells - 2)
  frame.h = cellY * (numberOfCells - 2)
  frame.x = cellX
  frame.y = cellY

  setClampedFrame(window, frame)
end

function M.fullScreenWindow()
  local window = getWindow()
  if not window then
    return
  end
  window:maximize(0)
end

function M.moveLeft()
  moveWindowX(-pixelDifference)
end

function M.moveRight()
  moveWindowX(pixelDifference)
end

function M.moveUp()
  moveWindowY(-pixelDifference)
end

function M.moveDown()
  moveWindowY(pixelDifference)
end

function M.moveWindowLeftHalfScreen()
  local window = getWindow()
  if not window then
    return
  end
  local windowFrame = window:frame()
  local screen = window:screen()
  local max = screen:frame()

  windowFrame.x = max.x
  windowFrame.y = max.y
  windowFrame.w = max.w / 2
  windowFrame.h = max.h

  setClampedFrame(window, windowFrame)
end

function M.moveWindowRightHalfScreen()
  local window = getWindow()
  if not window then
    return
  end
  local windowFrame = window:frame()
  local screen = window:screen()
  local max = screen:frame()

  windowFrame.x = max.x + (max.w / 2)
  windowFrame.y = max.y
  windowFrame.w = max.w / 2
  windowFrame.h = max.h

  setClampedFrame(window, windowFrame)
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
  local window = getWindow()
  if not window then
    return
  end
  window:moveOneScreenWest()
end

function M.moveWindowToEastDisplay()
  local window = getWindow()
  if not window then
    return
  end
  window:moveOneScreenEast()
end

function M.moveWindowToNorthDisplay()
  local window = getWindow()
  if not window then
    return
  end
  window:moveOneScreenNorth()
end

function M.moveWindowToSouthDisplay()
  local window = getWindow()
  if not window then
    return
  end
  window:moveOneScreenSouth()
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
    ["m"] = "org.vim.MacVim",
    ["n"] = "com.apple.Notes",
  }
end

return M
