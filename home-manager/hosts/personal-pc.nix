{pkgs}: {
  userName = "cwilliams";
  userFullName = "Chris Williams";
  userEmail = "chris@chrispwill.com";
  extraModules = [];
  enabledLanguages = [];
  extraPrograms = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
    };
  };
  extraPackages = with pkgs; [
    discord
    qbittorrent
  ];
}
