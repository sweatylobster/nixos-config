{ pkgs, config, ... }: {

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

      texclean = "fd -I -e aux -e log -e fls -e synctex.gz -x rm {}";

      t = "tmux";
      tt = "taskwarrior-tui";
    };

    plugins = [
      {
        name = "fzf-git";
        file = "fzf-git.sh";
        src = pkgs.fetchFromGitHub {
          owner = "junegunn";
          repo = "fzf-git.sh";
          rev = "6a5d4a923b86908abd9545c8646ae5dd44dff607";
          sha256 = "sha256-Hn28aoXBKE63hNbKfIKdXqhjVf8meBdoE2no5iv0fBQ=";
        };
      }
      {
        name = "vi-mode";
        src = "${pkgs.zsh-vi-mode}/share/zsh-vi-mode";
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub
          {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.5.0";
            sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
          };
      }
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
        eval "source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode"
      }

    '' + builtins.readFile ./config.zsh;


  };
}
