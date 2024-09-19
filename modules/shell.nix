{ ... }: {

  imports = [
    ./zsh
    ./fish
    ./bat.nix
    ./direnv.nix
    ./starship.nix
    ./yazi.nix
  ];

  programs.zoxide.enable = true;

}
