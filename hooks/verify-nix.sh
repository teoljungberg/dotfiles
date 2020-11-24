#!/bin/sh

set -e

nix-build --check -A hello "<nixpkgs>" --out-link /tmp/hello
/tmp/hello/bin/hello
