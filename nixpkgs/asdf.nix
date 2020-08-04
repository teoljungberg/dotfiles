{ stdenv ? (import <nixpkgs> { }).stdenv
, fetchzip ? (import <nixpkgs> { }).fetchzip }:

stdenv.mkDerivation {
  pname = "asdf";
  version = "0.8.0-rc1";

  src = fetchzip {
    url = "https://github.com/asdf-vm/asdf/archive/v0.8.0-rc1.tar.gz";
    sha256 = "1ycv7knjlf169y742bgpvv88apj03yp58yva2y4dycp2rf0196is";
  };

  installPhase = ''
    mkdir -p $out/asdf/bin $out/asdf/lib $out/share/zsh/site-functions
    cp -r ./bin/* $out/asdf/bin
    cp -r ./lib/* $out/asdf/lib
    cp ./VERSION $out/asdf/VERSION
    cp ./asdf.sh $out/asdf/asdf.sh
    cp ./completions/_asdf $out/share/zsh/site-functions/_asdf
    cp ./help.txt $out/asdf/help.txt
  '';

  meta = {
    description =
      "Extendable version manager with support for Ruby, Node.js, Elixir, Erlang & more asdf-vm.com";
    license = stdenv.lib.licenses.mit;
    homepage = "https://github.com/asdf-vm/asdf";
    platforms = stdenv.lib.platforms.unix;
  };
}
