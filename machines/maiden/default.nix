# # Edit this configuration file to define what should be installed on
# # your system.  Help is available in the configuration.nix(5) man page
# # and in the NixOS manual (accessible by running ‘nixos-help’).
{ pkgs, config, ... }:
{

  imports = [
    ../shared/linux.nix
    ../shared/keyd.nix
    ../shared/steam.nix
    # ../shared/hyprland.nix
    # ../shared/nvidia.nix
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Enable networking
  networking = {
    networkmanager.enable = true;
    hostName = "maiden";
  };

  users.users.max = {
    isNormalUser = true;
    extraGroups = [
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

  programs.sway.enable = true;
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "sway";
        user = "max";
      };
      default_session = initial_session;
    };
  };

  # Manage terminal and browser by each system. :)
  environment.systemPackages = [ ];

  # Enable autologin for the primary user.
  # services.displayManager.autoLogin.enable = true;
  # services.displayManager.autoLogin.user = "max";
  #
  # # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  # systemd.services."getty@tty1".enable = false;
  # systemd.services."autovt@tty1".enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
