{ pkgs, config, ... }: {

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    # histSize = 10000;
    shellAliases = {
      e = "nvim";
      n = "nvim";
      v = "nvim";
    };
  };
}
