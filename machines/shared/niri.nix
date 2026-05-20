{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    niri
    xwayland-satellite
    fuzzel
    swaybg
  ];
}
