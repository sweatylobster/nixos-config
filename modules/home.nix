{ ... }:
let projects = "$HOME/code"; in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.nix-index.enable = true;

  home.stateVersion = "24.05";

  home.sessionVariables = {
    LC_ALL = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    PROJECTS = projects;
  };

  # caarlos0 uses $PROJECTS for other activations, especially on Darwin, but I don't need it.
  # Leaving as a reminder that activations are a thing.
  home.activation.developer = ''
    mkdir -p ${projects}
  '';
}
