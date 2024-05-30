{
  pkgs,
  theme,
  ...
}: let
  toRgb = theme.utils.toRgb;
  colors = theme.normal;
in ''
  monitor=,preferred,auto,1
  monitor=DP-1,3840x2160,0x0,1
  monitor=DP-2,2560x1440,2560x360,1
  env=WLR_DRM_DEVICES,/dev/dri/card0

  misc {
    mouse_move_enables_dpms = true
    key_press_enables_dpms = true
  }

  input {
    kb_layout=us
    follow_mouse=1
  }

  general {
    gaps_in=5
    gaps_out=7
    border_size=2
    col.active_border=${toRgb (colors.green)}
    col.inactive_border=${toRgb (colors.lightgray)}
  }

  decoration {
    rounding=5
    # blur=true
    # blur_size=3
    # blur_passes=2
  }

  bezier=overshot,0.05,0.9,0.1,1.1
  animation=workspaces,1,8,overshot,fade
  animation=windows,1,3,overshot,slide

  # application launching
  bind=CTRL_ALT,return,exec,alacritty # Open terminal
  bind=CTRL_ALT,r,exec,wofi --show drun -o DP-2 # Application launcher
  bind=CTRL_ALT,PrtSc,exec,flameshot gui

  # VIM navigation for windows
  bind=CTRL_ALT,h,movefocus,l
  bind=CTRL_ALT,j,movefocus,d
  bind=CTRL_ALT,k,movefocus,u
  bind=CTRL_ALT,l,movefocus,r
  bind=CTRL_ALT_SHIFT,right,resizeactive,10 0
  bind=CTRL_ALT_SHIFT,left,resizeactive,-10 0
  bind=CTRL_ALT_SHIFT,up,resizeactive,0 -10
  bind=CTRL_ALT_SHIFT,down,resizeactive,0 10

  # window management
  bind=CTRL_ALT,c,killactive,
  bind=CTRL_ALT,space,togglefloating,
  bind=CTRL_ALT,m,exit,
  bind=CTRL_ALT,f,fullscreen,0
  bind=CTRL_ALT_SHIFT,f,fakefullscreen,0
  bind=CTRL_ALT,p,pin,
  bindm=CTRL_ALT,mouse:272,movewindow
  bindm=CTRL_ALT,mouse:273,resizewindow


  # locks and login
  bind=CTRL_ALT,q,exec,swaylock

  # Enable alacritty transparency
  windowrule=opacity 0.85,alacritty

  # Set wallpaper
  exec-once=swaybg -i ~/.config/wallpapers/safe.* -m fill &
  bind=CTRL_ALT_SHIFT,F11,exec,swaybg -i ~/.config/wallpapers/safe.* -m fill &
  bind=CTRL_ALT_SHIFT,F12,exec,swaybg -i ~/.config/wallpapers/anime.* -m fill &

  # Start eww
  exec-once=eww daemon
  exec-once=eww open bar1
  exec-once=eww open bar2

  # Idle
  exec-once=swayidle

  # Default workspaces based on monitor
  workspace=DP-1,1
  workspace=DP-2,6
  workspace=1,monitor:DP-1, default:true
  workspace=2,monitor:DP-1
  workspace=3,monitor:DP-1
  workspace=4,monitor:DP-1
  workspace=5,monitor:DP-1
  workspace=6,monitor:DP-2, default:true
  workspace=7,monitor:DP-2
  workspace=8,monitor:DP-2
  workspace=9,monitor:DP-2
  workspace=0,monitor:DP-2

  # Switch to workspace
  bind=CTRL_ALT,1,workspace,1
  bind=CTRL_ALT,2,workspace,2
  bind=CTRL_ALT,3,workspace,3
  bind=CTRL_ALT,4,workspace,4
  bind=CTRL_ALT,5,workspace,5
  bind=CTRL_ALT,6,workspace,6
  bind=CTRL_ALT,7,workspace,7
  bind=CTRL_ALT,8,workspace,8
  bind=CTRL_ALT,9,workspace,9
  bind=CTRL_ALT,0,workspace,10

  # Move to workspace
  bind=CTRL_ALT_SHIFT,1,movetoworkspace,1
  bind=CTRL_ALT_SHIFT,2,movetoworkspace,2
  bind=CTRL_ALT_SHIFT,3,movetoworkspace,3
  bind=CTRL_ALT_SHIFT,4,movetoworkspace,4
  bind=CTRL_ALT_SHIFT,5,movetoworkspace,5
  bind=CTRL_ALT_SHIFT,6,movetoworkspace,6
  bind=CTRL_ALT_SHIFT,7,movetoworkspace,7
  bind=CTRL_ALT_SHIFT,8,movetoworkspace,8
  bind=CTRL_ALT_SHIFT,9,movetoworkspace,9
  bind=CTRL_ALT_SHIFT,0,movetoworkspace,10
''
