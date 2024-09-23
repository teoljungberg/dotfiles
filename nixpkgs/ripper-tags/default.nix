{
  pkgs ? import <nixpkgs> { },
  ruby ? pkgs.ruby_3_2,
}:
let
  bundlerApp = pkgs.bundlerApp;
  bundlerUpdateScript = pkgs.bundlerUpdateScript;
in
bundlerApp {
  inherit ruby;

  pname = "ripper-tags";
  gemdir = ./.;
  exes = [ "ripper-tags" ];

  passthru.updateScript = bundlerUpdateScript "ripper-tags";
}
