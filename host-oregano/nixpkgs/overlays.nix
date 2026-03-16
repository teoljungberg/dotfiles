[
  (final: prev: {
    knfmt = prev.callPackage ./knfmt.nix { pkgs = prev; };
    ripper-tags = prev.callPackage ./ripper-tags { pkgs = prev; };
  })
]
