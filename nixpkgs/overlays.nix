[
  (
    final: prev: {
      hammerspoon = prev.callPackage ./hammerspoon.nix {pkgs = prev;};
      heroku-aarch64-darwin = prev.callPackage ./heroku-aarch64-darwin.nix {pkgs = prev;};
      knfmt = prev.callPackage ./knfmt.nix {pkgs = prev;};
      lim = prev.callPackage ./lim.nix {pkgs = prev;};
      ripper-tags = prev.callPackage ./ripper-tags {pkgs = prev;};
      t-neovim = prev.callPackage ./t-neovim.nix {
        pkgs = prev;
        vimAlias = true;
      };
    }
  )
]
