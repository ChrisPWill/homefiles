#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
BASE_DIR=$( cd -- "$SCRIPT_DIR/.." &> /dev/null && pwd )

function link_and_backup_destination {
    if ! [ -L "$2" ]; then
        [ -f "$2" ] && echo "Backing up $2 to $2.backup" && mv "$2" "$2.backup"
    fi
    echo "${BASE_DIR}/$1"; echo ==\> "$2"
    ln -sf "${BASE_DIR}/$1" "$2"
    echo ""
}

linking_func=$(declare -f link_and_backup_destination)

echo -e "Creating links"
echo -e "================"

# System files
echo -e "Linking system files:"
echo -e "---------------------"

if test -f "/etc/NIXOS"; then
  # For NixOS
  # nixos files
  for f in $BASE_DIR/nix/etc/nixos/*; do
    configFile=$(basename $f)
    link_and_backup_destination "nix/etc/nixos/$configFile" "/etc/nixos/$configFile"
  done
else
  # For non-NixOS
  link_and_backup_destination "non-nix/etc/nix" "/etc/nix"
fi

echo -e "Now linking home files:"
echo -e "-----------------------"

link_and_backup_destination "home-manager" "$HOME/.config/home-manager"
