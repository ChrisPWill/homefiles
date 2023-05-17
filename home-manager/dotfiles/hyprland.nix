{theme, ...}: let
  toRgb = theme.utils.toRgb;
  colors = theme.normal;
in ''
  monitor =,preferred,auto,1

  input {
      kb_layout=us
      follow_mouse=1
  }

  general {
      gaps_in=5
      gaps_out=5
      border_size=2
      col.active_border=${toRgb (colors.green)}
      col.inactive_border=${toRgb (colors.red)}
  }

  decoration {
      rounding=5
      blur=true
      blur_size=3
      blur_passes=2
  }

  animations {
      enabled=1
      animation=windows,1,7,default
      animation=borders,1,10,default
      animation=fadein,1,10,default
      animation=workspaces,1,6,default
  }

  # application launching
  bind=SUPER,return,exec,alacritty # Open terminal

  # VIM navigation for windows
  bind=SUPER,h,movefocus,l
  bind=SUPER,j,movefocus,d
  bind=SUPER,k,movefocus,u
  bind=SUPER,l,movefocus,r

  # window management
  bind=SUPER,c,killactive,
  bind=SUPER,space,togglefloating,
  bind=SUPER,m,exit,

  # Enable alacritty transparency
  windowrule=opacity 0.85,alacritty

  # Set wallpaper
  # exec-once=swaybg -i ~/.wallpaper.* -m fill &

  # Start waybar
  # exec-once=waybar &

  # Default workspaces based on monitor
  # workspace=DP-3,1
  # workspace=HDMI-A-1,10

  # Switch to workspace
  bind=SUPER,1,workspace,1
  bind=SUPER,2,workspace,2
  bind=SUPER,3,workspace,3
  bind=SUPER,4,workspace,4
  bind=SUPER,5,workspace,5
  bind=SUPER,6,workspace,6
  bind=SUPER,7,workspace,7
  bind=SUPER,8,workspace,8
  bind=SUPER,9,workspace,9
  bind=SUPER,0,workspace,10

  # Move to workspace
  bind=SUPERSHIFT,1,movetoworkspace,1
  bind=SUPERSHIFT,2,movetoworkspace,2
  bind=SUPERSHIFT,3,movetoworkspace,3
  bind=SUPERSHIFT,4,movetoworkspace,4
  bind=SUPERSHIFT,5,movetoworkspace,5
  bind=SUPERSHIFT,6,movetoworkspace,6
  bind=SUPERSHIFT,7,movetoworkspace,7
  bind=SUPERSHIFT,8,movetoworkspace,8
  bind=SUPERSHIFT,9,movetoworkspace,9
  bind=SUPERSHIFT,0,movetoworkspace,10
''
