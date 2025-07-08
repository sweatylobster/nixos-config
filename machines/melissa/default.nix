# # Edit this configuration file to define what should be installed on
# # your system.  Help is available in the configuration.nix(5) man page
# # and in the NixOS manual (accessible by running ‘nixos-help’).
{ pkgs, ... }:
{

  imports = [
    ../shared/linux.nix
    ../shared/keyd.nix
    ../shared/tailscale.nix
    ./hardware-configuration.nix
    # ./printer.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking = {
    networkmanager.enable = true;
    hostName = "melissa";
  };

  users.users.cowmaster = {
    isNormalUser = true;
    description = "cowmaster";
    extraGroups = [
      "scanner"
      "lp"
      "networkmanager"
      "wheel"
      "input"
    ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILRsgh/gBYgSmvb0wDKSflWna2J+nATtgfbBj4Lv95K9 max.dehoyos@gmail.com"
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    texliveFull
  ];

  services = {
    # Use X11
    xserver.enable = true;
    # Enable the GNOME Desktop Environment.
    desktopManager.gnome.enable = true;
    # Enable autologin for the primary user.
    displayManager = {
      gdm.enable = true;
      autoLogin.enable = true;
      autoLogin.user = "cowmaster";
    };
  };

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
