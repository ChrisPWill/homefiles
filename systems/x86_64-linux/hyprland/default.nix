{
  inputs,
  pkgs,
  ...
}: let
  user = (import ../../../shared/users.nix).cwilliams;
in {
  security.polkit.enable = true;
  security.pam.services.swaylock = {};

  environment.systemPackages = with pkgs; [
    bemenu
    seatd
    swayidle
    wayland
    wlr-randr
  ];

  environment.sessionVariables = rec {
    __GL_GSYNC_ALLOWED = "0";
    __GL_VRR_ALLOWED = "0";
    WLR_DRM_NO_ATOMIC = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    GDK_BACKEND = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    # wlr.enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.common.default = "gtk";
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    xwayland = {
      enable = true;
      hidpi = true;
    };

    # enableNvidiaPatches = true;
  };

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "Hyprland";
        user = "${user.userName}";
      };
      default_session = initial_session;
    };
  };

  environment.etc."greetd/environments".text = ''
    Hyprland
  '';
}
