local helper = require("helper")
local ipc = require("hs.ipc")

hs.window.animationDuration = 0

hs.hotkey.bind({ "shift", "ctrl" }, "h", helper.moveLeft)
hs.hotkey.bind({ "shift", "ctrl" }, "l", helper.moveRight)
hs.hotkey.bind({ "shift", "ctrl" }, "k", helper.moveUp)
hs.hotkey.bind({ "shift", "ctrl" }, "j", helper.moveDown)
hs.hotkey.bind({ "cmd", "ctrl" }, "h", helper.moveWindowLeftHalfScreen)
hs.hotkey.bind({ "cmd", "ctrl" }, "l", helper.moveWindowRightHalfScreen)
hs.hotkey.bind({ "cmd", "shift", "ctrl" }, "h", helper.resizeLeft)
hs.hotkey.bind({ "cmd", "shift", "ctrl" }, "l", helper.resizeRight)
hs.hotkey.bind({ "cmd", "shift", "ctrl" }, "k", helper.resizeUp)
hs.hotkey.bind({ "cmd", "shift", "ctrl" }, "j", helper.resizeDown)
hs.hotkey.bind({ "cmd", "shift", "ctrl" }, "r", helper.reloadConfig)
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "h", helper.moveWindowToWestDisplay)
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "l", helper.moveWindowToEastDisplay)
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "k", helper.moveWindowToNorthDisplay)
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "j", helper.moveWindowToSouthDisplay)
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "f", helper.fullScreenWindow)
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "o", helper.moveWindowLeftTwoThirdsScreen)
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "p", helper.moveWindowRightTwoThirdsScreen)
hs.hotkey.bind({ "cmd", "shift", "ctrl" }, "c", helper.centralizeWindow)

for key, bundleID in pairs(helper.applicationShortcutToBundleMapping) do
  if bundleID then
    hs.hotkey.bind(
      { "shift", "ctrl" },
      tostring(key),
      helper.toggleApplication(bundleID)
    )
  end
end

ipc.cliColors({ error = "", initial = "", output = "", input = "" })

helper.setupMouseFollowsFocus()

local function file_exists(name)
  local file = io.open(name, "r")
  if file then io.close(file) end
  return file ~= nil
end

local local_init = (os.getenv("HOME") or "~") .. "/.hammerspoon/init.local.lua"
if file_exists(local_init) then
  dofile(local_init)
end
