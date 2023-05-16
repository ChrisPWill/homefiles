{pkgs, ...}: let
  user = (import ../../../shared/users.nix).cwilliams;
  flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";

  hyprland =
    (import flake-compat {
      src = builtins.fetchTarball "https://github.com/hyprwm/Hyprland/archive/master.tar.gz";
    })
    .defaultNix;
in {
  imports = [hyprland.nixosModules.default];

  environment.systemPackages = with pkgs; [
    wayland
  ];

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    gtkUsePortal = true;
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
