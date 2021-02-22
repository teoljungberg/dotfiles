require "functions"

hs.hotkey.bind({"shift", "ctrl"}, "l", moveLeft)
hs.hotkey.bind({"shift", "ctrl"}, "h", moveRight)
hs.hotkey.bind({"shift", "ctrl"}, "k", moveUp)
hs.hotkey.bind({"shift", "ctrl"}, "j", moveDown)
hs.hotkey.bind({"cmd", "ctrl"}, "h", moveWindowLeftHalfScreen)
hs.hotkey.bind({"cmd", "ctrl"}, "l", moveWindowRightHalfScreen)
hs.hotkey.bind({"cmd", "shift", "ctrl"}, "h", resizeLeft)
hs.hotkey.bind({"cmd", "shift", "ctrl"}, "l", resizeRight)
hs.hotkey.bind({"cmd", "shift", "ctrl"}, "k", resizeUp)
hs.hotkey.bind({"cmd", "shift", "ctrl"}, "j", resizeDown)
hs.hotkey.bind({"cmd", "shift", "ctrl"}, "r", reloadConfig)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "h", moveWindowToWestDisplay)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "l", moveWindowToEastDisplay)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "k", moveWindowToNorthDisplay)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "j", moveWindowToSouthDisplay)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "f", fullScreenWindow)
hs.hotkey.bind({"cmd", "shift", "ctrl"}, "c", centralizeWindow)

for key, bundleID in pairs(applicationShortcutToBundleMapping) do
  if bundleID then
    hs.hotkey.bind({"shift", "ctrl"}, tostring(key), toggleApplication(bundleID))
  end
end
