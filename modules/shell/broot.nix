{ ... }: {
  programs.broot = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      modal = false;
      verbs = [
        # these don't conflict with vim-tmux-navigator :)
        { key = "alt-j"; internal = "line_down"; }
        { key = "alt-k"; internal = "line_up"; }
        # nifty
        { invocation = "git-root"; shortcut = "gr"; internal = "focus {git-root}"; }
      ];
    };
  };
}
