{
  description = "CowMaster, LLC.'s very first NixOS flake :)";

  # try out the unstable branch, see what happens :/
  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    goreleaser-nur.url = "github:goreleaser/nur";

    # neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";

    # inputs.nixvim = {
    #   url = "github:nix-community/nixvim";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

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
    , goreleaser-nur
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
              repoOverrides = {
                goreleaser = import goreleaser-nur { pkgs = prev; };
              };
            };
        })
      ];

      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix;

      nixpkgsFor = forAllSystems (system: import nixpkgs {
        inherit system;
        overlays = overlays;
      });
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
                ./modules/zathura.nix
                ./modules/ssh
                ./modules/fish
                nix-index-database.hmModules.nix-index
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
            home-manager.backupFileExtension = "hm-backup";
            home-manager.extraSpecialArgs = {
              pkgs-stable = import nixpkgs-stable {
                system = "aarch64-darwin";
              };
            };
            home-manager.users.max = {
              imports = [
                ./modules/home.nix
                ./modules/darwin
                ./modules/pkgs.nix
                ./modules/fzf.nix
                # ./modules/firefox.nix  # not yet, i have so many bookmarks!
                ./modules/gh.nix
                ./modules/git
                ./modules/alacritty.nix
                ./modules/editorconfig.nix
                ./modules/kitty.nix
                ./modules/tmux
                ./modules/neovim
                ./modules/shell.nix
                ./modules/sioyek.nix
                ./modules/taskwarrior.nix
                ./modules/zathura.nix
                # ./modules/ssh  # also not yet -- need to move around keys.
                # ./modules/hammerspoon  # not set up yet
                nix-index-database.hmModules.nix-index
              ];
            };
          }
        ];
      };

      devShells = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          default = pkgs.mkShellNoCC {
            buildInputs = with pkgs; [
              (writeScriptBin "dot-clean" ''
                nix-collect-garbage -d --delete-older-than 30d
              '')
              (writeScriptBin "dot-release" ''
                git tag -m "$(date +%Y.%m.%d)" "$(date +%Y.%m.%d)"
                git push --tags
                goreleaser release --clean
              '')
              (writeScriptBin "dot-apply" ''
                if test $(uname -s) == "Linux"; then
                  sudo nixos-rebuild switch --flake .#
                elif test $(uname -s) == "Darwin"; then
                  nix build "./#darwinConfigurations.$(hostname | cut -f1 -d'.').system"
                  ./result/sw/bin/darwin-rebuild switch --flake .
                fi
              '')
            ];
          };
        });
    };
}
