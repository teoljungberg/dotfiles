{
  pkgs ? (import <nixpkgs> { }),
}:
if pkgs.stdenv.hostPlatform.system != "aarch64-darwin" then
  throw "Unsupported platform"
else
  let
    version = "9.2.0";
    src = fetchTarball {
      # https://github.com/heroku/homebrew-brew/commit/e8b2502a7209c5ea3089c63f9e3f409c7951ba49
      url = "https://cli-assets.heroku.com/versions/9.2.0/2aa043a/heroku-v9.2.0-2aa043a-darwin-arm64.tar.xz";
      sha256 = "14cwcisikq5ry2646j7qx3s60qkx44ymgbkj010s5nn051lh2q4a";
    };
  in
  pkgs.heroku.overrideAttrs (oldAttrs: {
    inherit version src;
  })
