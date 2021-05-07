local pixelDifference = 50
local menuBarInPixles = 23
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

local function centralizeWindow()
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

local function fullScreenWindow()
  local window = getWindow()
  window:maximize(0)
end

local function moveLeft()
  moveWindowX(pixelDifference)
end

local function moveRight()
  moveWindowX(-pixelDifference)
end

local function moveUp()
  moveWindowY(-pixelDifference)
end

local function moveDown()
  moveWindowY(pixelDifference)
end

local function moveWindowLeftHalfScreen()
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

local function moveWindowRightHalfScreen()
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

local function resizeLeft()
  resizeWindowX(-pixelDifference)
end

local function resizeRight()
  resizeWindowX(pixelDifference)
end

local function resizeUp()
  resizeWindowY(-pixelDifference)
end

local function resizeDown()
  resizeWindowY(pixelDifference)
end

local function reloadConfig()
  hs.reload()
  hs.alert.show("Config reloaded")
end

local function moveWindowToWestDisplay()
  hs.window.focusedWindow():moveOneScreenWest()
end

local function moveWindowToEastDisplay()
  hs.window.focusedWindow():moveOneScreenEast()
end

local function moveWindowToNorthDisplay()
  hs.window.focusedWindow():moveOneScreenNorth()
end

local function moveWindowToSouthDisplay()
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

local function toggleApplication(bundleID)
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
local function applicationShortcutToBundleMapping()
  return {
    [0] = "net.kovidgoyal.kitty",
    [1] = "com.brave.Browser",
    [2] = "com.apple.mail",
    [3] = "com.tinyspeck.slackmacgap",
    [4] = "com.spotify.client",
    [5] = nil,
    [6] = nil,
    [7] = nil,
    [8] = nil,
    [9] = nil,
    ["m"] = "org.vim.MacVim",
  }
end

return {
  moveLeft = moveLeft,
  moveRight = moveRight,
  moveUp = moveUp,
  moveDown = moveDown,
  moveWindowLeftHalfScreen = moveWindowLeftHalfScreen,
  moveWindowRightHalfScreen = moveWindowRightHalfScreen,
  resizeLeft = resizeLeft,
  resizeRight = resizeRight,
  resizeUp = resizeUp,
  resizeDown = resizeDown,
  reloadConfig = reloadConfig,
  moveWindowToWestDisplay = moveWindowToWestDisplay,
  moveWindowToEastDisplay = moveWindowToEastDisplay,
  moveWindowToNorthDisplay = moveWindowToNorthDisplay,
  moveWindowToSouthDisplay = moveWindowToSouthDisplay,
  fullScreenWindow = fullScreenWindow,
  centralizeWindow = centralizeWindow,
  applicationShortcutToBundleMapping = applicationShortcutToBundleMapping,
  toggleApplication = toggleApplication,
}
