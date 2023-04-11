{ userName, homeDirPrefix }:

{
  allowUnfree = true;
  username = userName;
  homeDirectory = "${homeDirPrefix}/${userName}";
  stateVersion = "23.05";
  sessionVariables = {
    EDITOR = "nvim";
  };
}
