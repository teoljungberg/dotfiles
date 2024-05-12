[
  (
    final: prev: {
      hammerspoon = prev.callPackage ./hammerspoon.nix {pkgs = prev;};
      herokuDarwinArm = prev.heroku.overrideAttrs (
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
      knfmt = prev.callPackage ./knfmt.nix {pkgs = prev;};
      lim = prev.callPackage ./lim.nix {pkgs = prev;};
      ripper-tags = prev.callPackage ./ripper-tags {pkgs = prev;};
      ruby-install = prev.callPackage ./ruby-install.nix {pkgs = prev;};
      tmux = prev.tmux.overrideAttrs (
        let
          tmuxVersion = "3.4";
        in
          oldAttrs: {
            version = tmuxVersion;
            patches = [];

            src = fetchTarball {
              url = "https://github.com/tmux/tmux/releases/download/${tmuxVersion}/tmux-${tmuxVersion}.tar.gz";
              sha256 = "0dk15lcs0d2p9xp2g3f8ca3fldd37ib4ck9spzb4v8q0gwmrpw4n";
            };
          }
      );
    }
  )
]
