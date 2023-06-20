{
  pkgs,
  pkgs-unstable,
  lib,
  sharedEnabledLanguages,
  theme,
  ...
}: let
  hostEnabledLanguages = [
    "dockerfile"
    "javascript"
    "typescript"
    "html"
    "graphql"
    "terraform"
  ];
  enabledLanguages = sharedEnabledLanguages ++ hostEnabledLanguages;
in {
  userName = "cwilliams";
  userFullName = "Chris Williams";
  userEmail = "cwilliams@atlassian.com";
  extraModules = [];
  inherit enabledLanguages;
  extraPrograms = {
    neovim = import ../programs/neovim/neovim.nix {
      inherit pkgs;
      inherit pkgs-unstable;
      inherit lib;
      inherit enabledLanguages;
      inherit theme;
      enableCopilot = true;
    };
  };
  extraPackages = with pkgs; [
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.typescript
    nodePackages.typescript-language-server
    wget
  ];
}
