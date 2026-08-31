{ ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withPython3 = false;
    withRuby = false;
    vimAlias = true;
    vimdiffAlias = true;
    sideloadInitLua = true;
  };
}
