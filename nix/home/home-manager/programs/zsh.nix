{
  enable = true;
  shellAliases = {
    home-update = "home-manager switch";
  };

  # History options
  history = {
    size = 10000;
    save = 10000;
    path = "${config.xdg.dataHome}/zsh/history";
    share = true;

    ignoreSpace = true;
    ignoreDups = true;
    extended = true;
    expireDuplicatesFirst = true;
  };

  
};