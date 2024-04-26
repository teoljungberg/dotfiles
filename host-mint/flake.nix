{
  description = "teo@mint";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    darwin.url = "github:LnL7/nix-darwin";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, darwin, ... }: rec {
    darwinConfigurations.mint = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./nixpkgs/darwin-configuration.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.teo = import ./nixpkgs/home.nix;
        }
      ];
    };
    packages.aarch64-darwin.default = darwinConfigurations.mint.system;
  };
}
