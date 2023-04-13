{ pkgs }:
{
  userEmail = "cwilliams@atlassian.com";
  extraModules = [];
  enabledLanguages = [
    "typescript"
  ];
  extraPackages = with pkgs; [
    nodePackages.prettier
    nodePackages.typescript
    nodePackages.typescript-language-server
  ];
}
