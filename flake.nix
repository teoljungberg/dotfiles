{
  description = "teoljungberg's system";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    darwin.url = github:lnl7/nix-darwin/master;
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, darwin, nixpkgs, home-manager, ... }@inputs:
    let
      nixpkgsConfig = {
        config = { allowUnfree = true; };
        overlays = import ./config/nixpkgs/overlays.nix;
      };
    in
    rec {
      cardamom = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          ./nixpkgs/darwin-configuration.nix
          home-manager.darwinModules.home-manager
          {
            nixpkgs = nixpkgsConfig;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.teo = import ./config/nixpkgs/home.nix;
          }
        ];
      };
      # vanilla = {};
      defaultPackage.x86_64-darwin = cardamom.system;
      # defaultPackage.x86_64-linux = vanilla.system;
    };
}
