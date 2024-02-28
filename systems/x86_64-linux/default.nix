let
  linuxSystem = (import ../../shared/constants.nix).systems.linuxSystem;
in {
  name = "x64linux";
  system = linuxSystem;
  extraModules = {
    inputs,
    pkgs,
    lib,
    theme,
    user,
    ...
  }: [
    {
      services.gvfs.enable = true;
      nixpkgs.hostPlatform = lib.mkDefault linuxSystem;
    }
    {
      # Enable audio
      sound.enable = true;
      hardware.pulseaudio = {
        enable = true;
        support32Bit = true;
      };
      environment.systemPackages = with pkgs; [
        pavucontrol
        pulseaudio
      ];
    }
    {
      environment.systemPackages = with pkgs; [
        gperftools
      ];

      hardware.opengl = {
        driSupport32Bit = true;
        # Vulkan
        driSupport = true;

        extraPackages = with pkgs; [
          # VAAPI
          vaapiVdpau
          libvdpau-va-gl
        ];
      };
      virtualisation.docker = {
        enableNvidia = true;
        enable = true;
      };
    }
    inputs.hyprland.nixosModules.default
    ./hyprland
    {
      environment.systemPackages = with pkgs; [
        bitwarden
        bitwarden-cli
      ];
    }
  ];
  extraNixpkgsConfig = {
    pulseaudio = true;
  };
}
