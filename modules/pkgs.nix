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
    fd
    # geckodriver  # prefer curl
    gnumake
    httpie
    hyperfine
    imagemagick
    just
    jq
    lazygit
    nh
    nix-direnv
    nmap
    nodejs
    poppler
    python313
    ripgrep
    starship
    taskwarrior-tui
    texliveFull
    tldr
    unzip
    wget
    zig

    # treesitter, lsps, formatters, and stuff :)
    basedpyright
    bash-language-server
    cargo
    nil
    nixpkgs-fmt
    prettier
    ruff
    rust-analyzer
    shellcheck
    shfmt
    stylua
    tree-sitter
    zig
    zls
  ] ++ (lib.optionals pkgs.stdenv.isLinux [
    gqrx
    hackrf
    vesktop # fix discord streaming
    dune3d # cad
  ]);
}
