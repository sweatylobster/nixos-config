{ inputs, pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    # config.common.default = "gnome";

  };
  environment.systemPackages = with pkgs; [
    niri
    xwayland-satellite
    fuzzel
    swaybg
    pipewire
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
