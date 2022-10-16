let
  pkgs = (
    import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/refs/tags/22.05.tar.gz") { }
  );
  key =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK8DmGnZmzOUOlg+gtKuGouRz6wCqy1pwNKvweJ4MCp0 teo@teoljungberg.com";
in
rec
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
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      extra-experimental-features = nix-command flakes
      keep-derivations = true
      keep-outputs = true
    '';
  };

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
      allowedTCPPorts = [ 22 ];
      allowedUDPPortRanges = [{ from = 60000; to = 60010; }];
      enable = true;
    };
  };

  time.timeZone = "Europe/Stockholm";

  security.sudo.wheelNeedsPassword = false;

  programs.mosh.enable = true;

  services.cron.enable = true;
  services.do-agent.enable = true;
  services.openssh.enable = true;

  virtualisation.docker.enable = true;

  users.users.root.openssh.authorizedKeys.keys = [ key ];

  users.users.teo = {
    isNormalUser = true;
    home = "/home/teo";
    name = "teo";
    description = "Teo Ljungberg";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "docker" ];
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

  systemd.services = {
    update-vim-plugins = {
      path = with pkgs; [ bash findutils git openssh ];
      script = builtins.readFile ../../bin/update-vim-plugins;
      serviceConfig = { User = users.users.teo.name; };
      startAt = "daily";
    };

    backups =
      let
        backupsDirectory = users.users.teo.home +
          "/src/github.com/teoljungberg/backups/";
        backupsEnabled = builtins.pathExists backupsDirectory;
      in
      {
        path = with pkgs; [ bash findutils git nettools openssh ];
        enable = backupsEnabled;
        script =
          if backupsEnabled then
            builtins.readFile (backupsDirectory + "run.sh")
          else
            "";
        serviceConfig = { User = users.users.teo.name; };
        startAt = "daily";
      };
  };
}
