{pkgs}: {
  userName = "cwilliams";
  userFullName = "Chris Williams";
  userEmail = "chris@chrispwill.com";
  extraModules = [
    {
      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "image/jpeg" = "feh";
          "image/png" = "feh";
        };
      };
    }
  ];
  enabledLanguages = [];
  extraPrograms = {
  };
  extraPackages = with pkgs; [
    discord
    qbittorrent
  ];
}
