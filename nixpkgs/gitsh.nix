{
  pkgs ? import <nixpkgs> {},
  lib ? pkgs.lib,
  stdenv ? pkgs.stdenv,
  readline ? pkgs.readline,
  ruby ? pkgs.ruby,
}: let
  version = "0.14.0";
in
  stdenv.mkDerivation {
    name = "gitsh-${version}";
    inherit version;

    src = fetchTarball {
      url = "https://github.com/thoughtbot/gitsh/releases/download/v0.14/gitsh-0.14.tar.gz";
      sha256 = "1rjvhz4bk0qvgc7s4j4fhwy5qa612z82bkxsjn982qxs4lky2m0g";
    };

    buildInputs = [readline ruby];

    meta = {
      description = "interactive shell for git";
      license = lib.licenses.bsd3;
      homepage = "https://github.com/thoughtbot/gitsh";
      platforms = lib.platforms.unix;
    };
  }
