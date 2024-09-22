{ ... }: {

  imports = [
    ./zsh
    ./fish
    ./bat.nix
    ./direnv.nix
    ./starship.nix
    ./yazi.nix
    ./eza.nix
    ./lsd.nix
  ];

  programs.zoxide.enable = true;

}
