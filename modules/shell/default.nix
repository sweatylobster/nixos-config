{ ... }: {

  imports = [
    ./bat.nix
    ./broot.nix
    ./direnv.nix
    ./fish
    ./fzf.nix
    ./gh.nix
    ./git
    ./lsd.nix
    ./pkgs.nix
    ./ssh
    ./starship.nix
    ./taskwarrior.nix
    ./tmux
    ./top
    ./yazi.nix
  ];

  programs.zoxide.enable = true;

}
