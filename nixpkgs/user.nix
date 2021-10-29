{ pkgs ? (import <nixpkgs> { })
, stdenv ? pkgs.stdenv
}:

let
  name = "teo";
  fullName = "Teo Ljungberg";
  directory =
    if stdenv.isDarwin then
      "/Users/${name}"
    else
      "/home/${name}";
in
{
  user = {
    name = name;
    fullName = fullName;
    directory = directory;
  };
}
