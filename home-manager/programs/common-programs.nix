{
  system,
  pkgs,
  pkgs-unstable,
  lib,
  enabledLanguages,
  userFullName,
  userEmail,
  theme,
}: {
  alacritty = import ./alacritty.nix {inherit theme;};
  bat = import ./bat.nix;
  exa = import ./exa.nix;
  feh.enable = true;
  fzf = import ./fzf.nix;
  git = import ./git.nix {
    inherit userFullName;
    inherit userEmail;
  };
  home-manager = {enable = true;};
  jq.enable = true;
  mpv = {
    enable = true;
  };
  nushell = import ./nushell.nix;
  zellij = import ./zellij.nix {inherit theme pkgs-unstable;};
  zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  zsh = import ./zsh.nix {
    inherit system;
    inherit theme;
  };
}
