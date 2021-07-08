{ pkgs ? (import <nixpkgs> { })
, stdenv ? (import <nixpkgs> { }).stdenv
, lib ? (import <nixpkgs> { }).lib
, fetchzip ? (import <nixpkgs> { }).fetchzip
, ...
}:

let
  paths = [
    pkgs.gcc
    pkgs.gdbm
    pkgs.gnugrep
    pkgs.gnumake
    pkgs.libyaml
    pkgs.makeWrapper
    pkgs.ncurses
    pkgs.openssl.dev
    pkgs.pkg-config
    pkgs.readline
    pkgs.zlib
  ];
  env = pkgs.buildEnv {
    name = "ruby-install-env";
    paths = paths;
    extraOutputsToInstall = [ "bin" "include" "lib" ];
  };
in
stdenv.mkDerivation {
  pname = "ruby-install";
  version = "0.8.2";

  src = fetchzip {
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

  meta = with lib; {
    description = "";
    homepage = "";
    license = "";
    platforms = platforms.unix;
  };
}
