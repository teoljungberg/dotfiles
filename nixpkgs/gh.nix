{ stdenv ? (import <nixpkgs> { }).stdenv
, fetchzip ? (import <nixpkgs> { }).fetchzip }:

stdenv.mkDerivation {
  pname = "gh";
  version = "1.2.0";

  src = fetchzip {
    url =
      "https://github.com/cli/cli/releases/download/v1.2.0/gh_1.2.0_macOS_amd64.tar.gz";
    sha256 = "0qimpfy4ji0v1inai8wllvclz962fl0ibzd4hsqz3g6q498gr2wv";
  };

  installPhase = ''
    mkdir -p $out/bin/ $out/share/man/man1
    mv ./bin/gh $out/bin/gh
    mv ./share/man/man1/*.1 $out/share/man/man1/
    chmod +x "$out/bin/gh"
  '';

  meta = {
    description = "GitHub’s official command line tool";
    license = stdenv.lib.licenses.mit;
    homepage = "https://cli.github.com";
    platforms = stdenv.lib.platforms.darwin;
  };
}
