{
  description = "Shared Home Manager configuration for MacOS and Linux";

  # Flake inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  # Flake outputs
  outputs = {
    nixpkgs,
    home-manager,
    ...
  }: let
    # Import shared constants
    shared = import ./shared/shared-config.nix;

    # Import machine configuration based on hostname
    hostConfig = hostname: system: let
      pkgs = pkgsFor system;
    in
      import ./hosts/${hostname}.nix {inherit pkgs;};

    # Select the correct nixpkgs based on the system
    pkgsFor = system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

    # Import 'lib' attribute from Nixpkgs
    lib = nixpkgs.lib;

    # System-specific values based on hostname
    systemValues = hostname: system: let
      pkgs = pkgsFor system;
    in
      import ./systems/${system}.nix {inherit pkgs lib;};

    # Define the Home Manager configuration for a specific system
    homeConfigFor = hostname: system: let
      systemConfig = systemValues hostname system;
      pkgs = pkgsFor system;
      combinedEnabledLanguages = lib.unique (shared.enabledLanguages ++ (hostConfig hostname system).enabledLanguages or []);
      commonPrograms = import ./programs/common-programs.nix {
        inherit pkgs;
        enabledLanguages = combinedEnabledLanguages;
        inherit (shared) userFullName;
        userEmail = (hostConfig hostname system).userEmail;
      };
    in
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules =
          [
            {
              # Font configuration
              fonts.fontconfig.enable = true;

              # Home configuration
              home = import ./shared/home/settings.nix {
                inherit (shared) userName;
                inherit (systemConfig) homeDirPrefix;
                inherit pkgs;
                extraPackages = systemConfig.extraPackages ++ (hostConfig hostname system).extraPackages;
              };

              # Merge common and system-specific programs
              programs = lib.mkForce (lib.mergeAttrs commonPrograms systemConfig.extraPrograms);
            }
          ]
          ++ systemConfig.extraModules
          ++ (hostConfig hostname system).extraModules; # Include extra modules from system and machine files
      };
  in {
    # Define home configurations
    homeConfigurations = {
      "${shared.userName}@${shared.hostnames.workMbp}" = homeConfigFor shared.hostnames.workMbp shared.darwinSystem;
      "${shared.userName}@${shared.hostnames.personalPc}" = homeConfigFor shared.hostnames.personalPc shared.linuxSystem;
    };
  };
}
