{ pkgs, lib, ... }: {

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (_: true);

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  home.packages = with pkgs; with pkgs.nodePackages_latest; [
    bat
    bat-extras.batman
    curl
    devenv
    entr
    eza
    fd
    hackrf
    # geckodriver  # should be linked per project. useful, but prefer curling.
    gh
    gnumake
    gqrx
    hyperfine
    jq
    nerdfonts
    nh
    nix-direnv
    nmap
    nodejs
    python313
    ripgrep
    sioyek
    starship
    texliveFull
    tldr
    unzip
    vesktop
    wget
    yazi
    zathura
    zig
    zoxide

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
    shellfmt
    stylua
    tree-sitter
    zig
    zls
  ];
}
