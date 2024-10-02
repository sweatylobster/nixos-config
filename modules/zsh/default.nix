{ pkgs, ... }: {

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    history.size = 10000;
    history.save = 10000;
    history.expireDuplicatesFirst = true;
    history.ignoreDups = true;
    history.ignoreSpace = true; # leading space in commands

    shellAliases = {

      maxvim = "NVIM_APPNAME=maxvim nvim";

      n = "nvim";
      # Might have to rethink using these all the time.
      nsf = "nvim +'Telescope find_files'";
      nsg = "nvim +'Telescope live_grep'";
      ngf = "nvim +'Telescope git_files'";

      lg = "lazygit";

      texclean = "fd -I -e aux -e log -e fls -e fdb_latexmk -e synctex.gz -x rm {}";

      t = "tmux";
      tt = "taskwarrior-tui";
    };

    plugins = [
      {
        name = "fzf-git";
        file = "fzf-git.sh";
        src = "${pkgs.fzf-git-sh}/share/fzf-git-sh";
      }
      {
        name = "zsh-vi-mode";
        file = "zsh-vi-mode.plugin.zsh";
        src = "${pkgs.zsh-vi-mode}/share/zsh-vi-mode";
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = "${pkgs.zsh-nix-shell}/share/zsh-nix-shell";
      }
      # NOTE: Trying to determine the path and compress this plugin.
      # {
      #   name = "zsh-nix-shell";
      #   file = "nix-shell.plugin.zsh";
      #   src = pkgs.fetchFromGitHub
      #     {
      #       owner = "chisui";
      #       repo = "zsh-nix-shell";
      #       rev = "v0.5.0";
      #       sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
      #     };
      # }
    ];

    initExtra = ''

      # better-vi-mode creates so many problems
      function zvm_after_init() {
        for mode in viins vicmd visual; do
          for o in files branches tags remotes hashes stashes lreflogs each_ref; do
            eval "zvm_bindkey ''${mode} '^g^''${o[1]}' fzf-git-$o-widget"
            eval "zvm_bindkey ''${mode} '^g''${o[1]}' fzf-git-$o-widget"
          done
        done
        eval "source <(fzf --zsh)"
        # NOTE: Starship config disables literally everything. What output should I expect to see?
        # eval "source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh"
      }

    '' + builtins.readFile ./config.zsh;


  };
}
