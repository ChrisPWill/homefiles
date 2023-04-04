#!/usr/bin/env bash
if ! [ -L "/etc/nix/nix.conf" ]; then
    mv /etc/nix/nix.conf /etc/nix/nix.conf.backup
fi
ln -s ./etc/nix/nix.conf /etc/nix/nix.conf
