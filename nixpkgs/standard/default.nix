{
  pkgs ? import <nixpkgs> { },
}:
let
  bundlerApp = pkgs.bundlerApp;
  bundlerUpdateScript = pkgs.bundlerUpdateScript;
in
bundlerApp {
  pname = "standard";
  gemdir = ./.;
  exes = [ "standardrb" ];

  passthru.updateScript = bundlerUpdateScript "standard";
}
