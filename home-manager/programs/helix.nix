{pkgs, ...}: {
  enable = true;
  languages = {
    language-server.typescript-language-server = with pkgs.nodePackages; {
      command = "${typescript-language-server}/bin/typescript-language-server";
      args = ["--stdio" "--tsserver-path=${typescript}/lib/node_modules/typescript/lib"];
    };
    language-server.rust-analyzer = {
      commands = "${pkgs.rust-analyzer}/bin/rust-analyzer";
    };
  };
}
