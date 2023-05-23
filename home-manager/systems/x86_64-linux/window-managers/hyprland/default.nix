{
  inputs,
  pkgs,
  theme,
  ...
}: [
  # eww
  {
    xdg.configFile."eww/scripts".source = ./eww/scripts;
    xdg.configFile."eww/eww.scss".text = import ./eww/eww.scss.nix {inherit theme;};
    xdg.configFile."eww/eww.yuck".text = import ./eww/eww.yuck.nix {};
  }
  # locks
  {
    programs.swaylock = {
      enable = true;
      settings = {
        color = "#764783";
        daemonize = true;
        clock = true;
        ignore-empty-password = true;
      };
    };
    services.flameshot.enable = true;
    services.swayidle = {
      enable = true;
      events = [
        {
          event = "lock";
          command = "${pkgs.swaylock}/bin/swaylock";
        }
        {
          event = "before-sleep";
          command = "${pkgs.swaylock}/bin/swaylock";
        }
        {
          event = "after-resume";
          command = "${pkgs.hyprland}/bin/hyprctl \"dispatcher dpms on\"";
        }
      ];
      timeouts = [
        {
          timeout = 600;
          command = "${pkgs.swaylock}/bin/swaylock";
        }
        {
          timeout = 1200;
          command = "${pkgs.hyprland}/bin/hyprctl \"dispatcher dpms off\"";
        }
      ];
    };
  }
  inputs.hyprland.homeManagerModules.default
  {
    wayland.windowManager.hyprland = {
      enable = true;
      nvidiaPatches = true;
      extraConfig = import ./hyprland.nix {inherit pkgs theme;};
    };
  }
]
