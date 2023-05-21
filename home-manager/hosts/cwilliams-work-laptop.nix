{pkgs}: {
  userName = "cwilliams";
  userFullName = "Chris Williams";
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
  extraPrograms = {};
  extraPackages = with pkgs; [
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.typescript
    nodePackages.typescript-language-server
    wget
  ];
}
