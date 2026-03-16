{
  pkgs ? import <nixpkgs> { },
}:
let
  bundlerApp = pkgs.bundlerApp;
  bundlerUpdateScript = pkgs.bundlerUpdateScript;
in
bundlerApp {
  pname = "ripper-tags";
  gemdir = ./.;
  exes = [ "ripper-tags" ];

  passthru.updateScript = bundlerUpdateScript "ripper-tags";
}
