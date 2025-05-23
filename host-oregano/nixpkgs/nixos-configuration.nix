{ pkgs, ... }:
let
  lib = pkgs.lib;

  overlays = ./../../nixpkgs/overlays.nix;
  key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK8DmGnZmzOUOlg+gtKuGouRz6wCqy1pwNKvweJ4MCp0 teo@teoljungberg.com";
in
{
  imports = [
    /etc/nixos/hardware-configuration.nix
    <nixpkgs/nixos/modules/profiles/headless.nix>
    <home-manager/nixos>
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  boot.kernel.sysctl."net.ipv6.conf.all.forwarding" = 1;

  networking = {
    hostName = "oregano";
    nameservers = [ "1.1.1.1" ];
    usePredictableInterfaceNames = true;

    firewall = {
      allowPing = true;
      allowedTCPPorts = [ 22 ];
      allowedUDPPortRanges = [
        {
          from = 60000;
          to = 60010;
        }
      ];
      checkReversePath = "loose";
      enable = true;
    };
  };

  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  environment.systemPackages = with pkgs; [
    git
    gnumake
    vim
    zsh
  ];
  environment.shells = [ pkgs.zsh ];

  users.users.teo = {
    isNormalUser = true;
    home = "/home/teo";
    name = "teo";
    description = "Teo Ljungberg";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [ key ];
  };

  users.users.upload = {
    isNormalUser = true;
    home = "/home/upload";
    description = "Upload";
    name = "upload";
    shell = pkgs.zsh;
    extraGroups = [ "users" ];
    openssh.authorizedKeys.keys = [ key ];
  };

  users.users.root.openssh.authorizedKeys.keys = [ key ];

  services.journald.extraConfig = ''
    MaxRetentionSec=1month
  '';

  systemd.services = {
    backups =
      let
        backupsDirectory = "/home/teo/src/github.com/teoljungberg/backups/";
      in
      lib.mkIf (builtins.pathExists backupsDirectory) {
        path = with pkgs; [
          bash
          findutils
          git
          nettools
          openssh
        ];
        script = "sh ${backupsDirectory}/run.sh";
        serviceConfig = {
          User = "teo";
        };
        startAt = "daily";
      };

    update-vim-plugins =
      let
        dotfilesDirectory = "/home/teo/src/github.com/teoljungberg/dotfiles/";
      in
      lib.mkIf (builtins.pathExists dotfilesDirectory) {
        path = with pkgs; [
          bash
          findutils
          git
          openssh
        ];
        script = "sh ${dotfilesDirectory}/bin/update-vim-plugins";
        serviceConfig = {
          User = "teo";
        };
        startAt = "daily";
      };
  };

  nix = {
    gc = {
      automatic = true;
      dates = "03:00";
    };
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      extra-experimental-features = nix-command flakes
      keep-derivations = true
      keep-outputs = true
    '';
    settings.trusted-users = [
      "root"
      "teo"
    ];
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = import overlays;

  security.sudo.wheelNeedsPassword = false;

  security.doas = {
    enable = true;
    wheelNeedsPassword = false;
    extraConfig = ''
      permit nopass keepenv teo as root
    '';
  };

  services.cron.enable = true;
  services.openssh.enable = true;
  services.tailscale.enable = true;

  programs.mosh.enable = true;
  programs.zsh.enable = true;

  system.autoUpgrade.channel = "https://nixos.org/channels/nixos-24.05";
  system.autoUpgrade.enable = true;
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It’s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  home-manager.users.teo =
    { pkgs, ... }:
    let
      vim = pkgs.vim_configurable.override {
        config.vim.gui = false;
      };
    in
    {
      nixpkgs.overlays = import overlays;
      nixpkgs.config.allowUnfree = true;

      programs.home-manager.enable = true;

      home.homeDirectory = "/home/teo";
      home.stateVersion = "21.11";
      home.username = "teo";

      home.packages = with pkgs; [
        _1password-cli
        autoconf
        automake
        comma
        fzf
        git
        gitAndTools.gh
        gitAndTools.hub
        gitAndTools.hut
        gnumake
        gnupg
        jq
        mosh
        neovim
        nixfmt-rfc-style
        pgformatter
        pkg-config
        rclone
        rcm
        ripgrep
        ripper-tags
        s3cmd
        shellcheck
        shfmt
        tmux
        universal-ctags
        vim
        vim-vint
        wget
        zsh
      ];

      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
}
