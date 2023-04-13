{ pkgs }:
{
  userEmail = "cwilliams@atlassian.com";
  extraModules = [];
  enabledLanguages = [
    "typescript"
  ];
  extraPackages = with pkgs; [
    nodePackages.typescript-language-server
  ];
}
