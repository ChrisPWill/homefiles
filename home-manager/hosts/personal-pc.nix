{pkgs}: {
  userName = "cwilliams";
  userFullName = "Chris Williams";
  userEmail = "chris@chrispwill.com";
  extraModules = [];
  enabledLanguages = [];
  extraPackages = with pkgs; [qbittorrent];
}
