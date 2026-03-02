# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../shared/keyd.nix
    ../shared/linux.nix
    ../shared/scanner.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "chinguini"; # Define your hostname.
  networking.networkmanager.enable = true;

  services.xserver.xkb = {
    layout = "us";
  };

  users.users.max = {
    isNormalUser = true;
    description = "max";
    extraGroups = [
      "networkmanager"
      "wheel"
      "lp"
    ];
    packages = with pkgs; [ ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILRsgh/gBYgSmvb0wDKSflWna2J+nATtgfbBj4Lv95K9 max.dehoyos@gmail.com"
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
  ];

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.sway.enable = true;
  programs.fish.enable = true;

  services = {

    avahi.enable = true;
    avahi.nssmdns4 = true;

    cron.enable = true;

    openssh.enable = true;
    openssh.settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };

    tailscale.enable = true;

    greetd.enable = true;
    greetd.settings = rec {
      initial_session = {
        command = "sway";
        user = "max";
      };
      default_session = initial_session;
    };

  };

  system.stateVersion = "25.11";
}
