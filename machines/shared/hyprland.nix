{ pkgs, inputs, ... }:
# let
#   pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
# in
{
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    clipse # clipboard with TUI, history filtering
  ];

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true;
    nvidia = {
      modesetting.enable = true;
      open = true;
      # powerManagement.enable = true;
      # powerManagement.finegrained = true;
      # nvidiaSettings = true;
      # package = config.boot.kernelPackages.nvidiaPackages.stable;
      # prime = {
      #   offload = {
      #     enable = true;
      #     enableOffloadCmd = true;
      #   };
      #   intelBusId = "PCI:0:2:0";
      #   nvidiaBusId = "PCI:1:0:0";
      # };
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  # Trying to fix up framerate: https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
  # hardware.graphics.enable32Bit = true;
  # hardware.nvidia.open = true;
  # hardware.opengl = {
  #   driSupport32Bit = true; # all these have been renamed
  #   package = pkgs-unstable.mesa.drivers;
  #   package32 = pkgs-unstable.pkgsi686Linux.mesa.drivers;
  # };
}
