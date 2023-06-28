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
  version = "0.9.1";
in
  stdenv.mkDerivation {
    pname = "ruby-install";
    inherit version;

    src = fetchTarball {
      url = "https://github.com/postmodern/ruby-install/archive/v${version}.tar.gz";
      sha256 = "0s0pzs7dk34lnlrjrmq9rdr4b209vck90qrpd59r1ykh7rwl8q8y";
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
