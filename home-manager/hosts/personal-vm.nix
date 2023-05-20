{pkgs}: {
  userName = "cwilliams";
  userFullName = "Chris Williams";
  userEmail = "chris@chrispwill.com";
  extraModules = [];
  enabledLanguages = [
    "javascript"
    "typescript"
    "html"
    "rust"
  ];
  extraPrograms = {};
  extraPackages = with pkgs; [
    cargo
    nodePackages.prettier
    nodePackages.typescript
    nodePackages.typescript-language-server
    rustc
    rust-analyzer
  ];
}
