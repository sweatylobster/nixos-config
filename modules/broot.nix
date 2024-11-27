{ pkgs, ... }: {
  programs.broot = {
    enable = false;
    enableFishIntegration = true;
    settings = {
      modal = true;
    };
  };
}
