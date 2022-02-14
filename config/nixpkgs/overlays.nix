[
  (
    self: super: {
      diff-highlight = super.callPackage ./../../nixpkgs/diff-highlight.nix { };
      gitsh = super.callPackage ./../../nixpkgs/gitsh.nix { };
      hammerspoon = super.callPackage ./../../nixpkgs/hammerspoon.nix { };
      heroku = super.heroku.overrideAttrs (
        oldAttrs: rec {
          version = "7.59.2";

          src = fetchTarball {
            url = "https://cli-assets.heroku.com/heroku-v${version}/heroku-v${version}.tar.xz";
            sha256 = "0qj651gikw8c80pn6z44pzm7r5hhc58cgdvgbqlqwz5bw76ii88f";
          };
        }
      );
      ruby-install = super.callPackage ./../../nixpkgs/ruby-install.nix { };
      setrb = super.callPackage ./../../nixpkgs/setrb.nix { };
    }
  )
]
