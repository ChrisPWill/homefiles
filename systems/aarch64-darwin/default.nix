{
  name = "aarch64darwin";
  system = "aarch64-darwin";
  extraModules = {
    pkgs,
    lib,
    ...
  }: [
    {
      nixpkgs.hostPlatform = lib.mkDefault "aarch64-darwin";
      environment.systemPackages = with pkgs; [
        home-manager
      ];
    }
  ];
}
