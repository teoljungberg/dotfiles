{ pkgs ? (import <nixpkgs> { })
, lib ? (import <nixpkgs> { }).lib
}:

let
  key =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK8DmGnZmzOUOlg+gtKuGouRz6wCqy1pwNKvweJ4MCp0 teo@teoljungberg.com";
  tarsnapConfig = {
    archives = {
      teo = {
        name = "teo";
        cachedir = "/home/teo/.cache/tarsnap";
        keyfile = "/home/teo/tarsnap.key";
        directories = [ "/home/teo/backup" ];
      };

      upload = {
        name = "upload";
        cachedir = "/home/upload/.cache/tarsnap";
        keyfile = "/home/upload/tarsnap.key";
        directories = [ "/home/upload/backup" ];
      };
    };
  };
  tarsnapBackup = tarsnap: archive: ''
    ${tarsnap}/bin/tarsnap \
      --keyfile ${archive.keyfile} \
      --cachedir ${archive.cachedir} \
      -cf ${archive.name}-$(date +%Y%m%d%H%M%S) \
      ${lib.concatStringsSep " " archive.directories}
  '';
in
{
  imports = [
    /etc/nixos/hardware-configuration.nix
    /etc/nixos/networking.nix # generated at runtime by nixos-infect
  ];

  system.autoUpgrade.enable = true;
  system.autoUpgrade.channel = "https://nixos.org/channels/nixos-unstable";

  nix.gc.automatic = true;
  nix.gc.dates = "03:00";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    home-manager
    rcm
    tarsnap
    vim
    zsh
  ];
  environment.shells = [ pkgs.zsh ];

  boot.cleanTmpDir = true;

  networking = {
    hostName = "vanilla";
    nameservers = [ "8.8.8.8" ];
    firewall = {
      allowPing = true;
      enable = true;
      allowedTCPPorts = [ 22 ];
    };
  };

  security.sudo.wheelNeedsPassword = false;

  services.openssh.enable = true;

  virtualisation.docker.enable = true;

  users.users.root.openssh.authorizedKeys.keys = [ key ];

  users.users.teo = {
    isNormalUser = true;
    home = "/home/teo";
    description = "Teo Ljungberg";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "docker" ];
    openssh.authorizedKeys.keys = [ key ];
  };

  users.users.upload = {
    isNormalUser = true;
    home = "/home/upload";
    description = "Upload";
    shell = pkgs.zsh;
    extraGroups = [ "users" ];
    openssh.authorizedKeys.keys = [ key ];
  };

  services.cron = {
    enable = true;
    systemCronJobs = [
      "5 */1 * * * ${tarsnapBackup pkgs.tarsnap tarsnapConfig.archives.teo}"
      "5 */1 * * * ${tarsnapBackup pkgs.tarsnap tarsnapConfig.archives.upload}"
    ];
  };
}
