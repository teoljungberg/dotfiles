{pkgs, ...}: let
  overlays = ./../../nixpkgs/overlays.nix;
in {
  imports = [<home-manager/nix-darwin>];

  nixpkgs.overlays = import overlays;

  services.nix-daemon.enable = true;

  users.users.teo = {
    home = "/Users/teo";
    description = "Teo Ljungberg";
    shell = pkgs.zsh;
  };

  environment.systemPackages = [pkgs.hammerspoon];

  fonts = {
    fontDir = {enable = true;};
    fonts = [pkgs.jetbrains-mono];
  };

  environment.shells = [pkgs.zsh];

  networking = {hostName = "Mint";};

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
    settings = {
      cores = 4;
      max-jobs = 8;
    };
    extraOptions = ''
      extra-experimental-features = nix-command flakes
      keep-derivations = true
      keep-outputs = true
    '';
  };

  home-manager.users.teo = {pkgs, ...}: {
    nixpkgs.overlays = import overlays;

    programs.home-manager.enable = true;

    home.homeDirectory = "/Users/teo";
    home.stateVersion = "21.11";
    home.username = "teo";

    home.packages = with pkgs; [
      alejandra
      autoconf
      automake
      bat
      fzf
      git
      gitAndTools.gh
      gitAndTools.hub
      gnupg
      heroku-aarch64-darwin
      jq
      knfmt
      lim
      mosh
      pgformatter
      pkg-config
      rcm
      ripgrep
      ripper-tags
      s3cmd
      shellcheck
      shfmt
      stylua
      t-neovim
      tailscale
      tmux
      universal-ctags
      vim-vint
      zsh
    ];

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
