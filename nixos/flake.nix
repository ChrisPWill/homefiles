{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
  }: {
    nixosConfigurations.personal-pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        /etc/nixos/hardware-configuration.nix
        ({
          config,
          pkgs,
          ...
        }: {
          imports = [home-manager.nixosModules.home-manager];

          boot.loader.grub = {
            enable = true;
            device = "/dev/sda";
            useOSProber = true;
          };

          boot.initrd.secrets = {
            "/crypto_keyfile.bin" = null;
          };

          boot.loader.grub.enableCryptodisk = true;

          boot.initrd.luks.devices."luks-648f3978-31a0-42c8-a6b7-22057d5907b0".keyFile = "/crypto_keyfile.bin";
          networking.hostName = "personal-pc";

          networking.networkmanager.enable = true;
          time.timeZone = "Australia/Sydney";
          i18n.defaultLocale = "en_GB.UTF-8";

          i18n.extraLocaleSettings = {
            LC_ADDRESS = "en_AU.UTF-8";
            LC_IDENTIFICATION = "en_AU.UTF-8";
            LC_MEASUREMENT = "en_AU.UTF-8";
            LC_MONETARY = "en_AU.UTF-8";
            LC_NAME = "en_AU.UTF-8";
            LC_NUMERIC = "en_AU.UTF-8";
            LC_PAPER = "en_AU.UTF-8";
            LC_TELEPHONE = "en_AU.UTF-8";
            LC_TIME = "en_AU.UTF-8";
          };

          services.xserver = {
            layout = "au";
            xkbVariant = "";
            enable = true;

            displayManager = {
              defaultSession = "none+awesome";
              lightdm.enable = true;
            };

            windowManager.awesome = {
              enable = true;
            };
          };

          programs.zsh.enable = true;

          users.users.cwilliams = {
            isNormalUser = true;
            description = "Chris Williams";
            extraGroups = ["networkmanager" "wheel"];
            packages = with pkgs; [];
            shell = pkgs.zsh;
          };

          nixpkgs.config.allowUnfree = true;

          virtualisation.virtualbox.guest = {
            enable = true;
            x11 = true;
          };

          environment.systemPackages = with pkgs; [
          ];

          system.stateVersion = "23.05";

          nix.settings = {
            experimental-features = ["nix-command" "flakes"];
          };
        })
      ];
    };
  };
}
