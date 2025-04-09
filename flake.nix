{
  description = "CowMaster, LLC.'s very first NixOS flake :)";

  # try out the unstable branch, see what happens :/
  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

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
      forAllLinuxMachines = nixpkgs.lib.genAttrs [ "melissa" "maiden" ];
      myHmModules = [
        # ./modules/darwin

        # Terminal emulators.
        # ./modules/alacritty.nix
        ./modules/kitty.nix

        # Shell binaries and configs.
        # TODO: ./modules/shell
        ./modules/fzf.nix
        ./modules/pkgs.nix
        ./modules/shell.nix
        ./modules/taskwarrior.nix
        ./modules/tmux
        ./modules/top

        # Editors and configs.
        # TODO: ./modules/editor
        ./modules/editorconfig.nix
        ./modules/hx.nix
        ./modules/neovim

        # Personal stuff.
        # TODO: ./modules/identity
        ./modules/gh.nix
        ./modules/git
        ./modules/home.nix
        # ./modules/ssh  # not yet -- need to move around keys.

        # PDF viewers.
        # TODO: ./modules/viewers
        ./modules/sioyek.nix
        ./modules/zathura.nix
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
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-backup";
              home-manager.users.cowmaster = {
                home.username = "cowmaster";
                home.homeDirectory = "/home/cowmaster";
                imports = myHmModules ++ [ ./modules/ssh ./modules/firefox.nix ];
              };
            }
          ];
        };
      });

      # nixosConfigurations.maiden = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   modules = [
      #     { nixpkgs.overlays = overlays; }
      #     ./machines/maiden
      #     home-manager.nixosModules.home-manager
      #     {
      #       home-manager.useGlobalPkgs = true;
      #       home-manager.useUserPackages = true;
      #       home-manager.backupFileExtension = "hm-backup";
      #       home-manager.users.cowmaster = {
      #         imports = [
      #           ./modules/home.nix
      #           ./modules/nixos.nix
      #           ./modules/pkgs.nix
      #           ./modules/fzf.nix
      #           ./modules/firefox.nix
      #           ./modules/gh.nix
      #           ./modules/git
      #           ./modules/alacritty.nix
      #           ./modules/editorconfig.nix
      #           ./modules/kitty.nix
      #           ./modules/tmux
      #           ./modules/neovim
      #           ./modules/shell.nix
      #           ./modules/sioyek.nix
      #           ./modules/top
      #           ./modules/zathura.nix
      #           ./modules/ssh
      #           ./modules/fish
      #           nix-index-database.hmModules.nix-index
      #         ];
      #       };
      #     }
      #   ];
      # };
      #
      # nixosConfigurations.melissa = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   modules = [
      #     { nixpkgs.overlays = overlays; }
      #     ./machines/melissa
      #     home-manager.nixosModules.home-manager
      #     {
      #       home-manager.useGlobalPkgs = true;
      #       home-manager.useUserPackages = true;
      #       home-manager.backupFileExtension = "hm-backup";
      #       home-manager.users.cowmaster = {
      #         imports = [
      #           ./modules/home.nix
      #           ./modules/nixos.nix
      #           ./modules/pkgs.nix
      #           ./modules/fzf.nix
      #           ./modules/firefox.nix
      #           ./modules/gh.nix
      #           ./modules/git
      #           ./modules/alacritty.nix
      #           ./modules/editorconfig.nix
      #           ./modules/kitty.nix
      #           ./modules/tmux
      #           ./modules/neovim
      #           ./modules/shell.nix
      #           ./modules/sioyek.nix
      #           ./modules/top
      #           ./modules/zathura.nix
      #           ./modules/ssh
      #           ./modules/fish
      #           nix-index-database.hmModules.nix-index
      #         ];
      #       };
      #     }
      #   ];
      # };

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
            home-manager.extraSpecialArgs = {
              pkgs-stable = import nixpkgs-stable {
                system = "aarch64-darwin";
              };
            };
            # home-manager.users.${username} = {
            # let this be a user so we can keep the stuff above dry
            home-manager.users.max = {
              home.username = "max";
              home.homeDirectory = "/Users/max";
              imports = myHmModules;
            };
          }
        ];
      };

    };
}
