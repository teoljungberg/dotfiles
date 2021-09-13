{ pkgs ? (import <nixpkgs> { })
, ...
}:

let
  key =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK8DmGnZmzOUOlg+gtKuGouRz6wCqy1pwNKvweJ4MCp0 teo@teoljungberg.com";
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
}
