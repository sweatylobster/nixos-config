{ pkgs, config, ... }: {

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    history = {};

    shellAliases = {

      # indecisive
      e = "nvim";
      n = "nvim";
      v = "nvim";

      lg = "lazygit";

      ls = "eza";
      ll = "eza --long --header --git --icons=always --all";
      tree = "eza --tree";

      texclean = "fd -e log -e aux -x rm {}";

      t = "tmux";
    };

    zplug = {
      enable = true;
      plugins = [
        { name = "jeffreytse/zsh-vi-mode"; }
        { name = "junegunn/fzf-git.sh"; }
      ];
    };

    initExtra = builtins.readFile ./config.zsh;

  };
}
