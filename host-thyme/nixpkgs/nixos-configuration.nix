let
  pkgs = (
    import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/refs/heads/release-22.11.tar.gz") { }
  );
  lib = pkgs.lib;

  ipv4Address = "46.23.91.116";
  ipv4Gateway = "46.23.91.65";
  ipv6Address = "2a03:6000:6a00:641::116";
  ipv6Gateway = "2a03:6000:6a00:641::1";

  key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK8DmGnZmzOUOlg+gtKuGouRz6wCqy1pwNKvweJ4MCp0 teo@teoljungberg.com";
in
rec
{
  imports = [
    /etc/nixos/hardware-configuration.nix
    <nixpkgs/nixos/modules/profiles/minimal.nix>
    <nixpkgs/nixos/modules/profiles/headless.nix>
  ];

  boot = {
    loader.grub = {
      device = "/dev/vda";
      extraConfig = ''
        serial --speed=115200 --unit=0 --word=8 --parity=no --stop=1
        terminal_input console
        terminal_output console
      '';
    };
    cleanTmpDir = true;
    kernelParams = [ "console=ttyS0,115200n8" ];
  };

  networking = {
    hostName = "thyme";
    nameservers = [ "1.1.1.1" ];
    usePredictableInterfaceNames = true;

    dhcpcd.enable = false;

    interfaces.eth0 = {
      ipv4.addresses = [
        { address = "${ipv4Address}"; prefixLength = 26; }
      ];
      ipv6.addresses = [
        { address = "${ipv6Address}"; prefixLength = 64; }
      ];
    };
    defaultGateway = { address = "${ipv4Gateway}"; interface = "eth0"; };
    defaultGateway6 = { address = "${ipv6Gateway}"; interface = "eth0"; };

    firewall = {
      allowPing = true;
      allowedTCPPorts = [ 22 ];
      allowedUDPPortRanges = [{ from = 60000; to = 60010; }];
      enable = true;
    };
  };

  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

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
    "serial-getty@ttyS0" = {
      enable = true;
      wantedBy = [ "getty.target" ];
      serviceConfig.Restart = "always";
    };

    update-vim-plugins =
      let
        dotfilesDirectory = users.users.teo.home +
          "/src/github.com/teoljungberg/dotfiles/";
        updateVimPluginsEnabled = builtins.pathExists dotfilesDirectory;
      in
      lib.mkIf updateVimPluginsEnabled {
        path = with pkgs; [ bash findutils git openssh ];
        script = builtins.readFile (dotfilesDirectory + "bin/update-vim-plugins");
        serviceConfig = { User = users.users.teo.name; };
        startAt = "daily";
      };

    backups =
      let
        backupsDirectory = users.users.teo.home +
          "/src/github.com/teoljungberg/backups/";
        backupsEnabled = builtins.pathExists backupsDirectory;
      in
      lib.mkIf backupsEnabled {
        path = with pkgs; [ bash findutils git nettools openssh ];
        script = builtins.readFile (backupsDirectory + "run.sh");
        serviceConfig = { User = users.users.teo.name; };
        startAt = "daily";
      };
  };

  environment.systemPackages = with pkgs; [
    binutils
    git
    home-manager
    rcm
    vim
    zsh
  ];
  environment.shells = [ pkgs.zsh ];

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
    settings.trusted-users = [ "root" "teo" ];
  };

  nixpkgs.config.allowUnfree = true;

  security.sudo.wheelNeedsPassword = false;

  security.doas = {
    enable = true;
    wheelNeedsPassword = false;
    extraConfig = ''
      permit nopass keepenv teo as root
    '';
  };

  programs.mosh.enable = true;

  services.cron.enable = true;
  services.openssh.enable = true;

  system.autoUpgrade.channel = "https://nixos.org/channels/nixos-unstable";
  system.autoUpgrade.enable = true;
  system.copySystemConfiguration = true;

  # don't touch this
  system.stateVersion = "22.11";
}
