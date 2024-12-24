# # Edit this configuration file to define what should be installed on
# # your system.  Help is available in the configuration.nix(5) man page
# # and in the NixOS manual (accessible by running ‘nixos-help’).
{ pkgs, ... }: {

  imports = [
    ../shared/linux.nix
    ./scanner.nix
    ./hardware-configuration.nix
  ];

  # Enable networking
  networking = {
    networkmanager.enable = true;
    hostName = "melissa";
  };

  fonts.packages = with pkgs.nerd-fonts; [
    fira-mono
    martian-mono
    # (nerdfonts.override { fonts = [ "FiraMono" "MartianMono" ]; })
  ];

  fonts.fontDir.enable = true;

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

  # Manage terminal and browser by each system. :)
  environment.systemPackages = with pkgs; [
    alacritty
    # firefox
  ];

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


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
