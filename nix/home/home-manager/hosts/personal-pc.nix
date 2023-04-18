{pkgs}: {
  userName = "cwilliams";
  userFullName = "Chris Williams";
  userEmail = "chris@chrispwill.com";
  extraModules = [];
  enabledLanguages = [
    "javascript"
    "typescript"
    "html"
  ];
  extraPackages = with pkgs; [
    nodePackages.prettier
    nodePackages.typescript
    nodePackages.typescript-language-server
  ];
}
