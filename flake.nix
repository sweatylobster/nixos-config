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
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-stable
    , nur
    , home-manager
    , nix-index-database
    , darwin
    , ...
    }:
    let

      overlays = [
        (final: prev: {
          nur = import nur
            {
              nurpkgs = prev;
              pkgs = prev;
            };
        })
      ];

      # Convenience function to define both Linux machines "at once".
      # TODO: Extend this to add the system as well; we can build *all machines* this way.
      forAllLinuxMachines = nixpkgs.lib.genAttrs [ "melissa" "maiden" ];
    in
    {
      nixosConfigurations = forAllLinuxMachines (machine: {
        ${machine} = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            { nixpkgs.overlays = overlays; }
            ./machines/${machine}
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-backup";
              home-manager.users.cowmaster = {
                home.username = "cowmaster";
                home.homeDirectory = "/home/cowmaster"; # if pkgs.stdenv.isLinux then "home" else "Users" + "${username}"
                imports = [
                  ./modules/home.nix
                  ./modules/firefox.nix
                  ./modules/sioyek.nix
                  ./modules/zathura.nix
                  ./modules/terminal-emulators
                  ./modules/shell
                  ./modules/editor
                  nix-index-database.hmModules.nix-index
                ];
              };
            }
          ];
        };
      });

      darwinConfigurations.bonbon = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          { nixpkgs.overlays = overlays; }
          ./machines/bonbon
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-backup";
            home-manager.users.max = {
              home.username = "max";
              home.homeDirectory = "/Users/max";
              imports = [
                ./modules/home.nix
                ./modules/firefox.nix
                ./modules/sioyek.nix
                ./modules/zathura.nix
                ./modules/terminal-emulators
                ./modules/shell
                ./modules/editor
                nix-index-database.hmModules.nix-index
              ];
            };
          }
        ];
      };
    };
}
