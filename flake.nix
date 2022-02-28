{
  description = "teoljungberg's system";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, darwin, nixpkgs, home-manager, ... } @inputs:
    let
      nixpkgsConfig = {
        config = { allowUnfree = true; };
        overlays = import ./config/nixpkgs/overlays.nix;
      };
    in
    {
      darwinConfigurations."one" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
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
    };
}
