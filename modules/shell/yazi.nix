{ pkgs, ... }: {
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";
    settings = {
      log = {
        enabled = false;
      };
      mgr = {
        ratio = [ 1 3 4 ];
        sort_by = "natural";
        sort_dir_first = true;
        show_hidden = false;
        show_symlink = true;
      };
      preview = {
        wrap = "no";
        tab_size = 2;
        max_width = 1000;
        max_height = 1000;
        image_delay = 90;
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
      # TODO: source plugins:
      # relative-motions
      tasks.prepend_keymap = [{ on = [ "x" ]; run = [ "cancel" ]; }];
      mgr.prepend_keymap = [
        # Teleporting
        { on = [ "g" "D" ]; run = "cd ~/Documents"; }
        { on = [ "g" "Z" ]; run = "cd ~/Documents/personal/zettelkasten"; }
        { on = [ "g" "B" ]; run = "cd ~/Desktop/batches"; }
        { on = [ "g" "S" ]; run = "cd ~/Desktop/batches/00-SETTLEMENTS"; }
        { on = [ "g" "N" ]; run = "cd ~/nixos-config"; }
        { on = [ "g" "A" ]; run = "cd ~/code/aguila/src"; }
        { on = [ "g" "I" ]; run = "cd ~/code/aguila/src/data/files"; }
        { on = [ "g" "O" ]; run = "cd ~/code/aguila/src/utils/tex/itemize/outputs"; }
        # Util
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
