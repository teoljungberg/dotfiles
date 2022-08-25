{ pkgs ? import <nixpkgs> { }, buildEnv ? pkgs.buildEnv, gcc ? pkgs.gcc
, gdbm ? pkgs.gdbm, gnugrep ? pkgs.gnugrep, gnumake ? pkgs.gnumake
, libyaml ? pkgs.libyaml, makeWrapper ? pkgs.makeWrapper, ncurses ? pkgs.ncurses
, openssl ? pkgs.openssl, pkg-config ? pkgs.pkg-config, readline ? pkgs.readline
, stdenv ? pkgs.stdenv, zlib ? pkgs.zlib }:

let
  paths = [
    gcc
    gdbm
    gnugrep
    gnumake
    libyaml
    makeWrapper
    ncurses
    openssl.dev
    pkg-config
    readline
    zlib
    zlib.dev
  ];
  env = buildEnv {
    name = "ruby-install-env";
    paths = paths;
    extraOutputsToInstall = [ "bin" "include" "lib" ];
  };
in stdenv.mkDerivation {
  pname = "ruby-install";
  version = "0.8.2";

  src = fetchTarball {
    url = "https://github.com/postmodern/ruby-install/archive/v0.8.2.tar.gz";
    sha256 = "0nvw77lhc350ax7bq6yh8501x1yxv2qvzr7qkazsqsz8fgsff485";
  };

  buildInputs = paths;

  buildPhase = ''
    true
  '';

  installPhase = ''
    make install PREFIX=$out/ SHELL=${stdenv.shell}
    wrapProgram $out/bin/ruby-install \
      --set PKG_CONFIG_PATH "${env}/lib/pkgconfig" \
      --set CFLAGS "-I${env}/include" \
      --set LDFLAGS "-L${env}/lib" \
      --prefix PATH : "${env}/bin"
  '';
}
