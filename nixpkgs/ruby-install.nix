{ stdenv ? (import <nixpkgs> { }).stdenv, lib ? (import <nixpkgs> { }).lib
, fetchzip ? (import <nixpkgs> { }).fetchzip, pkgs ? (import <nixpkgs> { }), ...
}:

stdenv.mkDerivation {
  pname = "ruby-install";
  version = "0.8.1";

  src = fetchzip {
    url = "https://github.com/postmodern/ruby-install/archive/v0.8.1.tar.gz";
    sha256 = "0d92mdjg7k20sx6wd2ngbblq9m8njv45khnlf8ilc2034mz287kx";
  };

  buildInputs = [
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

  buildPhase = ''
    true
  '';

  installPhase = ''
    make install PREFIX=$out/
    wrapProgram $out/bin/ruby-install \
      --set PKG_CONFIG_PATH "${pkgs.openssl.dev}/lib/pkgconfig" \
      --set CFLAGS "-I${pkgs.libyaml}/include -I${pkgs.ncurses}/include -I${pkgs.openssl.dev}/include -I${pkgs.readline}/include -I${pkgs.zlib}/include" \
      --set LDFLAGS "-L${pkgs.libyaml}/lib -L${pkgs.ncurses}/lib -L${pkgs.openssl.dev}/lib -L${pkgs.readline}/lib -L${pkgs.zlib}/lib" \
      --prefix PATH : "${pkgs.gnumake}/bin" \
      --prefix PATH : "${pkgs.gcc}/bin"
  '';

  meta = with lib; {
    description = "";
    homepage = "";
    license = "";
    platforms = platforms.unix;
  };
}
