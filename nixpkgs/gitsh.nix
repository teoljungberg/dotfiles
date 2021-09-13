{ pkgs ? (import <nixpkgs> { })
, fetchurl ? pkgs.fetchurl
, lib ? pkgs.lib
, readline ? pkgs.readline
, ruby ? pkgs.ruby
, stdenv ? pkgs.stdenv
}:

stdenv.mkDerivation rec {
  name = "gitsh-${version}";
  version = "0.14.0";

  src = fetchurl {
    url = "https://github.com/thoughtbot/gitsh/releases/download/v0.14/gitsh-0.14.tar.gz";
    sha256 = "0981knqnn5xdi8x67qizgldvcza79rcl1r68qibpnsij0v8bd2ab";
  };

  buildInputs = [ readline ruby ];

  meta = {
    description = "interactive shell for git";
    license = lib.licenses.bsd3;
    homepage = "https://github.com/thoughtbot/gitsh";
    platforms = lib.platforms.unix;
  };
}
