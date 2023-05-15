{
  userToNixosUser = user: pkgs: {
    isNormalUser = true;
    shell = pkgs.${user.shell};
    description = user.fullName;
    extraGroups = ["networkmanager" "wheel"];
  };
}
