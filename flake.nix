{
  description = "Max's system configuration, with liberal copying of Carlos Alejandro Becker";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    nur.url = "github:nix-community/NUR";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/hyprland";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      nur,
      home-manager,
      nix-index-database,
      darwin,
      ...
    }@inputs:
    let

      overlays = [
        (final: prev: {
          nur = import nur {
            nurpkgs = prev;
            pkgs = prev;
          };
        })
      ];

      # Convenience function to define both Linux machines "at once".
      # TODO: Extend this to add the system as well; we can build *all machines* this way.
      forAllLinuxMachines = nixpkgs.lib.genAttrs [
        "melissa"
        "maiden"
      ];
    in
    {
      nixosConfigurations.maiden = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          { nixpkgs.overlays = overlays; }
          ./machines/maiden
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hbk";
            home-manager.users.max = {
              home.username = "max";
              home.homeDirectory = "/home/max"; # if pkgs.stdenv.isLinux then "home" else "Users" + "${username}"
              imports = [
                ./modules/home.nix
                ./modules/librewolf.nix
                ./modules/sway
                ./modules/sioyek.nix
                ./modules/zathura.nix
                ./modules/terminal-emulators/alacritty.nix
                ./modules/shell
                ./modules/editor
                nix-index-database.homeModules.nix-index
              ];
            };
          }
        ];
      };

      nixosConfigurations.melissa = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          { nixpkgs.overlays = overlays; }
          ./machines/melissa
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hbk";
            home-manager.users.cowmaster = {
              home.username = "cowmaster";
              home.homeDirectory = "/home/cowmaster";
              imports = [
                ./modules/home.nix
                ./modules/librewolf.nix
                ./modules/sioyek.nix
                ./modules/zathura.nix
                ./modules/terminal-emulators
                ./modules/shell
                ./modules/editor
                nix-index-database.homeModules.nix-index
              ];
            };
          }
        ];
      };

      nixosConfigurations.rodin = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          { nixpkgs.overlays = overlays; }
          ./machines/rodin
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hbk";
            home-manager.users.max = {
              home.username = "max";
              home.homeDirectory = "/home/max";
              imports = [
                ./modules/home.nix
                ./modules/librewolf.nix
                ./modules/sway
                # ./modules/hyprland
                ./modules/sioyek.nix
                ./modules/zathura.nix
                ./modules/rmpc.nix
                ./modules/terminal-emulators
                ./modules/shell
                ./modules/editor
                nix-index-database.homeModules.nix-index
              ];
            };
          }
        ];
      };

      nixosConfigurations.perrito = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          { nixpkgs.overlays = overlays; }
          ./machines/perrito
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hbk";
            home-manager.users.jc = {
              home.username = "jc";
              home.homeDirectory = "/home/jc";
              imports = [
                ./modules/home.nix
                ./modules/librewolf.nix
                ./modules/hyprland
                ./modules/sioyek.nix
                ./modules/zathura.nix
                ./modules/terminal-emulators
                ./modules/shell
                ./modules/editor
                nix-index-database.homeModules.nix-index
              ];
            };
          }
        ];
      };

      darwinConfigurations.bonbon = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          { nixpkgs.overlays = overlays; }
          ./machines/bonbon
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hbk";
            home-manager.users.max = {
              home.username = "max";
              home.homeDirectory = "/Users/max";
              imports = [
                ./modules/home.nix
                ./modules/librewolf.nix
                ./modules/zathura.nix
                ./modules/terminal-emulators
                ./modules/shell
                ./modules/editor
                nix-index-database.homeModules.nix-index
              ];
            };
          }
        ];
      };
    };
}
