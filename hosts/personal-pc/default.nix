let
  host = "personal-pc";
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
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
      };
    }
    ./hardware-configuration.nix
    # libvert/QEMU config
    {
      users.users.cwilliams = {
        extraGroups = ["libvirtd"];
      };
      programs.virt-manager.enable = true;
      # virt-manager fails without these
      environment.systemPackages = with pkgs; [
        glib
        gnome3.adwaita-icon-theme # default gnome cursors
      ];
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
                secureBoot = true;
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
