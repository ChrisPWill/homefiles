{
  getPkgs = {
    nixpkgs,
    systemConfig,
  }:
    import nixpkgs {
      system = systemConfig.system;
      config = {
        allowUnfree = true;
      };
      overlays = [];
    };
}
