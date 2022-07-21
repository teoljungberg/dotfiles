{ pkgs ? import <nixpkgs> { }
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

  system.stateVersion = "22.05";

  system.autoUpgrade.enable = true;
  system.autoUpgrade.channel = "https://nixos.org/channels/nixos-unstable";

  nix = {
    gc = {
      automatic = true;
      dates = "03:00";
    };
    package = pkgs.nixFlakes;
    extraOptions = ''
      extra-experimental-features = nix-command flakes
      keep-derivations = true
      keep-outputs = true
    '';
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    dropbox-cli
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
      allowedTCPPorts = [ 22 ];
      allowedUDPPortRanges = [{ from = 60000; to = 60010; }];
      enable = true;
    };
  };

  security.sudo.wheelNeedsPassword = false;

  services.openssh.enable = true;
  programs.mosh.enable = true;

  services.cron = {
    enable = true;
    systemCronJobs = [
      ''
        30 9 * * *  teo  $HOME/src/github.com/teoljungberg/dotfiles/cron/vim-plugins
      ''
    ];
  };

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
