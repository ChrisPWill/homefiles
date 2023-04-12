{ userName, homeDirPrefix, pkgs }:

{
  username = userName;
  homeDirectory = "${homeDirPrefix}/${userName}";
  stateVersion = "23.05";
  sessionVariables = {
    EDITOR = "nvim";
  };

  packages = with pkgs; [
    ripgrep
    powerline-fonts
    powerline-go
  ];
}
