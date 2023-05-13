#!/usr/bin/env bash

sudo --preserve-env ./scripts/create-links.sh
sudo nixos-rebuild switch
home-manager switch
