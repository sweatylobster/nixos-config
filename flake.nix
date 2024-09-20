{
  description = "CowMaster, LLC.'s very first NixOS flake :)";

  # try out the unstable branch, see what happens :/
  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";

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
    , nur
    , darwin
    , neovim-nightly
    , home-manager
    , nix-index-database
    , ...
    }:
    let
      overlays = [
        (final: prev: {
          nur = import nur {
            nurpkgs = prev;
            pkgs = prev;
          };
        })
      ];
    in
    {
      nixosConfigurations.melissa = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          { nixpkgs.overlays = overlays; }
          ./machines/melissa
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-backup";
            home-manager.users.cowmaster = {
              imports = [
                ./modules/home.nix
                ./modules/nixos.nix
                ./modules/pkgs.nix
                ./modules/fzf.nix
                ./modules/firefox.nix
                ./modules/gh.nix
                ./modules/git
                ./modules/alacritty.nix
                ./modules/editorconfig.nix
                ./modules/kitty.nix
                ./modules/tmux
                ./modules/neovim
                ./modules/shell.nix
                ./modules/sioyek.nix
                ./modules/ssh
                ./modules/fish
                nix-index-database.hmModules.nix-index
              ];
            };
          }
        ];
      };

      nixosConfigurations.bonbon = nixpkgs.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          { nixpkgs.overlays = overlays; }
          ./machines/bonbon
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-backup";
            home-manager.users.cowmaster = {
              imports = [
                ./modules/home.nix
                ./modules/nixos.nix
                ./modules/pkgs.nix
                ./modules/fzf.nix
                ./modules/firefox.nix
                ./modules/gh.nix
                ./modules/git
                ./modules/alacritty.nix
                ./modules/editorconfig.nix
                ./modules/kitty.nix
                ./modules/tmux
                ./modules/neovim
                ./modules/shell.nix
                ./modules/sioyek.nix
                ./modules/ssh
                ./modules/fish
                nix-index-database.hmModules.nix-index
              ];
            };
          }
        ];
      };
    };
}
