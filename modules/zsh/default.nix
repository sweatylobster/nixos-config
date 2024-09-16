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

      # who needs ls, anyway?
      ls = "eza";
      ll = "eza --long --header --git --icons=always --all";
      tree = "eza --tree";

      texclean = "fd -e log -e aux -x rm {}";

      t = "tmux";
    };

    # initExtra = builtins.readFile ./config.zsh;
    initExtra = ''
      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          cd -- "$cwd"
        fi
        rm -f -- "$tmp"
      }
    '';
  };
}
