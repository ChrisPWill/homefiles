{pkgs, ...}: {
  enable = true;
  languages = {
    language-server.typescript-language-server = with pkgs.nodePackages; {
      command = "${typescript-language-server}/bin/typescript-language-server";
    };
    language-server.rust-analyzer = {
      commands = "${pkgs.rust-analyzer}/bin/rust-analyzer";
    };
  };
}
