[
  (
    self: super: {
      hammerspoon = super.callPackage ./hammerspoon.nix {};
      herokuDarwinArm = super.heroku.overrideAttrs (
        let
          herokuVersion = "8.5.0";
          herokuRef = "350fe16";
        in
          oldAttrs: {
            version = herokuVersion;

            # https://github.com/heroku/homebrew-brew/commit/26afdc76a586ed3ed1a38f41a72133e2ff3a9a05
            src = fetchTarball {
              url = "https://cli-assets.heroku.com/versions/${herokuVersion}/${herokuRef}/heroku-v${herokuVersion}-${herokuRef}-darwin-x64.tar.xz";
              sha256 = "0p0zywy28hpn6a78n4yl1yc44igalfprlhvfp8jx5b178lx6dmk8";
            };
          }
      );
      knfmt = super.callPackage ./knfmt.nix {};
      lim = super.callPackage ./lim.nix {};
      ripper-tags = super.callPackage ./ripper-tags {};
      ruby-install = super.callPackage ./ruby-install.nix {};
      setrb = super.callPackage ./setrb.nix {};
    }
  )
]
