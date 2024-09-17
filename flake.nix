{
  description = "CowMaster, LLC.'s very first NixOS flake :)";

  # try out the unstable branch, see what happens :/
  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    nixvim = {
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
      url = "github:nix-community/nixvim";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs =
    { self
    , nixpkgs
    , nur
    , nixvim
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
            home-manager.backupFileExtension = "bkp";
            home-manager.users.cowmaster = {
              imports = [
                ./modules/home.nix
                ./modules/nixos.nix
                ./modules/pkgs.nix
                ./modules/fzf.nix
                ./modules/gh.nix
                ./modules/git
                ./modules/alacritty.nix
                ./modules/kitty.nix
                ./modules/tmux
                ./modules/neovim
                ./modules/shell.nix
                ./modules/ssh
                nix-index-database.hmModules.nix-index
              ];
            };
          }
        ];
      };
    };
}
