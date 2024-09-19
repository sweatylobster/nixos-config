{ pkgs, ... }: {

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
      users = [ "cowmaster" ];
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
    description = "cowmaster";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    # Not allowed to use keyFiles w/o --impure using flake
    # TODO: Use one and only one ssh key!
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
    cachix
    coreutils # isn't this a darwin thing?
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
  programs.fish.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  services.cron.enable = true;

}
