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
      "firefox"
      "raycast"
    ];
  };

  services = {
    yabai = {
      enable = true;
    };
    skhd = {
      enable = true;
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
