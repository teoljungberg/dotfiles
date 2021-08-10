{ buildEnv ? (import <nixpkgs> { }).buildEnv
, fetchzip ? (import <nixpkgs> { }).fetchzip
, gcc ? (import <nixpkgs> { }).gcc
, gdbm ? (import <nixpkgs> { }).gdbm
, gnugrep ? (import <nixpkgs> { }).gnugrep
, gnumake ? (import <nixpkgs> { }).gnumake
, lib ? (import <nixpkgs> { }).lib
, libyaml ? (import <nixpkgs> { }).libyaml
, makeWrapper ? (import <nixpkgs> { }).makeWrapper
, ncurses ? (import <nixpkgs> { }).ncurses
, openssl ? (import <nixpkgs> { }).openssl
, pkg-config ? (import <nixpkgs> { }).pkg-config
, readline ? (import <nixpkgs> { }).readline
, stdenv ? (import <nixpkgs> { }).stdenv
, zlib ? (import <nixpkgs> { }).zlib
}:

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
  ];
  env = buildEnv {
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
