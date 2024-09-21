{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
  };
  services = { nix-daemon = { enable = true; }; };
  nix.package = pkgs.nix;
  nix.settings.trusted-users = [ "root" "max" ];
  system.stateVersion = 5; # TODO: what is this, mitchell?

  # ids.uids.nixbld = 300; # TODO: Trying to outrun fate of MacOS 15

  users.users.max = {
    name = "max";
    home = "/Users/max";
  };

  homebrew = {
    enable = true;
    casks = [
      # "deckset"       # might buy; .md -> presentation slides.
      "discord"
      # "font-jetbrains-mono"
      # "font-jetbrains-mono-nerd-font"
      "hammerspoon"
      # "monodraw"      # might buy; ASCII diagrams.
      # "soulver"       # might buy; text calculator for dates, measurements, etc.
      "whatsapp"
    ];
    # NOTE: Today's the only cool one.
    masApps = {
      # "Today •" = 2146219664; always fails for some reason
    };
  };

  system = {
    defaults = {
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
          "/System/Applications/Firefox.app" # NOTE: my addition
          # "/System/Cryptexes/App/System/Applications/Safari.app"
          # "/Applications/Ghostty.app"         # don't have
          "/System/Applications/Mail.app"
          "/System/Applications/Messages.app"
          "/Applications/Discord.app"
          # "/System/Applications/Music.app"    # wtf
          "/System/Applications/Spotify.app"
        ];
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
        NSDocumentSaveNewDocumentsToCloud = false; # TODO: Do I want this?
        _HIHideMenuBar = false;
        "com.apple.springing.delay" = 0.0;
      };
      finder = {
        FXPreferredViewStyle = "Nlsv"; # TODO: What the hell
        _FXShowPosixPathInTitle = true;
        FXEnableExtensionChangeWarning = false;
        AppleShowAllFiles = true;
        ShowStatusBar = true;
        ShowPathbar = true;
      };
      CustomUserPreferences = {
        "com.apple.NetworkBrowser" = { BrowseAllInterfaces = true; };
        "com.apple.screensaver" = {
          askForPassword = true;
          askForPasswordDelay = 0;
        };
        "com.apple.trackpad" = { scaling = 2; }; # TODO: Not sure about these
        "com.apple.mouse" = { scaling = 2.5; };
        "com.apple.desktopservices" = { DSDontWriteNetworkStores = false; };
        "com.apple.LaunchServices" = { LSQuarantine = true; }; # TODO: What does this mean
        "com.apple.finder" = {
          ShowExternalHardDrivesOnDesktop = false;
          ShowRemovableMediaOnDesktop = false;
          WarnOnEmptyTrash = false;
        };
        "NSGlobalDomain" = {
          NSNavPanelExpandedStateForSaveMode = true;
          NSTableViewDefaultSizeMode = 1;
          WebKitDeveloperExtras = true;
        };
        "com.apple.ImageCapture" = { "disableHotPlug" = true; }; # TODO: What
        # NOTE: I don't use Mail; maybe should.
        "com.apple.mail" = {
          DisableReplyAnimations = true;
          DisableSendAnimations = true;
          DisableInlineAttachmentViewing = true;
          AddressesIncludeNameOnPasteboard = true;
          InboxViewerAttributes = {
            DisplayInThreadedMode = "yes";
            SortedDescending = "yes";
            SortOrder = "received-date";
          };
          NSUserKeyEquivalents = {
            # TODO: Shouldn't hurt, but I should at least know what they are
            Send = "@\U21a9";
            Archive = "@$e";
          };
        };
        "com.apple.dock" = {
          size-immutable = true;
        };
        # NOTE: I don't really use Safari, but this all seems fine.
        "com.apple.Safari" = {
          IncludeInternalDebugMenu = true;
          IncludeDevelopMenu = true;
          WebKitDeveloperExtrasEnabledPreferenceKey = true;
          ShowFullURLInSmartSearchField = true;
          AutoOpenSafeDownloads = false;
          HomePage = "";
          AutoFillCreditCardData = false;
          AutoFillFromAddressBook = false;
          AutoFillMiscellaneousForms = false;
          AutoFillPasswords = false;
          "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" = true;
          AlwaysRestoreSessionAtLaunch = 1; # TODO: Maybe disable: 1 -> 0.
          ExcludePrivateWindowWhenRestoringSessionAtLaunch = 1; # TODO: No need for Private Windows: 1 -> 0.
          ShowBackgroundImageInFavorites = 0;
          ShowFrequentlyVisitedSites = 1;
          ShowHighlightsInFavorites = 1;
          ShowPrivacyReportInFavorites = 1;
          ShowRecentlyClosedTabsPreferenceKey = 1;
        };
      };
    };
  };
}
