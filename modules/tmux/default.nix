{ pkgs, ... }: {
  # Install tmux with some plugins.
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    clock24 = true;
    plugins = with pkgs.tmuxPlugins; [
      # better-mouse-mode
      # copy-toolkit
      extrakto
      catppuccin
      tmux-thumbs
      sensible
    ];
    extraConfig = builtins.readFile ./tmux.conf;
  };
}
