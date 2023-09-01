{
  userFullName,
  userEmail,
}: {
  enable = true;
  userName = userFullName;
  userEmail = userEmail;
  lfs.enable = true;
  extraConfig = {
    push.autoSetupRemote = true;
  };
}
