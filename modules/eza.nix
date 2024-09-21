{ ... }: {
  programs.eza = {
    enable = false;
    icons = true;
    git = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    extraOptions = [
      "--group-directories-first"
    ];
  };
}
