{
  userName,
  homeDirPrefix,
  pkgs,
  extraPackages ? [],
}: {
  username = userName;
  homeDirectory = "${homeDirPrefix}/${userName}";
  stateVersion = "23.05";
  sessionVariables = {
    EDITOR = "nvim";
  };

  packages = with pkgs;
    [
      eureka-ideas
      fd
      fx
      kondo
      (pkgs.nerdfonts.override {fonts = ["FantasqueSansMono"];})
      powerline-go
      rargs
      ripgrep
      tealdeer
      alejandra
      lua-language-server
      nil
    ]
    ++ extraPackages;
}
