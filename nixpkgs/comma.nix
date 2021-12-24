{ pkgs ? (import <nixpkgs> { })
, fetchFromGitHub ? pkgs.fetchFromGitHub
}:

let
  comma = fetchFromGitHub {
    owner = "nix-community";
    repo = "comma";
    rev = "1.1.0";
    sha256 = "WBIQmwlkb/GMoOq+Dnyrk8YmgiM/wJnc5HYZP8Uw72E=";
  };
in
import comma { }
