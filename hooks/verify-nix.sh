#!/bin/sh

set -e

nix-build --check -A hello "<nixpkgs>"
