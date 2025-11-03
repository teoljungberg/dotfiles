[
  (final: prev: {
    hammerspoon = prev.callPackage ./hammerspoon.nix { pkgs = prev; };
    knfmt = prev.callPackage ./knfmt.nix { pkgs = prev; };
    nnvim = prev.callPackage ./nnvim.nix { pkgs = prev; };
    ripper-tags = prev.callPackage ./ripper-tags { pkgs = prev; };
    setrb = prev.callPackage ./setrb.nix { pkgs = prev; };
  })
]
