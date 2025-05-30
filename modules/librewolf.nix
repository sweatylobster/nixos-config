{ pkgs, inputs, ... }: {
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
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
            icons = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "NixOS Options" = {
            urls = [{
              template = "https://search.nixos.org/options";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
            icons = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            # icons = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-os.svg";  # NOTE: Try this after building
            definedAliases = [ "@no" ];
          };
          "NixOS Wiki" = {
            urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
            icon = "https://nixos.wiki/favicon.png";
            updateInterval = 1000 * 60 * 60 * 24; # daily
            definedAliases = [ "@nw" ];
          };
          "Home Manager Options" = {
            urls = [{
              template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=release-24.11";
            }];
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
            ];
          }
        ];
      };
    };
  };
}
