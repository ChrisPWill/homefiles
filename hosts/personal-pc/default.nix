let
  host = (import ../../shared/constants.nix).hosts.personalPc;
  stateVersion = "23.11";
  utils = import ../utils.nix;
  sharedUsers = import ../../shared/users.nix;
in {
  inherit host;
  inherit stateVersion;
  extraOverlays = [];
  extraModules = {
    pkgs,
    systemConfig,
    ...
  }: [
    {
      networking.hostName = "${host}-${systemConfig.name}";
      networking.hostId = "579220d5";

      users.users.cwilliams = utils.userToNixosUser sharedUsers.cwilliams pkgs;

      system.stateVersion = stateVersion;

      programs.zsh.enable = true;
    }
    ./hardware-configuration.nix
    # libvert/QEMU config
    {
      users.users.cwilliams = {
        extraGroups = ["libvirtd"];
      };
      programs.virt-manager.enable = true;
      virtualisation.libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          runAsRoot = true;
          swtpm.enable = true;
          ovmf = {
            enable = true;
            packages = [
              (pkgs.OVMF.override {
                tpmSupport = true;
              })
              .fd
            ];
          };
        };
      };
    }
  ];
  extraNixpkgsConfig = {};
}
