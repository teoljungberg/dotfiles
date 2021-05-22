{ stdenv ? (import <nixpkgs> { }).stdenv, lib ? (import <nixpkgs> { }).lib }:
let
  name = "teo";
  fullName = "Teo Ljungberg";
in rec {
  user = {
    name = name;
    fullName = fullName;
    directory = if stdenv.isDarwin then "/Users/${name}" else "/home/${name}";
  };
}
