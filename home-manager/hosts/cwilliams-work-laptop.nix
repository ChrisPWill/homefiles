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
    "html"
    "graphql"
    "json"
    "terraform"
    "typescript"
    "yaml"
  ];
  enabledLanguages = sharedEnabledLanguages ++ hostEnabledLanguages;
in {
  userName = "cwilliams";
  userFullName = "Chris Williams";
  userEmail = "cwilliams@atlassian.com";
  extraModules = [
    {
      programs.zsh = {
        enable = true;
        shellAliases = {
          node18 = "nix develop ~/.dev-env/node18 -c zsh";
        };
      };
    }
  ];
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
    nodePackages.vscode-json-languageserver
    nodePackages.yaml-language-server
    wget
  ];
}
