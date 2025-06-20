# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ home, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../shared/keyd.nix
      ../shared/linux.nix
      ../shared/hyprland.nix
      ../shared/sway.nix
      ../shared/tailscale.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "rodin"; # Define your hostname.
  networking.networkmanager.enable = true;

  # These need to be moved into a NixOS module:
  # desktop.gnome.enable = true;
  # desktop.hyprland.enable = true;
  # desktop.sway.enable = true;
  # etc.
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


  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.max = {
    isNormalUser = true;
    description = "max";
    extraGroups = [ "lp" "networkmanager" "wheel" ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILRsgh/gBYgSmvb0wDKSflWna2J+nATtgfbBj4Lv95K9 max.dehoyos@gmail.com"
    ];
  };

  services.mpd = {
    enable = true;
    # musicDirectory = "${home.homeDirectory}/Music/";
    musicDirectory = "/home/max/Music/";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
