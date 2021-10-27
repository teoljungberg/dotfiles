[
  (self: super: { awscli2 = super.awscli2.overrideAttrs (oldAttrs: { checkPhase = ""; }); })
  (self: super: { comma = super.callPackage ./../../nixpkgs/comma.nix { }; })
  (self: super: { diff-highlight = super.callPackage ./../../nixpkgs/diff-highlight.nix { }; })
  (self: super: { gitsh = super.callPackage ./../../nixpkgs/gitsh.nix { }; })
  (self: super: { ruby-install = super.callPackage ./../../nixpkgs/ruby-install.nix { }; })
  (self: super: { setrb = super.callPackage ./../../nixpkgs/setrb.nix { }; })
]
