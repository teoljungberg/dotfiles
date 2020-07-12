{ stdenv ? (import <nixpkgs> { }).stdenv
, fetchzip ? (import <nixpkgs> { }).fetchzip }:

stdenv.mkDerivation {
  pname = "hub";
  version = "2.14.2";

  src = fetchzip {
    url =
      "https://github.com/github/hub/releases/download/v2.14.2/hub-darwin-amd64-2.14.2.tgz";
    sha256 = "08c6q7jfv6ygdarqdsgb2r2akzk3i7k7kqm379npi2pp9jvm64i7";
  };

  installPhase = ''
    mkdir -p $out/bin/ $out/share/man/man1 $out/share/zsh/site-functions
    mv ./bin/hub $out/bin/hub
    mv ./share/man/man1/*.1 $out/share/man/man1/
    mv ./etc/hub.zsh_completion $out/share/zsh/site-functions/_hub
    chmod +x "$out/bin/hub"
  '';

  meta = {
    description =
      "A command-line tool that makes git easier to use with GitHub";
    license = stdenv.lib.licenses.mit;
    homepage = "https://hub.github.com";
    platforms = stdenv.lib.platforms.darwin;
  };
}
