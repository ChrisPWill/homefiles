{
  system,
  pkgs,
  lib,
  enabledLanguages,
  userFullName,
  userEmail,
  theme,
}: {
  alacritty = import ./alacritty.nix {inherit theme;};
  bat = import ./bat.nix;
  exa = import ./exa.nix;
  fzf = import ./fzf.nix;
  git = import ./git.nix {
    inherit userFullName;
    inherit userEmail;
  };
  home-manager = {enable = true;};
  neovim = import ./neovim/neovim.nix {
    inherit pkgs;
    inherit lib;
    inherit enabledLanguages;
    inherit theme;
  };
  vscode = import ./vscode.nix;
  zellij = import ./zellij.nix {inherit theme;};
  zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  zsh = import ./zsh.nix {
    inherit system;
    inherit theme;
  };
}