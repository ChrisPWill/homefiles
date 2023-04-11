#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

function link_and_backup_destination {
    if ! [ -L "$2" ]; then
        [ -f "$2" ] && mv "$2" "$2.backup"
    fi
    ln -sf "${SCRIPT_DIR}/$1" "$2"
}

link_and_backup_destination "nix/etc/nix/nix.conf" "/etc/nix/nix.conf"
link_and_backup_destination "nix/home/home-manager" "$HOME/.config/home-manager"

echo Choose a machine config
ls "${SCRIPT_DIR}/nix/home/home-manager/machines"
read -r machine_name
ln -sf "${SCRIPT_DIR}/nix/home/home-manager/machines/${machine_name}" "${SCRIPT_DIR}/nix/home/home-manager/current-machine.nix"
ln -sf "${SCRIPT_DIR}/nix/home/home-manager/machines/${machine_name}" "$HOME/.config/home-manager/current-machine.nix"
