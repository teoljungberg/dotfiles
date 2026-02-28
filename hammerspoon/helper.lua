local M = {}
local mouseFollowsFocus = require("mouse_follows_focus")
local numberOfCells = 32

function M.setupMouseFollowsFocus()
  mouseFollowsFocus.setup()
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
  return function()
    local front = hs.application.frontmostApplication()
    if front and front:bundleID() == bundleID then
      local unsuppress = mouseFollowsFocus.suppress()
      front:hide()
      hs.timer.doAfter(0.15, unsuppress)
    else
      hs.application.launchOrFocusByBundleID(bundleID)
      mouseFollowsFocus.focusWindow()
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
    ["c"] = "com.anthropic.claudefordesktop",
    ["m"] = "org.vim.MacVim",
    ["n"] = "com.apple.Notes",
  }
end

return M
