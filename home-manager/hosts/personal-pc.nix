{pkgs}: {
  userName = "cwilliams";
  userFullName = "Chris Williams";
  userEmail = "chris@chrispwill.com";
  extraModules = [];
  enabledLanguages = [];
  extraPrograms = {
  };
  extraPackages = with pkgs; [
    discord
    qbittorrent
  ];
}
