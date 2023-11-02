[
  (
    self: super: {
      gitsh = super.callPackage ./gitsh.nix {};
      hammerspoon = super.callPackage ./hammerspoon.nix {};
      heroku = super.heroku.overrideAttrs (
        oldAttrs: {
          version = "8.1.5";

          src = fetchTarball {
            url = "https://cli-assets.heroku.com/channels/stable/heroku-darwin-arm64.tar.gz";
            sha256 = "03vjz4663dv9a4kkfkv4x04dsidw6j0icxdp716ngl2k2w46f4ww";
          };
        }
      );
      lim = super.callPackage ./lim.nix {};
      ripper-tags = super.callPackage ./ripper-tags {};
      ruby-install = super.callPackage ./ruby-install.nix {};
      setrb = super.callPackage ./setrb.nix {};
    }
  )
]
