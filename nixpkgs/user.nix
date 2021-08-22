{ stdenv ? (import <nixpkgs> { }).stdenv }:

let
  name = "teo";
  fullName = "Teo Ljungberg";
in
{
  user = {
    name = name;
    fullName = fullName;
    directory = if stdenv.isDarwin then "/Users/${name}" else "/home/${name}";
  };
}
