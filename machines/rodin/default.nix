{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../shared/keyd.nix
    ../shared/linux.nix
    ../shared/hyprland.nix
    ../shared/tailscale.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "rodin"; # Define your hostname.
  networking.networkmanager.enable = true;

  # These need to be moved into a NixOS module:
  # desktop.gnome.enable = true;
  # desktop.hyprland.enable = true;
  # desktop.sway.enable = true;
  # etc.
  programs.sway.enable = true;
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        # command = "set TTY1 (tty); [ \"$TTY1\" = \"/dev/tty1\" ] && exec sway";
        command = "sway";
        user = "max";
      };
      default_session = initial_session;
    };
  };

  # Enable the X11 windowing system.
  services = {
    xserver.enable = false;
    # Enable the GNOME Desktop Environment.
    displayManager = {
      gdm.enable = false;
      autoLogin.enable = true;
      autoLogin.user = "max";
    };
    desktopManager.gnome.enable = false;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.max = {
    isNormalUser = true;
    description = "max";
    extraGroups = [
      "lp"
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILRsgh/gBYgSmvb0wDKSflWna2J+nATtgfbBj4Lv95K9 max.dehoyos@gmail.com"
    ];
  };

  services.mpd = {
    enable = true;
    settings = {
      music_directory = "/home/max/Music/";
    };
  };

  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
