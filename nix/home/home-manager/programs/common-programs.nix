{
  pkgs,
  enabledLanguages,
  userFullName,
  userEmail,
}: {
  bat = import ./bat.nix;
  exa = import ./exa.nix;
  fzf = import ./fzf.nix;
  git = import ./git.nix {
    inherit userFullName;
    inherit userEmail;
  };
  neovim = import ./neovim.nix {
    inherit pkgs;
    inherit enabledLanguages;
  };
  vscode = import ./vscode.nix;
  zellij = import ./zellij.nix;
  zsh = import ./zsh.nix;
}
