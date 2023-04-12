{ pkgs, lib }:

{
  homeDirPrefix = "/home";
  extraPrograms = {
    home-manager = { enable = true; };
    bash = {
      enable = true;
    };
    zsh = {
      enable = true;
    };

    urxvt = {
      enable = true;
      extraConfig = {
        "perl-ext" = "default,tabbedex";
      };
      scroll = {
        bar.enable = false;
        keepPosition = true;
        lines = 10000;
        scrollOnKeystroke = true;
        scrollOnOutput = false;
      };
    };

    firefox = import ../programs/firefox.nix;
  };

  extraModules = [{
    xsession = {
      enable = true;
      windowManager = {
        awesome = {
          enable = true;
          luaModules = with pkgs.luaPackages; [
            luarocks
          ];
        };
      };
    };
  }];
}
