# Copy Text from Quick Look Previews
defaults write iom.apple.finder QLEnableTextSelection -bool TRUE; killall Finder

# Always open everything in Finder's list view. This is important.
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Show the ~/Library folder
chflags nohidden ~/Library

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Disable menu bar transparency
defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Show all filename extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Enable spring loading for all Dock items
defaults write enable-spring-load-actions-on-all-items -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Disable the Ping sidebar in iTunes
defaults write com.apple.iTunes disablePingSidebar -bool true

# Disable all the other Ping stuff in iTunes
defaults write com.apple.iTunes disablePing -bool true
