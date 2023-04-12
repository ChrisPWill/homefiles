{ userName, homeDirPrefix, pkgs }:

{
  username = userName;
  homeDirectory = "${homeDirPrefix}/${userName}";
  stateVersion = "23.05";
  sessionVariables = {
    EDITOR = "nvim";
  };

  packages = with pkgs; [
    docker
    fasd
    fd
    fx
    kondo
    (pkgs.nerdfonts.override { fonts = ["FantasqueSansMono"]; })
    powerline-go
    python3Full
    ripgrep
    rustup
    tealdeer
  ];
}
