{ pkgs, ... }: {
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
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
        image_quality = 50; # 50-90
      };
      # https://yazi-rs.github.io/docs/configuration/yazi/#open
      opener = {
        sioyek = [{ run = ''sioyek "$1"''; desc = "sioyek"; }];
        zathura = [{ run = ''zathura "$1"''; desc = "zathura"; }];
      };
      # plugin = {
      #   append_previewers = [
      #     { name = "*"; run = "hexyl"; }
      #     { mime = "text/csv"; run = "miller"; }
      #   ];
      # };
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
      # TODO: gD to navigate to ~/Documents
      # TODO: source plugins:
      # 1. hexyl
      # 2. miller (on .csv only)
      # 3. relative-motions
      tasks.prepend_keymap = [{ on = [ "x" ]; run = [ "cancel" ]; }];
      manager.prepend_keymap = [
        # Defaults
        { on = [ "g" "D" ]; run = "cd ~/Documents"; }
        { on = [ "!" ]; run = "shell \"$SHELL\" --block"; }
        # Plugin dependent
        { on = [ "M" ]; run = "plugin mount"; }
        { on = [ "F" ]; run = "plugin smart-filter"; }
      ];
    };
    plugins =
      let
        yaziPlugins = pkgs.nur.repos.xyenon.yaziPlugins.yazi-rs;
      in
      {
        # attribute set of (path or package)
        # foo = ./foo;
        # bar = pkgs.bar;
        smart-filter = yaziPlugins.smart-filter;
        mount = yaziPlugins.mount;
      };
    flavors = {
      # attribute set of (path or package)
      # myflavor = ./myflavor;
    };
    # initLua = ./init.lua # null or path, default's null
  };
}
