How to activate

1. Create a new host under /hosts
   WARNING: If re-using an existing NixOS host, the values in `hardware-configuration.nix` should be updated!
2. Follow the instructions under the relevant Operating System section below.

# Operating Systems

## NixOS

Simply run

```
sudo nixos-rebuild switch --flake ".#<host>-<systemName>"
```

Where systemNickname is a shortened version of the system name as per files in `systems/*/default.nix` files. This is to avoid the underscore which can mess up hostName logic at times.

For instance, on the VM this was developed on, the command is:

```
sudo nixos-rebuild switch --flake ".#personal-vm-x64linux"
```

# Home Manager

Assuming nixos-rebuild has been run, just run

```
home-manager --flake .
```
