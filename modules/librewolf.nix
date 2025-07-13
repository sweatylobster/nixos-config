{ pkgs, inputs, ... }:
{
  # https://github.com/HirschBerge/Public-dots/blob/main/nixos/common/configs/firefox.nix
  programs.librewolf = {
    enable = true;

    # languagePacks = ["en", "es"];

    profiles.max = {
      name = "max";
      isDefault = true;
      settings = {
        CaptivePortal = false;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisableFirefoxAccounts = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        OfferToSaveLoginsDefault = false;
        PasswordManagerEnabled = true;
        browser.newtabpage.activity-stream.showSearch = false;
        browser.newtabpage.activity-stream.showSponsoredTopSites = false;
        browser.newtabpage.activity-stream.feeds.topsites = false;
        browser.newtabpage.activity-stream.feeds.section.topstories = false;
      };

      # https://nur.nix-community.org/repos/rycee/
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        darkreader
        ublock-origin
        # behind-the-overlay-revival
        firenvim
        vimium
      ];

      search = {
        force = true;
        engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icons = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "NixOS Options" = {
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icons = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            # icons = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-os.svg";  # NOTE: Try this after building
            definedAliases = [ "@no" ];
          };
          "NixOS Wiki" = {
            urls = [ { template = "https://nixos.wiki/index.php?search={searchTerms}"; } ];
            icon = "https://nixos.wiki/favicon.png";
            updateInterval = 1000 * 60 * 60 * 24; # daily
            definedAliases = [ "@nw" ];
          };
          "Noogle.dev" = {
            urls = [
              {
                template = "https://noogle.dev/q?term={searchTerms}";
              }
            ];
            icon = "https://nixos.wiki/favicon.png";
            updateInterval = 1000 * 60 * 60 * 24; # daily
            definedAliases = [ "@ng" ];
          };
          "Home Manager Options" = {
            urls = [
              {
                template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=release-25.05";
              }
            ];
            icon = "https://nixos.wiki/favicon.png";
            updateInterval = 1000 * 60 * 60 * 24; # daily
            definedAliases = [ "@ho" ];
          };
        };
        default = "duckduckgo";
      };

      bookmarks = {
        force = true;
        settings = [
          {
            toolbar = true;
            name = "NixOS configs";
            bookmarks = [
              {
                name = "HirschBerge's firefox.nix";
                url = "https://github.com/HirschBerge/Public-dots/blob/main/nixos/common/configs/firefox.nix";
              }
              {
                name = "HirschBerge's gaming.nix";
                url = "https://github.com/HirschBerge/Public-dots/blob/main/nixos/yoitsu/configs/gaming.nix";
              }
              {
                name = "caarlos0 dotfiles";
                url = "https://github.com/caarlos0/dotfiles";
              }
              {
                name = "nix-cheat-sheet";
                url = "https://jdheyburn.co.uk/blog/nix-cheat-sheet";
              }
              {
                name = "nix-tour";
                url = "https://nixcloud.io/tour";
              }
              {
                name = "longerhv-config";
                url = "https://github.com/LongerHV/nixos-configuration";
              }
            ];
          }
        ];
      };
    };
  };
}
