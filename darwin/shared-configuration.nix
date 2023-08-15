{...}: {
  services.nix-daemon.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };
    casks = [
      "alacritty"
      "amethyst"
      "docker"
      "firefox"
      "insomnia"
      "loom"
      "obsidian"
      "raycast"
      "scroll-reverser"
    ];
  };

  services = {
    yabai = {
      enable = true;
      config = {
        focus_follows_mouse = "autoraise";
        mouse_follows_focus = "off";
        window_placement = "second_child";
        window_opacity = "off";
        top_padding = 36;
        bottom_padding = 10;
        left_padding = 10;
        right_padding = 10;
        window_gap = 10;
      };
    };
    skhd = {
      enable = true;
      skhdConfig = ''
        # focus window
        # here the || was added so the selection cycles and doesn't stop at the end or beginning
        ctrl + alt - j : yabai -m window --focus prev || yabai -m window --focus last
        ctrl + alt - k : yabai -m window --focus next || yabai -m window --focus first

        # swap window
        alt - return : yabai -m window --swap west # swap with "main" tile (simply swap it west)
        shift + ctrl + alt - j : yabai -m window --swap prev
        shift + ctrl + alt - k : yabai -m window --swap next

        # move window
        shift + cmd - h : yabai -m window --warp west
        shift + cmd - j : yabai -m window --warp north
        shift + cmd - k : yabai -m window --warp next
        shift + cmd - l : yabai -m window --warp east

        # balance size of windows
        shift + alt - 0 : yabai -m space --balance

        # fast focus desktop
        ctrl + alt - 1 : yabai -m space --focus 1
        ctrl + alt - 2 : yabai -m space --focus 2
        ctrl + alt - 3 : yabai -m space --focus 3
        ctrl + alt - 4 : yabai -m space --focus 4
        ctrl + alt - 5 : yabai -m space --focus 5
        ctrl + alt - 6 : yabai -m space --focus 6
        ctrl + alt - 7 : yabai -m space --focus 7
        ctrl + alt - 8 : yabai -m space --focus 8
        ctrl + alt - 9 : yabai -m space --focus 9
        ctrl + alt - 0 : yabai -m space --focus 10

        # send window to desktop and follow focus
        shift + ctrl + alt - 1 : yabai -m window --space  1
        shift + ctrl + alt - 2 : yabai -m window --space  2
        shift + ctrl + alt - 3 : yabai -m window --space  3
        shift + ctrl + alt - 4 : yabai -m window --space  4
        shift + ctrl + alt - 5 : yabai -m window --space  5
        shift + ctrl + alt - 6 : yabai -m window --space  6
        shift + ctrl + alt - 7 : yabai -m window --space  7
        shift + ctrl + alt - 8 : yabai -m window --space  8
        shift + ctrl + alt - 9 : yabai -m window --space  9
        shift + ctrl + alt - 0 : yabai -m window --space 10

        # increase window size (this is the hack that gives xmonad like resizing)
        ctrl + alt - h : expr $(yabai -m query --windows --window | jq .frame.x) \< 20 && yabai -m window --resize right:-60:0 || yabai -m window --resize left:-60:0
        ctrl + alt - l : expr $(yabai -m query --windows --window | jq .frame.x) \< 20 && yabai -m window --resize right:60:0 || yabai -m window --resize left:60:0
        ctrl + alt - i : yabai -m window --resize bottom:0:-60
        ctrl + alt - o : yabai -m window --resize bottom:0:60

        # rotate tree
        ctrl + alt - e : yabai -m space --rotate 90

        # mirror tree y-axis
        ctrl + alt - y : yabai -m space --mirror y-axis

        # mirror tree x-axis
        ctrl + alt - x : yabai -m space --mirror x-axis

        # toggle window fullscreen zoom
        ctrl + alt - space : yabai -m window --toggle zoom-fullscreen

        # toggle window native fullscreen
        # alt - space : yabai -m window --toggle native-fullscreen
        # shift + alt - f : yabai -m window --toggle native-fullscreen

        # toggle window border
        # shift + alt - b : yabai -m window --toggle border

        # toggle window split type
        ctrl + alt - space : yabai -m window --toggle split

        # float / unfloat window and center on screen
        ctrl + alt - t : yabai -m window --toggle float;\
                  yabai -m window --grid 4:4:1:1:2:2

        # toggle sticky
        # alt - s : yabai -m window --toggle sticky

        # toggle sticky, float and resize to picture-in-picture size
        # alt - p : yabai -m window --toggle sticky;\
        #           yabai -m window --grid 5:5:4:0:1:1

        # change layout of desktop
        # ctrl + alt - a : yabai -m space --layout bsp
        # ctrl + alt - d : yabai -m space --layout float
      '';
    };
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };
  system.defaults = {
    screencapture = {
      location = "/tmp";
    };
    dock = {
      autohide = true;
      autohide-delay = 0.2;
      autohide-time-modifier = 2.0;
      mru-spaces = false;
      showhidden = true;
      show-recents = false;
      static-only = true;
    };
    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      QuitMenuItem = true;
      FXEnableExtensionChangeWarning = true;
      ShowPathbar = true;
      ShowStatusBar = true;
      _FXShowPosixPathInTitle = true;
    };
    NSGlobalDomain = {
      AppleKeyboardUIMode = 3;
      ApplePressAndHoldEnabled = false;
      AppleFontSmoothing = 1;
      _HIHideMenuBar = true;
      InitialKeyRepeat = 10;
      KeyRepeat = 1;
      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.swipescrolldirection" = true;
    };
  };
}
