{pkgs ? (import <nixpkgs> {})}:
if pkgs.stdenv.hostPlatform.system != "aarch64-darwin"
then throw "Unsupported platform"
else let
  version = "8.11.5";
  gitSha = "df5cd30";
  src = fetchTarball {
    # https://github.com/heroku/homebrew-brew/commit/3b6ca6a88b49e47a0fd7625eff10a2475ac7e1a4
    url = "https://cli-assets.heroku.com/versions/${version}/${gitSha}/heroku-v${version}-${gitSha}-darwin-x64.tar.xz";
    sha256 = "1g6lbxgff3d3n05dwrdlm94kf5jsim6jxdxzf1qmhzq8agnc1wd0";
  };
in
  pkgs.heroku.overrideAttrs (oldAttrs: {
    inherit version src;
  })
