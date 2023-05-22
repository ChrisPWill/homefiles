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
    "javascript"
    "typescript"
    "html"
    "graphql"
  ];
  extraPrograms = {
  };
  extraPackages = with pkgs; [
    discord
    qbittorrent
    rust-analyzer
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.typescript
    nodePackages.typescript-language-server
  ];
  windowManager = "hyprland";
}
