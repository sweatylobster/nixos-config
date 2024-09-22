{ pkgs, lib, ... }: {

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  nixpkgs.config.allowUnfree = true;

  services.nix-daemon.enable = true;

  # nix version needs to be >= 2.20 to avoid this error that thwarts a build:
  # `error: profile manifest "$HOME/.local/state/nix/profiles/profile/manifest.json": has unsupported version 3
  # On unstable, pkgs.nix purportedly points to nix version 2.18.2.
  # See: https://github.com/NixOS/nix/issues/10628#issuecomment-2170702163
  #
  # Manually declare the nix version >= 2.20.
  # nix.package = pkgs.nixVersions.nix_2_23;
  # nix.package = pkgs.nixFlakes;
  nix.package = pkgs.nix;

  # Weekly garbage collection
  nix.gc = {
    automatic = lib.mkDefault true;
    options = lib.mkDefault "--delete-older-than 7d";
  };

  nix.settings.trusted-users = [ "root" "max" ];

  system.stateVersion = 5;

  programs.zsh.enable = true;
  programs.fish.enable = true;

  environment.shells = with pkgs; [
    zsh
    fish
  ];


  users.users.max = {
    name = "max";
    home = "/Users/max";
    shell = pkgs.zsh;
  };

  homebrew = {
    enable = true;
    casks = [
      # "deckset" # might buy; .md -> presentation slides.
      "discord"
      "font-martian-mono"
      # "font-jetbrains-mono-nerd-font"
      "hammerspoon"
      # "monodraw" # might buy; ASCII diagrams.
      # "soulver" # might buy; text calculator for dates, measurements, etc.
      "raycast"
      "whatsapp"
    ];
    brews = [
      "m-cli" # expose options for use in `CustomUserPreferences`
    ];
    # NOTE: Today's the only cool one.
    masApps = {
      # "Today •" = 2146219664; always fails for some reason
    };
  };

  # TODO: Figure out what you want
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraMono" "MartianMono" ]; })
  ];

  system = {

    defaults = {
      menuExtraClock.Show24Hour = true;

      dock = {
        autohide = true;
        autohide-delay = 0.0;
        orientation = "bottom";
        tilesize = 42;
        showhidden = true;
        show-recents = true;
        show-process-indicators = true;
        expose-animation-duration = 0.1;
        expose-group-by-app = true;
        launchanim = false;
        mineffect = "scale"; # I think I use "genie";
        mru-spaces = false;
        persistent-apps = [
          "/System/Applications/Reminders.app" # i guess
          # "/Applications/Todoist.app"         # don't have
          # "/System/Applications/Notes.app"    # just use nvim
          "/System/Applications/Calendar.app"
          "/Applications/Firefox.app" # NOTE: my addition
          # "/System/Cryptexes/App/System/Applications/Safari.app"
          # "/Applications/Ghostty.app"         # don't have
          "/Applications/iTerm.app"
          "/System/Applications/Mail.app"
          "/System/Applications/Messages.app"
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

      # loginwindow = {
      #   GuestEnabled = false; # disable guest user
      #   SHOWFULLNAME = true; # show full name in login window
      # };

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
        #   AlwaysRestoreSessionAtLaunch = 1; # TODO: Maybe disable: 1 -> 0.
        #   ExcludePrivateWindowWhenRestoringSessionAtLaunch = 1; # TODO: No need for Private Windows: 1 -> 0.
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
  security.pam.enableSudoTouchIdAuth = true;
}
