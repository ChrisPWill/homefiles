{pkgs, ...}: {
  enable = true;
  languages = {
    language-server = with pkgs.nodePackages; {
      typescript-language-server = {
        command = "${typescript-language-server}/bin/typescript-language-server";
        args = ["--stdio" "--tsserver-path=${typescript}/lib/node_modules/typescript/lib"];
      };
      rust-analyzer = {
        commands = "${pkgs.rust-analyzer}/bin/rust-analyzer";
      };
    };
  };
}
