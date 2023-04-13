{pkgs}: {
  userEmail = "cwilliams@atlassian.com";
  extraModules = [];
  enabledLanguages = [
    "dockerfile"
    "javascript"
    "typescript"
    "html"
    "graphql"
    "terraform"
  ];
  extraPackages = with pkgs; [
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.prettier
    nodePackages.typescript
    nodePackages.typescript-language-server
  ];
}
