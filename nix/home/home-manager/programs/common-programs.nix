{
  system,
  pkgs,
  enabledLanguages,
  userFullName,
  userEmail,
}: {
  alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.98;
        decorations_theme_variant = "Dark";
        decorations = "none";
      };
      scrolling.history = 20000;
      font = {
        normal.family = "FantasqueSansMono Nerd Font Mono";
        size = 20.0;
      };
      cursor = {
        style.shape = "Beam";
        style.blinking = "On";
        vi_mode_style.shape = "Block";
        vi_mode_style.blinking = "On";
      };
    };
  };
  bat = import ./bat.nix;
  exa = import ./exa.nix;
  fzf = import ./fzf.nix;
  git = import ./git.nix {
    inherit userFullName;
    inherit userEmail;
  };
  home-manager = {enable = true;};
  neovim = import ./neovim.nix {
    inherit pkgs;
    inherit enabledLanguages;
  };
  vscode = import ./vscode.nix;
  zellij = import ./zellij.nix;
  zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  zsh = import ./zsh.nix {inherit system;};
}
