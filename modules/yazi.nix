{ ... }: {
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
    settings = {
      log = {
        enabled = false;
      };
      manager = {
        ratio = [ 1 3 4 ];
        sort_by = "natural";
        sort_dir_first = true;
        show_hidden = false;
        show_symlink = true;
      };
      preview = {
        wrap = "no";
        tab_size = 2;
        max_width = 2000;
        max_height = 2000;
        image_delay = 0; # immediately render.
        image_filter = "nearest"; # [ nearest triangle catmull-rom gaussian lanczos3 ]
        image_quality = 69; # 50-90
      };
      # https://yazi-rs.github.io/docs/configuration/yazi/#open
      opener = {
        sioyek = [{ run = ''sioyek "$1"''; desc = "sioyek"; }];
        zathura = [{ run = ''zathura "$1"''; desc = "zathura"; }];
      };
      plugin = {
        append_previewers = [
          { name = "*"; run = "hexyl"; }
          { mime = "text/csv"; run = "miller"; }
        ];
      };
      open = {
        prepend_rules = [
          {
            name = "*.pdf";
            use = [
              "sioyek"
              "zathura"
              "open"
              "reveal"
            ];
          }
          { name = "*.tex"; use = [ "edit" ]; }
        ];
      };
    };
    # yazi = ""; # TOML value
    # theme = ""; # TOML value
    # https://yazi-rs.github.io/docs/configuration/keymap/
    keymap = {
      # manager.prepend_keymap = [ ];
      tasks.prepend_keymap = [{ on = [ "x" ]; run = [ "cancel" ]; }];
      manager.prepend_keymap = [
        { on = [ "1" ]; run = "plugin relative-motions --args=1"; }
        { on = [ "2" ]; run = "plugin relative-motions --args=2"; }
        { on = [ "3" ]; run = "plugin relative-motions --args=3"; }
        { on = [ "4" ]; run = "plugin relative-motions --args=4"; }
        { on = [ "5" ]; run = "plugin relative-motions --args=5"; }
        { on = [ "6" ]; run = "plugin relative-motions --args=6"; }
        { on = [ "7" ]; run = "plugin relative-motions --args=7"; }
        { on = [ "8" ]; run = "plugin relative-motions --args=8"; }
        { on = [ "9" ]; run = "plugin relative-motions --args=9"; }
      ];
    };
    plugins = {
      # attribute set of (path or package)
      # foo = ./foo;
      # bar = pkgs.bar
    };
    flavors = {
      # attribute set of (path or package)
      # myflavor = ./myflavor;
    };
    # initLua = ./init.lua # null or path, default's null
  };
}
