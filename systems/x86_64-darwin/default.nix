{
  name = "x64darwin";
  system = "x86_64-darwin";
  extraModules = {lib, ...}: [
    {
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-darwin";
    }
  ];
}
