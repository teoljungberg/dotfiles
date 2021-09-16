{ pkgs ? (import <nixpkgs> { })
, fetchFromGitHub ? pkgs.fetchFromGitHub
}:

let
  comma = fetchFromGitHub {
    owner = "Shopify";
    repo = "comma";
    rev = "4a62ec17e20ce0e738a8e5126b4298a73903b468";
    sha256 = "0n5a3rnv9qnnsrl76kpi6dmaxmwj1mpdd2g0b4n1wfimqfaz6gi1";
  };
in
import comma { }
