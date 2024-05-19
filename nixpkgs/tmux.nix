{pkgs ? (import <nixpkgs> {})}: let
  version = "3.4";
  src = fetchTarball {
    url = "https://github.com/tmux/tmux/releases/download/${version}/tmux-${version}.tar.gz";
    sha256 = "0dk15lcs0d2p9xp2g3f8ca3fldd37ib4ck9spzb4v8q0gwmrpw4n";
  };
in
  pkgs.tmux.overrideAttrs (oldAttrs: {
    inherit version src;
    patches = [];
  })
