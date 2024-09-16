{ ... }: {
  programs.yazi = {
    enable = true;
    # settings = {
    #   yazi = "";   # TOML value
    #   theme = "";  # TOML value
    #   keymap = ''
    #   '';          # TOML value
    # };
    # plugins = { # attribute set of (path or package)
    #   foo = ./foo;
    #   bar = pkgs.bar
    # };
    # flavor = {  # attribute set of (path or package)
    #   myflavor = ./myflavor;
    # };
    # initLua = ./init.lua # null or path, default's null
  };
}
