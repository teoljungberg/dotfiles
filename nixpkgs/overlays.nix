[
  (
    self: super: {
      gitsh = super.callPackage ./gitsh.nix { };
      hammerspoon = super.callPackage ./hammerspoon.nix { };
      heroku = super.heroku.overrideAttrs (
        oldAttrs: rec {
          version = "7.59.4";

          src = fetchTarball {
            url = "https://cli-assets.heroku.com/heroku-v${version}/heroku-v${version}.tar.xz";
            sha256 = "1jycndjkmvdn1hxx122krplgh4x9wnsqvq03gi24bb18bfl0dw78";
          };
        }
      );
      lim = super.callPackage ./lim.nix { };
      ruby-install = super.callPackage ./ruby-install.nix { };
      setrb = super.callPackage ./setrb.nix { };
    }
  )
]
