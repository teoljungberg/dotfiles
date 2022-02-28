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
    {
      darwinConfigurations.Cardamom = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [ ./nixpkgs/darwin-configuration.nix ];
      };
    };
}
