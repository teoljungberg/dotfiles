{ config, pkgs, ... }:

let
  callPackage = pkgs.callPackage;

  user = import ./user.nix;

  hammerspoon = callPackage ./hammerspoon.nix { };
in {
  services.nix-daemon.enable = false;

  users.users.teo = {
    home = user.user.directory;
    description = user.user.fullName;
    shell = pkgs.zsh;
  };

  services.redis = {
    enable = true;
    package = pkgs.redis;
    dataDir = "${user.user.directory}/.local/share/redis";
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

  networking = {
    hostName = "Cardamom";
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
    _HIHideMenuBar = true;
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
