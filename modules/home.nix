{ ... }: {
  home.username = "cowmaster";
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.nix-index.enable = true;

  home.sessionVariables = {
    LC_ALL = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    PROJECTS = "$HOME/code";
  };

  # Ensure ~/code -- ~/Developer for caarlos0 -- exists.
  # assumed for other activations, especially on darwin.
  home.activation.developer = ''
    mkdir -p ~/code
  '';
}
