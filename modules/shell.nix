{ ... }: {

  imports = [
    ./bat.nix
    ./broot.nix
    ./direnv.nix
    ./fish
    ./lsd.nix
    ./starship.nix
    ./yazi.nix
  ];

  programs.zoxide.enable = true;

}
