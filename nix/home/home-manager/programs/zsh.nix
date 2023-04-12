{
  enable = true;
  shellAliases = {
    home-update = "home-manager switch";

    # Disable autocorrection for these
    ln = "nocorrect ln";
    mv = "nocorrect mv";
    mkdir = "nocorrect mkdir";
    sudo = "nocorrect sudo";

    # Directory navigation
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "-- -" = "cd -";
    "-- --" = "cd -2";
    "-- ---" = "cd -3";
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