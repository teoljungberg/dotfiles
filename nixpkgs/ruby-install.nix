{
  pkgs ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
  buildEnv ? pkgs.buildEnv,
  gcc ? pkgs.gcc,
  gdbm ? pkgs.gdbm,
  gnugrep ? pkgs.gnugrep,
  gnumake ? pkgs.gnumake,
  libyaml ? pkgs.libyaml,
  makeWrapper ? pkgs.makeWrapper,
  ncurses ? pkgs.ncurses,
  openssl ? pkgs.openssl,
  pkg-config ? pkgs.pkg-config,
  readline ? pkgs.readline,
  zlib ? pkgs.zlib,
}: let
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
    extraOutputsToInstall = ["bin" "include" "lib"];
  };
in
  stdenv.mkDerivation rec {
    pname = "ruby-install";
    version = "0.9.0";

    src = fetchTarball {
      url = "https://github.com/postmodern/ruby-install/archive/v${version}.tar.gz";
      sha256 = "07hy4dmq7cqwl4v2cmf1g072hlbl7z8iiwrlbk8ya7vjphpr8qpn";
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
