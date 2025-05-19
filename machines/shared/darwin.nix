{ pkgs, lib, ... }: {

  nixpkgs.config.allowUnfree = true;

  nix.package = pkgs.nix;

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Weekly garbage collection
  nix.gc = {
    automatic = lib.mkDefault true;
    options = lib.mkDefault "--delete-older-than 7d";
  };

  nix.settings.trusted-users = [ "max" ];

  system.stateVersion = 5;

  programs.zsh.enable = true;
  programs.fish.enable = true;

  environment.shells = with pkgs; [
    zsh
    fish
  ];

  system.primaryUser = "max";

  users.users.max = {
    name = "max";
    home = "/Users/max";
    shell = pkgs.fish;
  };

  services.sketchybar = {
    enable = false;
  };

  services.aerospace = {
    enable = true;
    # https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-services.aerospace.settings
    settings = {
      start-at-login = false; # False lets `launchd` handle it.
      gaps = {
        inner.horizontal = 10;
        inner.vertical = 10;
        outer.left = 10;
        outer.bottom = 10;
        outer.top = 10;
        outer.right = 10;
      };
      mode.main.binding = {
        # See: https://nikitabobko.github.io/AeroSpace/commands#layout
        alt-slash = "layout tiles horizontal vertical";
        alt-comma = "layout accordion horizontal vertical";

        # See: https://nikitabobko.github.io/AeroSpace/commands#focus
        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";

        # See: https://nikitabobko.github.io/AeroSpace/commands#move
        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";

        # See: https://nikitabobko.github.io/AeroSpace/commands#resize
        alt-minus = "resize smart -50";
        alt-equal = "resize smart +50";

        # See: https://nikitabobko.github.io/AeroSpace/commands#workspace
        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-6 = "workspace 6";
        alt-7 = "workspace 7";
        alt-8 = "workspace 8";
        alt-9 = "workspace 9";

        # See: https://nikitabobko.github.io/AeroSpace/commands#move-node-to-workspace
        alt-shift-1 = "move-node-to-workspace 1";
        alt-shift-2 = "move-node-to-workspace 2";
        alt-shift-3 = "move-node-to-workspace 3";
        alt-shift-4 = "move-node-to-workspace 4";
        alt-shift-5 = "move-node-to-workspace 5";
        alt-shift-6 = "move-node-to-workspace 6";
        alt-shift-7 = "move-node-to-workspace 7";
        alt-shift-8 = "move-node-to-workspace 8";
        alt-shift-9 = "move-node-to-workspace 9";

        # See: https://nikitabobko.github.io/AeroSpace/commands#workspace-back-and-forth
        alt-tab = "workspace-back-and-forth";

        alt-shift-semicolon = "mode service";
      };
      mode.service.binding = {
        r = [ "flatten-workspace-tree" "mode main" ];
        f = [ "layout floating tiling" "mode main" ];

        alt-shift-h = [ "join-with left" "mode main" ];
        alt-shift-j = [ "join-with down" "mode main" ];
        alt-shift-k = [ "join-with up" "mode main" ];
        alt-shift-l = [ "join-with right" "mode main" ];
      };
    };
  };

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap"; # rm brews && casks (w/ assoc. files) if not defined below.
    };
    casks = [
      "blender"
      "brave-browser"
      "discord"
      "halloy" # IRC client made w/ iced.rs
      "obsidian"
      "sioyek"
      "spotify"
      "whatsapp"
    ];
    brews = [
      "m-cli" # exposes options for use in `system.defaults.CustomUserPreferences` downstairs
    ];
  };

  # TODO: Figure out what you want
  fonts.packages = with pkgs.nerd-fonts; [
    fira-mono
    martian-mono
    jetbrains-mono
  ];

  system = {

    defaults = {
      menuExtraClock.Show24Hour = true;

      dock = {
        autohide = true;
        autohide-delay = 0.0;
        orientation = "bottom";
        tilesize = 54;
        showhidden = true;
        show-recents = true;
        show-process-indicators = true;
        expose-animation-duration = 0.1;
        expose-group-apps = true;
        launchanim = false;
        mineffect = "scale"; # I think I use "genie";
        mru-spaces = false;
        persistent-apps = [
          "/Applications/Safari.app"
          "/System/Applications/Calendar.app"
          "/Applications/Ghostty.app"
          "/Applications/Obsidian.app"
          "/Applications/Monodraw.app"
          "/System/Applications/Mail.app"
          "/System/Applications/Messages.app"
          "/Applications/WhatsApp.app"
          "/Applications/Discord.app"
          "/Applications/Spotify.app"
        ];
      };

      finder = {
        FXPreferredViewStyle = "Nlsv"; # [ "icnv" "clmv" "Flwv" ];
        _FXShowPosixPathInTitle = true;
        FXEnableExtensionChangeWarning = false;
        AppleShowAllFiles = true;
        ShowStatusBar = true;
        ShowPathbar = true;
      };

      loginwindow = {
        # GuestEnabled = false; # disable guest user
        LoginwindowText =
          # "o(｀^´*);";
          # "（；￣︶￣）";
          "⊂((。・o・))⊃";
          # "(゜￢゜)";
          # "♫꒰･◡･๑꒱";
        # "(╭ರ_⊙)";
        # "(゜ロ゜)";
        # "┌（・Σ・）┘≡З";
        # "(／‵Д′)／~ ╧╧";
        SHOWFULLNAME = false; # show full name in login window
      };

      NSGlobalDomain = {
        ApplePressAndHoldEnabled = false;
        KeyRepeat = 2;
        InitialKeyRepeat = 15;
        AppleShowScrollBars = "Always";
        NSWindowResizeTime = 0.1;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        AppleInterfaceStyle = "Dark";
        NSDocumentSaveNewDocumentsToCloud = false; # disabled by default.
        _HIHideMenuBar = false;
        "com.apple.springing.delay" = 0.0;
        "com.apple.trackpad.forceClick" = true;
      };

      # rgcr/m-cli
      # defaults: `defaults read | bat` (it's really long)
      CustomUserPreferences = {
        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
          # allowIdentifierForAdvertising = false;
        };
        "com.apple.NetworkBrowser" = { BrowseAllInterfaces = true; };
        "com.apple.screensaver" = {
          askForPassword = true;
          askForPasswordDelay = 0;
        };
        "com.apple.trackpad" = { scaling = 2; }; # TODO: Not sure about these
        "com.apple.mouse" = { scaling = 2.5; };
        "com.apple.desktopservices" = { DSDontWriteNetworkStores = false; };
        "com.apple.LaunchServices" = { LSQuarantine = true; }; # TODO: Default, but not sure what it means
        "com.apple.spaces" = {
          spans-displays = true;
        };
        "com.apple.finder" = {
          ShowExternalHardDrivesOnDesktop = true;
          ShowRemovableMediaOnDesktop = true;
          WarnOnEmptyTrash = false;
          _FXSortFoldersFirst = true;
          # When performing a search, search the current folder by default
          FXDefaultSearchScope = "SCcf";
        };
        "NSGlobalDomain" = {
          NSNavPanelExpandedStateForSaveMode = true;
          NSTableViewDefaultSizeMode = 1;
          WebKitDeveloperExtras = true;
        };
        # Prevent Photos from opening automatically when devices are plugged in
        "com.apple.ImageCapture" = { "disableHotPlug" = true; };
        "com.apple.dock" = {
          size-immutable = true;
        };
        # ❯ nix --extra-experimental-features 'nix-command flakes' run nix-darwin -- switch --flake ~/nixos-config
        #           ...
        #           ...
        # user defaults...
        # 2024-09-21 11:44:39.996 defaults[60490:1591027] Could not write domain /Users/max/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari; exiting
        # user defaults...
        # 2024-09-21 11:45:21.133 defaults[60779:1615543] Could not write domain /Users/max/Library/Containers/com.apple.mail/Data/Library/Preferences/com.apple.mail; exiting
        #
        # "com.apple.mail" = {
        #   DisableReplyAnimations = true;
        #   DisableSendAnimations = true;
        #   DisableInlineAttachmentViewing = true;
        #   AddressesIncludeNameOnPasteboard = true;
        #   InboxViewerAttributes = {
        #     DisplayInThreadedMode = "yes";
        #     SortedDescending = "yes";
        #     SortOrder = "received-date";
        #   };
        #   NSUserKeyEquivalents = {
        #     # TODO: Shouldn't hurt, but I should at least know what they are
        #     Send = "@\U21a9";
        #     Archive = "@$e";
        #   };
        # };
        # NOTE: I don't really use Safari, but this all seems fine.
        # "com.apple.Safari" = {
        #   IncludeInternalDebugMenu = true;
        #   IncludeDevelopMenu = true;
        #   WebKitDeveloperExtrasEnabledPreferenceKey = true;
        #   ShowFullURLInSmartSearchField = true;
        #   AutoOpenSafeDownloads = false;
        #   HomePage = "";
        #   AutoFillCreditCardData = false;
        #   AutoFillFromAddressBook = false;
        #   AutoFillMiscellaneousForms = false;
        #   AutoFillPasswords = false;
        #   "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" = true;
        #   AlwaysRestoreSessionAtLaunch = 0; # TODO: Maybe disable: 1 -> 0.
        #   ExcludePrivateWindowWhenRestoringSessionAtLaunch = 0; # TODO: No need for Private Windows: 1 -> 0.
        #   ShowBackgroundImageInFavorites = 0;
        #   ShowFrequentlyVisitedSites = 1;
        #   ShowHighlightsInFavorites = 1;
        #   ShowPrivacyReportInFavorites = 1;
        #   ShowRecentlyClosedTabsPreferenceKey = 1;
        # };
        # NOTE: Seems like we can configure other apps here, as well.
        # "com.amethyst.Amethyst" = {
        #   SUAutomaticallyUpdate = 0;
        #   SUEnableAutomaticChecks = 0;
        #   "mouse-follows-focus" = 0;
        #   "new-windows-to-main" = 0;
        #   "screen-padding-bottom" = 15;
        #   "screen-padding-left" = 15;
        #   "screen-padding-right" = 15;
        #   "screen-padding-top" = 15;
        # };
      };

      # Final default.
      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
    };
    ### defaults = {...}; end

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };

  };

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;
}
