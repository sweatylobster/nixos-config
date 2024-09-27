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
        ratio = [ 1 4 3 ];
        sort_by = "natural";
        sort_dir_first = true;
        show_hidden = false;
        show_symlink = true;
      };
      preview = {
        wrap = "no";
        # tab_size = "";
        # max_width = "";
        # max_height = "";
        image_delay = 40; # don't immediately render.
        image_filter = "nearest"; # [ nearest triangle catmull-rom gaussian lanczos3 ]
        image_quality = 50; # 50-90
      };
      # https://yazi-rs.github.io/docs/configuration/yazi/#open
      opener = {
        sioyek = [
          {
            run = ''sioyek "$@"'';
            desc = "sioyek";
          }
        ];
        zathura = [
          {
            run = ''zathura "$@"'';
            desc = "zathura";
          }
        ];
      };
      open = {
        prepend_rules = [
          {
            name = "*.pdf";
            use = "{sioyek, zathura}";
          }
        ];
      };
    };
    # yazi = ""; # TOML value
    # theme = ""; # TOML value
    # https://yazi-rs.github.io/docs/configuration/keymap/
    # keymap = ''
    # ''; # TOML value
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
