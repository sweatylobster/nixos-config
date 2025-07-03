{ pkgs, ... }:
{

  imports = [
    ./fnott.nix
    ./hyprpaper.nix
    ./waybar.nix
    # ./wofi.nix
    ../terminal-emulators/kitty.nix
  ];

  services.hyprpolkitagent.enable = true;
  # Like f.lux.
  services.hyprsunset.enable = true;
  # Hyprlock
  security.pam.services.hyprlock.enable = true;
  programs.hyprlock.enable = true;

  wayland.windowManager.hyprland =
    # potential refactor idea
    let
      terminal = "${pkgs.kitty}/bin/kitty";
      browser = "${pkgs.librewolf}/bin/librewolf";
      launcher = "${pkgs.wmenu}/bin/wmenu-run";
      # etc.
    in
    {
      enable = true;
      package = null;
      portalPackage = null;
      systemd.enable = true;
      settings = {
        "$mod" = "SUPER";
        # monitor = "DVI-D-1, 1920x1080@144, 0x0, 1";
        monitor = "DP-1, 1920x1080@144, 0x0, 1";
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
          "$mod, mouse_up, workspace, e+1"
          "$mod, mouse_down, workspace, e-1"
        ];
        bind =
          [
            # programs
            "$mod, Return, exec, ${terminal}" # term
            "$mod, Space, exec, ${launcher}" # *minimal* app-launcher
            "$mod, b, exec, ${browser}" # browser
            ", Print, exec, grimblast copy area" # screenshot
            "$mod, V, exec, ${terminal} --class clipse -e clipse" # clipboard
            "$mod, x, exec, ${terminal} --class htop-float -e htop" # process viewer
            "$mod, Q, killactive, " # like alt-f4

            "$mod + shift, Q, killactive, " # like alt-f4
          ]
          ++ [
            # tiling
            "$mod, Slash, togglesplit, "
            "$mod, Comma, pseudo, "
            "$mod, f, togglefloating, "
          ]
          ++ [
            # focus
            "$mod, h, movefocus, l"
            "$mod, j, movefocus, u"
            "$mod, k, movefocus, d"
            "$mod, l, movefocus, r"
          ]
          ++ [
            # workspace movement
            "$mod + ctrl, h, workspace, -1"
            "$mod + ctrl, l, workspace, +1"
            "$mod + shift + ctrl, h, movetoworkspace, -1"
            "$mod + shift + ctrl, l, movetoworkspace, +1"
          ]
          ++ (builtins.concatLists (
            builtins.genList
              (
                i:
                let
                  ws = i + 1;
                in
                [
                  "$mod, code:1${toString i}, workspace, ${toString ws}"
                  "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                ]
              ) 9
          ) # i.e., up to workspace 9
          );
      };
    };
}
