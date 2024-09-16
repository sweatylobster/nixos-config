{ pkgs, ... }: {


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking = {
    networkmanager.enable = true;
    hostName = "melissa"; # WARN: had always used hostname
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = ["FiraMono"]; })
  ];

  fonts.fontDir.enable = true;


  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable autologin for the primary user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "cowmaster";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # No sleeping!
  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';


  # Configure keymap in X11
  services.xserver = {

    # Enable the X11 windowing system.
    enable = true;

    # Enable the GNOME Desktop Environment.
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;

    # Set keyboard.
    xkb = {
      layout = "us";
      variant = "";
      # remap caps-lock (the most questionable key real-estate) to escape
      options = "caps:escape";
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # NOTE: Is this a problem?
  security.sudo.extraRules = [
    {
      users = ["cowmaster"];
      commands = [
        {
	  command = "ALL";
	  options = [ "NOPASSWD" ];
	}
      ];
    }
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cowmaster = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "cowmaster";
    extraGroups = [ "networkmanager" "wheel" ];
    # Not allowed to use keyFiles w/o --impure using flake
    openssh.authorizedKeys.keys = [
	"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMDeab1zM5L6cwXHsjyZaiHJB4vMJQLaJhipfVopxHa/ max@bonbon.attlocal.net"
	"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGHDzR8lPwccTL7EYvZXC0bmemvTI3IPzAPVbf3OmA1J max@bonbon.attlocal.net"
	"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC+HhYjyIVm9NTeH8hnpozSdzNE+4wrlY9VvN2tgFOH1 cowmaster@nixos"
    ];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings = {
      auto-optimise-store = true;
      trusted-users = [
        "root"
        "cowmaster"
        "@wheel"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  environment.systemPackages = with pkgs; [
      alacritty
      cachix
      coreutils  # isn't this a darwin thing?
      curl
      git
      jq
      wget
      unzip
  ];


  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.zsh.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  services.cron.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}


# # Edit this configuration file to define what should be installed on
# # your system.  Help is available in the configuration.nix(5) man page
# # and in the NixOS manual (accessible by running ‘nixos-help’).
# 
# { config, pkgs, ... }:
# 
# {
# 
# 
#   programs = {
# 
#     # Install firefox.
#     firefox.enable = true;
# 
#     # Install zsh.
#     zsh = {
#       enable = true;
#       syntaxHighlighting.enable = true;
#     };
#   };
# 
# }
