{
  userToNixosUser = {
    pkgs,
    user,
  }: {
    isNormalUser = true;
    shell = pkgs.${user.shell};
    description = user.fullName;
    extraGroups = ["networkmanager" "wheel"];
  };
}
