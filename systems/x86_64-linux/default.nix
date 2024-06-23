{
  name = "x64linux";
  system = "x86_64-linux";
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
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
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
