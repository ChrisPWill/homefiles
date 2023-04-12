{ userName, homeDirPrefix, pkgs }:

{
  username = userName;
  homeDirectory = "${homeDirPrefix}/${userName}";
  stateVersion = "23.05";
  sessionVariables = {
    EDITOR = "nvim";
  };

  packages = with pkgs; [
    fasd
    (pkgs.nerdfonts.override { fonts = ["FantasqueSansMono"]; })
    powerline-go
    ripgrep
  ];
}
