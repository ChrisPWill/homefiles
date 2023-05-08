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
    theme = import ./shared/theme.nix;

    # Import machine configuration based on hostname
    hostConfigFor = hostname: system: let
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
      import ./systems/${system}.nix {inherit pkgs lib theme;};

    # Define the Home Manager configuration for a specific system
    homeConfigFor = hostname: system: let
      systemConfig = systemValues hostname system;
      hostConfig = hostConfigFor hostname system;
      pkgs = pkgsFor system;
      combinedEnabledLanguages = lib.unique (shared.enabledLanguages ++ hostConfig.enabledLanguages or []);
      commonPrograms = import ./programs/common-programs.nix {
        inherit system;
        inherit pkgs;
        enabledLanguages = combinedEnabledLanguages;
        userFullName = hostConfig.userFullName;
        userEmail = hostConfig.userEmail;
        inherit theme;
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
                userName = hostConfig.userName;
                inherit (systemConfig) homeDirPrefix;
                inherit pkgs;
                extraPackages = systemConfig.extraPackages ++ hostConfig.extraPackages;
              };

              # Merge common and system-specific programs
              programs = lib.mkForce (lib.mergeAttrs commonPrograms systemConfig.extraPrograms);
            }
          ]
          ++ systemConfig.extraModules
          ++ hostConfig.extraModules; # Include extra modules from system and machine files
      };
  in {
    # Define home configurations
    homeConfigurations = {
      "${(hostConfigFor shared.hostnames.workMbp shared.darwinSystem).userName}@${shared.hostnames.workMbp}" = homeConfigFor shared.hostnames.workMbp shared.darwinSystem;
      "${(hostConfigFor shared.hostnames.personalPc shared.linuxSystem).userName}@${shared.hostnames.personalPc}" = homeConfigFor shared.hostnames.personalPc shared.linuxSystem;
    };
  };
}
