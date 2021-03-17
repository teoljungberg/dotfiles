functions = require "functions"

hs.window.animationDuration = 0

hs.hotkey.bind({"shift", "ctrl"}, "l", functions.moveLeft)
hs.hotkey.bind({"shift", "ctrl"}, "h", functions.moveRight)
hs.hotkey.bind({"shift", "ctrl"}, "k", functions.moveUp)
hs.hotkey.bind({"shift", "ctrl"}, "j", functions.moveDown)
hs.hotkey.bind({"cmd", "ctrl"}, "h", functions.moveWindowLeftHalfScreen)
hs.hotkey.bind({"cmd", "ctrl"}, "l", functions.moveWindowRightHalfScreen)
hs.hotkey.bind({"cmd", "shift", "ctrl"}, "h", functions.resizeLeft)
hs.hotkey.bind({"cmd", "shift", "ctrl"}, "l", functions.resizeRight)
hs.hotkey.bind({"cmd", "shift", "ctrl"}, "k", functions.resizeUp)
hs.hotkey.bind({"cmd", "shift", "ctrl"}, "j", functions.resizeDown)
hs.hotkey.bind({"cmd", "shift", "ctrl"}, "r", functions.reloadConfig)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "h", functions.moveWindowToWestDisplay)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "l", functions.moveWindowToEastDisplay)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "k", functions.moveWindowToNorthDisplay)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "j", functions.moveWindowToSouthDisplay)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "f", functions.fullScreenWindow)
hs.hotkey.bind({"cmd", "shift", "ctrl"}, "c", functions.centralizeWindow)

for key, bundleID in pairs(functions.applicationShortcutToBundleMapping()) do
  if bundleID then
    hs.hotkey.bind({"shift", "ctrl"}, tostring(key), functions.toggleApplication(bundleID))
  end
end
