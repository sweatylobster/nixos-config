{ pkgs, lib, ... }: {

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (_: true);

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  home.packages = with pkgs; with pkgs.nodePackages_latest; [
    # custom packages
    (pkgs.callPackage ../pkgs/bins { })

    age
    bat-extras.batman
    chafa
    comma
    curl
    datamash
    devenv
    entr
    fd
    # geckodriver  # either do in environment.systemPackages, or link to bin
    gnumake
    graphviz # mermaid-killer
    hexyl
    htmlq
    htop
    httpie
    httpstat
    hyperfine
    imagemagick
    jq
    just
    lazygit
    miller
    moreutils
    ncdu
    netcat-gnu
    nh
    nix-direnv
    nmap
    nodejs
    onefetch
    pandoc
    poppler
    python312
    ripgrep
    scc
    starship
    taskwarrior-tui
    texliveFull
    tldr
    ueberzugpp
    unixtools.watch
    unzip
    wget
    yarn

    # treesitter, lsps, formatters, and stuff :)
    basedpyright
    bash-language-server
    cargo
    clang-tools
    nil
    nixpkgs-fmt
    pgformatter
    prettier
    python312Packages.python-lsp-server
    ruff
    rust-analyzer
    rustc
    rustfmt
    shellcheck
    shfmt
    sql-formatter
    stylua
    sumneko-lua-language-server
    tailwindcss-language-server
    taplo
    tree-sitter
    typescript-language-server
    vscode-langservers-extracted
    yaml-language-server
    yamllint
    zig
    zls
  ] ++ (lib.optionals pkgs.stdenv.isLinux [
    gqrx
    hackrf
    vesktop # fix discord streaming
    dune3d # cad
  ]);
}
