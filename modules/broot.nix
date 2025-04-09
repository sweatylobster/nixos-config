{ ... }: {
  programs.broot = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      modal = false;
    };
  };
}
