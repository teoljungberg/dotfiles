{ config, pkgs, ... }:

let
  callPackage = pkgs.callPackage;

  hammerspoon = callPackage /Users/teo/src/dotfiles/nixpkgs/hammerspoon.nix { };
in {
  services.nix-daemon.enable = true;

  users.users.teo = {
    home = "/Users/teo";
    description = "Teo Ljungberg";
    shell = pkgs.zsh;
  };

  services.redis = {
    enable = true;
    package = pkgs.redis;
    dataDir = "/Users/teo/.local/share/redis";
  };

  environment.systemPackages = [ hammerspoon ];

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [ ibm-plex ];
  };

  environment = {
    shells = with pkgs; [ zsh ];
    loginShell = "/run/current-system/sw/bin/zsh";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  system.defaults.NSGlobalDomain = {
    AppleKeyboardUIMode = 3;
    InitialKeyRepeat = 15;
    KeyRepeat = 2;

    NSAutomaticCapitalizationEnabled = false;
    NSAutomaticDashSubstitutionEnabled = false;
    NSAutomaticPeriodSubstitutionEnabled = false;
    NSAutomaticQuoteSubstitutionEnabled = false;
    NSAutomaticSpellingCorrectionEnabled = false;
    NSNavPanelExpandedStateForSaveMode = true;
    NSNavPanelExpandedStateForSaveMode2 = true;
    _HIHideMenuBar = false;
  };

  system.defaults.dock = {
    autohide = true;
    orientation = "bottom";
    showhidden = true;
    mru-spaces = false;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  nix.buildCores = 1;
  nix.maxJobs = 4;
}
