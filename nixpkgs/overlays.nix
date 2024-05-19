[
  (
    final: prev: {
      hammerspoon = prev.callPackage ./hammerspoon.nix {pkgs = prev;};
      herokuDarwinArm = prev.heroku.overrideAttrs (
        let
          # https://github.com/heroku/homebrew-brew/commit/3b6ca6a88b49e47a0fd7625eff10a2475ac7e1a4
          version = "8.11.5";
          url = "https://cli-assets.heroku.com/versions/8.11.5/df5cd30/heroku-v8.11.5-df5cd30-darwin-x64.tar.xz";
          sha256 = "1g6lbxgff3d3n05dwrdlm94kf5jsim6jxdxzf1qmhzq8agnc1wd0";
        in
          oldAttrs: {
            inherit version;

            src = fetchTarball {inherit url sha256;};
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
