{ pkgs ? import <nixpkgs> { }
, ...
}:

let
  user = import ./user.nix { };
in
{
  nixpkgs.overlays = import <t-nixpkgs/overlays.nix>;

  services.nix-daemon.enable = true;

  users.users.teo = {
    home = user.directory;
    description = user.fullName;
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [ hammerspoon ];

  fonts = {
    fontDir = { enable = true; };
    fonts = with pkgs; [ jetbrains-mono ];
  };

  environment = {
    shells = with pkgs; [ zsh ];
    loginShell = "/run/current-system/sw/bin/zsh";
  };

  networking = { hostName = "Shiso"; };

  programs.zsh = {
    enable = true;
    enableCompletion = false;
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

  nix = {
    buildCores = 4;
    maxJobs = 8;
    extraOptions = ''
      extra-experimental-features = nix-command flakes
      keep-derivations = true
      keep-outputs = true
    '';
  };
}
