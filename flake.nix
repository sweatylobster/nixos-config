{
  description = "Max's system configuration, with liberal copying of Carlos Alejandro Becker";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

      # Default home-manager options I'd rather not repeat.
      myHmDefaults = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "hm-backup";
      };

      # My home-manager modules for either "max" or "cowmaster".
      myHmModules = [
        # Home manager basics.
        ./modules/home.nix

        # PDF viewers.
        ./modules/sioyek.nix
        ./modules/zathura.nix

        # Browserrrrrr...
        ./modules/firefox.nix

        # Terminal emulators. Why 3? I'm shopping around.
        ./modules/terminal-emulators

        # Shell applications and standalone binaries.
        # Daunting directory structure, but there are only two control surfaces:
        # 1) ./modules/shell/default.nix
        # 2) ./modules/shell/pkgs.nix
        ./modules/shell

        # Editors; I use neovim, but admire Helix for including batteries.
        ./modules/editor
        nix-index-database.hmModules.nix-index
      ];
    in
    {
      nixosConfigurations = forAllLinuxMachines (machine: {
        ${machine} = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            { nixpkgs.overlays = overlays; }
            ./machines/${machine}
            home-manager.nixosModules.home-manager
            (myHmDefaults // {
              home-manager.users.cowmaster = {
                home.username = "cowmaster";
                home.homeDirectory = "/home/cowmaster"; # if pkgs.stdenv.isLinux then "home" else "Users" + "${username}"
                imports = myHmModules;
              };
            })
          ];
        };
      });

      darwinConfigurations.bonbon = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          { nixpkgs.overlays = overlays; }
          ./machines/bonbon
          home-manager.darwinModules.home-manager
          (myHmDefaults // {
            home-manager.users.max = {
              home.username = "max";
              home.homeDirectory = "/Users/max";
              imports = myHmModules;
            };
          })
        ];
      };
    };
}
