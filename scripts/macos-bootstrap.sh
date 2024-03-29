#!/usr/bin/env bash

set -euo pipefail

if ! command -v nix &> /dev/null
then
  echo "Nix not found, installing..."
  sh <(curl -L https://nixos.org/nix/install) --daemon --yes
  echo "Nix installed, re-open shell and repeat for next steps."
else
  echo "Nix found, skipping installation"
fi

if ! command -v brew &> /dev/null
then
  echo "Brew not found, installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "Brew installed!"
fi

nix --extra-experimental-features "flakes nix-command" build ".#darwinConfigurations.cwilliams-work-laptop-aarch64darwin.system"

./result/sw/bin/darwin-rebuild switch --flake ".#cwilliams-work-laptop-aarch64darwin"

nix --extra-experimental-features "flakes nix-command" run nixpkgs#home-manager -- switch --flake .
