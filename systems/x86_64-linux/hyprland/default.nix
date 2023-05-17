{pkgs, ...}: let
  user = (import ../../../shared/users.nix).cwilliams;
in {
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    seatd
    wayland
    wlr-randr
  ];

  environment.sessionVariables = {
    GDK_BACKEND = "wayland";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  programs.hyprland.enable = true;
  programs.xwayland.enable = true;

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
