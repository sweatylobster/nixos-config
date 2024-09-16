# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./fonts.nix
      # <home-manager/nixos>
    ];

  # test out timers
  systemd.timers."hello-world" = {
    wantedBy = [ "timers.target" ];
      timerConfig = {
      OnBootSec = "1m";
      OnUnitActiveSec = "1m";
      Unit = "hello-world.service";
      OnCalendar = "daily";
      Persistent = true;
      };
  };

  systemd.services."hello-world" = {
    # how can I load a script from $HOME/code/aguila/billing/appts/ like appts pull?
    script = ''
      set -eu
      cd /home/cowmaster/code/aguila
      sheets update hx
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };

  # Install just FiraMono?
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = ["FiraMono"]; })
  ];

  # Set EDITOR
  environment.variables.EDITOR = "nvim";

  # Enable flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "root" "cowmaster" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # https://nixos.wiki/wiki/Networking
  networking = {
    hostName = "melissa"; # Define your hostname.
    # NOTE: Can't enable with `networkmanager.enable = true;`
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networkmanager.enable = true;

    # Disable firewall, maybe.
    # firewall = {
      # allowedTCPPorts = [ 22 ];
      # allowedUDPPorts = [ ... ];
      # Or disable the firewall altogether.
      # enable = false;
    # };
  };

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

  # Configure keymap in X11
  services.xserver = {

    # Enable the X11 windowing system.
    enable = true;

    # Enable the GNOME Desktop Environment.
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;

    # Enable touchpad support (enabled default in most desktopManager).
    # libinput.enable = true;

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cowmaster = {
    isNormalUser = true;
    # shell = pkgs.zsh;
    description = "cowmaster";
    extraGroups = [ "networkmanager" "wheel" ];
    # Not allowed to use keyFiles w/o --impure using flake
    openssh.authorizedKeys.keys = [
	"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMDeab1zM5L6cwXHsjyZaiHJB4vMJQLaJhipfVopxHa/ max@bonbon.attlocal.net"
	"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGHDzR8lPwccTL7EYvZXC0bmemvTI3IPzAPVbf3OmA1J max@bonbon.attlocal.net"
	"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC+HhYjyIVm9NTeH8hnpozSdzNE+4wrlY9VvN2tgFOH1 cowmaster@nixos"
    ];
    #openssh.authorizedKeys.keyFiles = [
      #"/home/cowmaster/.ssh/authorized_keys"
    #];
  };

  # home-manager.useGlobalPkgs = true;

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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    bat
    bat-extras.batman
    devenv
    eza
    fd
    fzf
    hackrf
    #geckodriver
    gh
    git
    gqrx
    lunarvim
    nerdfonts
    nh
    nix-direnv
    nodejs_22
    python313
    qFlipper
    ripgrep
    sioyek
    starship
    texliveFull
    unzip
    vesktop
    wget
    zathura
    zig
    zoxide
  ];

  fonts.fontDir.enable = true;

  programs = {

    # Install firefox.
    firefox.enable = true;

    # Install direnv.
    direnv.enable = true;

    # Install zsh.
    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
    };

    # Install tmux with some plugins.
    tmux = {
      enable = true;
      escapeTime = 0;
      terminal = "screen-256color";
      baseIndex = 1;
      clock24 = true;
      keyMode = "vi";
      plugins = with pkgs.tmuxPlugins; [
	extrakto
	catppuccin
	tmux-thumbs
	better-mouse-mode
	copy-toolkit
      ];
      extraConfig = ''

        # new prefix
        unbind C-b
	set -g prefix C-s

	# vi pane movement
        bind -r h select-pane -L
        bind -r j select-pane -D
        bind -r k select-pane -U
        bind -r l select-pane -R
        bind -r C-h select-window -t :-
        bind -r C-l select-window -t :+

	# window in same path
	bind c new-window -c "#{pane_current_path}"

	# copy-mode binds
	bind-key -T copy-mode-vi v send-keys -X begin-selection
	bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle \; send -X begin-selection
	bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

	# ueberzug
	set -g allow-passthrough on
	set -ga update-environment TERM
	set -ga update-environment TERM_PROGRAM
      '';
    };

  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #  enable = true;
  #  enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [
      22
    ];
    # disable password auth for improved security (someone needs public key)
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  networking = {

    # sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
    # sudo nix-env --switch-generation <generation> --profile /nix/var/nix/profiles/system
    # interfaces.wlo1 = {
    #  useDHCP = false;
    #  ipv6.addresses = [ {
    #    address = "2600:1700:cb90:7d50::2e";
    #    prefixLength = 64;
    #  } ];
    # };
    # defaultGateway = "192.168.1.254";  # get with `route -n`
    # nameservers = ["192.168.1.254" "8.8.8.8"];  # not sure why i need 8.8.8.8
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
