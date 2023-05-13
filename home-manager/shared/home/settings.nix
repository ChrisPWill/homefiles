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

  packages = import ./packages.nix {inherit pkgs extraPackages;};
}
