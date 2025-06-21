{ ... }: {

  imports = [
    ./fnott.nix
    ./hyprpaper.nix
    ./waybar.nix
  ];

  services.hyprpolkitagent.enable = true;
  services.hyprsunset.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.enable = true;
    settings = {
      "$mod" = "SUPER";
      monitor = "DVI-D-1, 1920x1080@144, 0x0, 1";
      cursor.no_hardware_cursors = true;
      exec-once = [
        "clipse -listen" # clipboard history TUI made with BubbleTea
        "waybar"
      ];
      input = {
        repeat_delay = 300;
        repeat_rate = 50;
        follow_mouse = 1; # 0: cursor does not change focus; 1: cursor changes focus; 2: clicking changes keyboard focus; 3: mouse and keyboard have different focuses
      };
      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      ];
      windowrule = [
        # BubbleTea clipboard app
        "float, class:(clipse)"
        "size 622 652, class:(clipse)"
        "stayfocused, class:(clipse)"
        # htop waybar tooltip for CPU
        "float, class:(htop-float)"
        "size 1400 652, class:(htop-float)"
        "stayfocused, class:(htop-float)"
      ];
      bindm = [
        # mouse movements
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bind = [
        # programs
        "$mod, e, exec, kitty"
        "$mod, f, exec, librewolf"
        ", Print, exec, grimblast copy area"
        "$mod, V, exec, kitty --class clipse -e clipse"
        "$mod, x, exec, kitty --class htop-float -e htop"
        "$mod, Q, killactive, "
      ] ++ [
        # workspace movement
        "alt + ctrl, h, workspace, -1"
        "alt + ctrl, l, workspace, +1"
        "alt + shift + ctrl, h, movetoworkspace, -1"
        "alt + shift + ctrl, l, movetoworkspace, +1"
      ]
      ++ (
        builtins.concatLists (builtins.genList
          (i:
            let ws = i + 1;
            in [
              "alt, code:1${toString i}, workspace, ${toString ws}"
              "alt SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9) # i.e., up to workspace 9
      );
    };
  };
}
