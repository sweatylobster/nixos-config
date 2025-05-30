{ pkgs, lib, ... }: {
  programs.fish = {
    enable = true;
    shellInit = ''
      if test -f ~/.localrc.fish
        source ~/.localrc.fish
      end
      # fish ignores these on Linux
      fish_add_path -a /Applications/Ghostty.app/Contents/MacOS/
      fish_add_path -a /opt/homebrew/bin/
    '';
    interactiveShellInit = ''
      set fish_greeting
      fish_config theme choose tokyonight
      fish_add_path -p ~/.nix-profile/bin /nix/var/nix/profiles/default/bin
    '';
    functions = {
      cdr = {
        description = "cd into root folder of current repo";
        body = "cd (git rev-parse --show-toplevel)";
      };
      a = {
        description = "cd into aguila";
        body = "test -d ~/code/aguila && builtin cd ~/code/aguila";
      };
    };
    plugins = [
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair-fish.src;
      }
    ];
    shellAliases = {

      # git
      g = "git";
      gl = "git pull --prune";
      glg = "git log --graph --decorate --one-line --abbrev-commit";
      glga = "glg --all";
      gp = "git push origin HEAD";
      gpa = "git push origin --all";
      gd = "git diff";
      gc = "git commit -s";
      gca = "git commit -sa";
      gco = "git checkout";
      gb = "git branch -v";
      ga = "git add";
      gaa = "git add -A";
      gcm = "git commit -sm";
      gcam = "git commit -sam";
      gs = "git status -sb";
      glnext = "git log --oneline (git describe --tags --abbrev=0 @&)..@";
      gw = "git switch";
      gm = "git switch (git main-branch)";
      gms = "git switch (git main-branch); and git sync";
      egms = "e; git switch (git main-branch); and git sync";
      gwc = "git switch -c";

      maxvim = "NVIM_APPNAME=maxvim nvim";
      mvim = "NVIM_APPNAME=maxvim nvim";
      msf = "mvim +'Telescope find_files'";
      msg = "mvim +'Telescope live_grep'";
      mgf = "mvim +'Telescope git_files'";

      n = "nvim";
      # Might have to rethink using these all the time.
      nsf = "nvim +'Telescope find_files'";
      nsg = "nvim +'Telescope live_grep'";
      ngf = "nvim +'Telescope git_files'";

      lg = "lazygit";

      texclean = "fd -I -e aux -e log -e fls -e fdb_latexmk -e synctex.gz -x rm {}";

      t = "tmux";
      tat = "tmux new -A -s default";

      tt = "taskwarrior-tui";
      tc = "task context";
      tm = "task modify";

      icat = "kitten icat";
    };
  };

  xdg.configFile."fish/themes/tokyonight.theme" = {
    source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/fish_themes/tokyonight_night.theme";
      sha256 = "sha256-yabv/At93pvL3Kp/H4XGn8YHd5zfsNsOlktj5iUx3AM=";
    };
  };
}
