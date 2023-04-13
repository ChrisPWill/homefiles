{pkgs}: {
  userEmail = "cwilliams@atlassian.com";
  extraModules = [];
  enabledLanguages = [
    "javascript"
    "typescript"
    "html"
    "graphql"
    "terraform"
  ];
  extraPackages = with pkgs; [
    nodePackages.prettier
    nodePackages.typescript
    nodePackages.typescript-language-server
  ];
}
