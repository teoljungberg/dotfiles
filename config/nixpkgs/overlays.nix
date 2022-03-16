[
  (
    self: super: {
      diff-highlight = super.callPackage ./../../nixpkgs/diff-highlight.nix { };
      gitsh = super.callPackage ./../../nixpkgs/gitsh.nix { };
      hammerspoon = super.callPackage ./../../nixpkgs/hammerspoon.nix { };
      heroku = super.heroku.overrideAttrs (
        oldAttrs: rec {
          version = "7.59.4";

          src = fetchTarball {
            url = "https://cli-assets.heroku.com/heroku-v${version}/heroku-v${version}.tar.xz";
            sha256 = "1jycndjkmvdn1hxx122krplgh4x9wnsqvq03gi24bb18bfl0dw78";
          };
        }
      );
      lim = super.callPackage ./../../nixpkgs/lim.nix { };
      ruby-install = super.callPackage ./../../nixpkgs/ruby-install.nix { };
      setrb = super.callPackage ./../../nixpkgs/setrb.nix { };
    }
  )
]
