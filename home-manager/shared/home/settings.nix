{
  userName,
  homeDirPrefix,
  pkgs,
  extraPackages ? [],
}: {
  username = userName;
  homeDirectory = "${homeDirPrefix}/${userName}";
  stateVersion = "22.11";
  sessionVariables = {
    EDITOR = "nvim";
  };

  packages = import ./packages.nix {inherit pkgs extraPackages;};
}
