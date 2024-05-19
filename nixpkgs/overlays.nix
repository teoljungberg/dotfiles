[
  (
    final: prev: {
      hammerspoon = prev.callPackage ./hammerspoon.nix {pkgs = prev;};
      heroku-aarch64-darwin = prev.callPackage ./heroku-aarch64-darwin.nix {pkgs = prev;};
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
