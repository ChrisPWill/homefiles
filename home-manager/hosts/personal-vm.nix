{
  pkgs,
  pkgs-unstable,
  lib,
  sharedEnabledLanguages,
  theme,
  ...
}: let
  hostEnabledLanguages = [
    "javascript"
    "typescript"
    "html"
    "rust"
  ];
  enabledLanguages = sharedEnabledLanguages ++ hostEnabledLanguages;
in {
  userName = "cwilliams";
  userFullName = "Chris Williams";
  userEmail = "chris@chrispwill.com";
  extraModules = [];
  inherit enabledLanguages;
  extraPrograms = {
    neovim = import ../programs/neovim/neovim.nix {
      inherit pkgs;
      inherit pkgs-unstable;
      inherit lib;
      inherit enabledLanguages;
      inherit theme;
    };
  };
  extraPackages = with pkgs; [
    cargo
    nodePackages.prettier
    nodePackages.typescript
    nodePackages.typescript-language-server
    rustc
    rust-analyzer
  ];
}
