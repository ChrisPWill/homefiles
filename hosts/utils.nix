{
  userToNixosUser = user: pkgs: {
    isNormalUser = true;
    shell = pkgs.${user.shell};
    description = user.fullName;
    extraGroups = [
      "audio"
      "docker"
      "networkmanager"
      "wheel"
    ];
  };
  userToDarwinUser = user: pkgs: {
    shell = pkgs.${user.shell};
    description = user.fullName;
  };
}
