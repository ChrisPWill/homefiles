let
  # RTX 3080
  gpuIDs = [
    "10de:2206" # Graphics
    "10de:1aef" # Audio
  ];
in {
  config,
  lib,
  ...
}: {
  imports = [];

  boot = {
    initrd = {
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod"];
      kernelModules = [
        "amdgpu"
        "vfio_pci"
        "vfio"
        "vfio_iommu_type1"
        "vfio_virqfd"

        "nvidia"
        "nvidia_modeset"
        "nvidia_uvm"
        "nvidia_drm"
      ];
      luks.devices = {
        "cryptRoot".device = "/dev/disk/by-uuid/fce35182-af3a-4389-af54-527041ba8595";
      };
    };
    kernelModules = ["kvm-amd amdgpu"];
    kernelParams = [
      # enable IOMMU
      "amd_iommu=on"
      ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs)
    ];
    extraModulePackages = [];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems."/" =
    { device = "zroot/ROOT/default";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "zroot/data/home";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "zroot/nix";
      fsType = "zfs";
    };

  fileSystems."/var" =
    { device = "zroot/var";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/9830-B4C3";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/31889efe-0b68-41c6-ad49-e324d816891a"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s3.useDHCP = lib.mkDefault true;

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.enableRedistributableFirmware = true;

  services.xserver.videoDrivers = ["nvidia"];
  nixpkgs.config.allowUnfree = true;
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.modesetting.enable = true;

  # Logitech
  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  # SPICE redirection lets you essentially hotplug USB keyboards, mice, storage, etc. from the host into the guest
  virtualisation.spiceUSBRedirection.enable = true;
}
