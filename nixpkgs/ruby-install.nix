{ stdenv ? (import <nixpkgs> { }).stdenv, lib ? (import <nixpkgs> { }).lib
, fetchzip ? (import <nixpkgs> { }).fetchzip, pkgs ? (import <nixpkgs> { }), ...
}:

let
  paths = [
    pkgs.gcc
    pkgs.gdbm
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
in stdenv.mkDerivation {
  pname = "ruby-install";
  version = "0.8.1";

  src = fetchzip {
    url = "https://github.com/postmodern/ruby-install/archive/v0.8.1.tar.gz";
    sha256 = "0d92mdjg7k20sx6wd2ngbblq9m8njv45khnlf8ilc2034mz287kx";
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
