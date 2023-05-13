#!/usr/bin/env bash

sudo --preserve-env ./scripts/create-links.sh

# Todo: MacOS specific setup after testing environment
if ! test -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh; then
  echo
  read -r -p "Nix not installed, would you like to install Nix? Reboot required. [y/N] " response
  response=${response,,}    # tolower
  if [[ "$response" =~ ^(yes|y)$ ]]; then
    sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume --daemon
    reboot
  fi
fi

source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
export NIX_PATH=darwin-config=$HOME/.nixpkgs/darwin-configuration.nix:$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --add https://github.com/LnL7/nix-darwin/archive/master.tar.gz darwin
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
bash
nix-shell '<home-manager>' -A install
home-manager switch

home-manager switch
