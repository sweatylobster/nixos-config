{ pkgs, lib, ... }: {

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (_: true);

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  home.packages = with pkgs; with pkgs.nodePackages_latest; [
    # custom packages
    (pkgs.callPackage ../pkgs/bins { })

    bat
    bat-extras.batman
    curl
    devenv
    entr
    eza
    fd
    hackrf
    # geckodriver  # prefer curl
    gnumake
    gqrx
    httpie
    hyperfine
    imagemagick
    jq
    lazygit
    nerdfonts
    nh
    nix-direnv
    nmap
    nodejs
    poppler
    python313
    ripgrep
    starship
    steam
    texliveFull
    tldr
    unzip
    vesktop
    wget
    xclip
    yazi
    zathura
    zig

    # treesitter, lsps, formatters, and stuff :)
    bash-language-server
    black
    cargo
    nil
    nixpkgs-fmt
    # prettier
    ruff
    rust-analyzer
    shellcheck
    shfmt
    stylua
    tree-sitter
    zig
    zls
  ];
}
