[
  (self: super: { comma = super.callPackage ./../../nixpkgs/comma.nix { }; })
  (self: super: { diff-highlight = super.callPackage ./../../nixpkgs/diff-highlight.nix { }; })
  (self: super: { gitsh = super.callPackage ./../../nixpkgs/gitsh.nix { }; })
  (self: super: {
    heroku = super.heroku.overrideAttrs (
      oldAttrs: rec {
        version = "7.59.1";

        src = fetchTarball {
          url = "https://cli-assets.heroku.com/heroku-v${version}/heroku-v${version}.tar.xz";
          sha256 = "0xfd0smdj19m6knq6sbzjw8iy8sjxaq8frw25mij27gqvdhxfjsp";
        };
      }
    );
  })
  (self: super: { ruby-install = super.callPackage ./../../nixpkgs/ruby-install.nix { }; })
  (self: super: { setrb = super.callPackage ./../../nixpkgs/setrb.nix { }; })
]
