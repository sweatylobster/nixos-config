{ ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    # NOTE: Must be these values with home-manager.
    # TODO: Link to reputable source; xD
    package = null;
    portalPackage = null;
    systemd.enable = true;
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    settings = {
      "$mod" = "SUPER";
      monitor = "DVI-D-1, 1920x1080@144, 0x0, 1";
      cursor.no_hardware_cursors = true;
      exec-once = [
        # NOTE: Trying home-manager.services.hyprpaper = {}; config below.
        # FIX: Turn this back on, as well as /home/cowmaster/nixos-config/machines/shared/hyprland.nix:9
        # "hyprpaper"
        "clipse -listen"
      ];
      input = {
        repeat_delay = 300;
        repeat_rate = 50;
      };
      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      ];
      windowrule = [
        "float, class:(clipse)"
        "size 622 652, class:(clipse)"
        "stayfocused, class:(clipse)"
      ];
      bindm = [
        # mouse movements
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bind = [
        # programs
        "$mod, e, exec, kitty"
        "$mod, f, exec, firefox"
        ", Print, exec, grimblast copy area"
        "$mod, V, exec, kitty --class clipse -e clipse"
      ] ++ [
        "$mod + ctrl, h, workspace, e-1"
        "$mod + ctrl, l, workspace, e+1"
        "$mod, mouse_down, workspace, e-1"
        "$mod, mouse_up, workspace, e+1"
      ]
      ++ (
        builtins.concatLists (builtins.genList
          (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9)
      );
    };
  };

  # hyprpaper config for wallpapers; weeb defaults aren't for me
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = "/home/cowmaster/Pictures/moebius-city.jpg";
      wallpaper = ", /home/cowmaster/Pictures/moebius-city.jpg";
    };
  };

  # home.file.".config/hypr/hyprpaper.conf" = {
  #   text = ''
  #     preload = /home/cowmaster/Pictures/rorschach.jpg
  #     wallpaper = , /home/cowmaster/Pictures/rorschach.jpg
  #   '';
  # };
}
