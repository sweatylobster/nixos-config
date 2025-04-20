{ pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    gamescope # steam options https://github.com/ValveSoftware/gamescope
    # hyprpaper # wallpapers # trying out through home-manager.services.hyprpaper.enable = true;
    hyprpolkitagent # privilege-escalation daemon
    hyprsunset # blue-light and gamma filter
    clipse # clipboard with TUI, history filtering
  ];

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    graphics.enable = true;
    nvidia.modesetting.enable = true;
  };
}
