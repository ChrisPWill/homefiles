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
  enabledLanguages = [
    "rust"
  ];
  extraPrograms = {
  };
  extraPackages = with pkgs; [
    discord
    qbittorrent
    rust-analyzer
  ];
}
