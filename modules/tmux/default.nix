{ pkgs, ... }: {
  # Install tmux with some plugins.
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    clock24 = true;
    plugins = with pkgs.tmuxPlugins; [
      tmux-thumbs
      sensible
      yank
    ];
    extraConfig = builtins.readFile ./tmux.conf;
  };

  programs.fish.interactiveShellInit = ''
    # traps the shell quit and switch to the last session if it's the last pane
    # if last session is not available anymore, switch to default
    function __trap_exit_tmux
        test (tmux list-windows | count) = 1 || exit
        test (tmux list-panes | count) = 1 || exit
        tmux switch-client -l || tmux switch-client -t default
    end

    if set -q TMUX
        trap __trap_exit_tmux EXIT
    end
  '';
}
