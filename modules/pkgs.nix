{ pkgs, lib, ... }: {

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (_: true);

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  home.packages = with pkgs; with pkgs.nodePackages_latest; with pkgs.python312Packages; [
    # custom packages
    (pkgs.callPackage ../pkgs/bins { })

    age
    bat-extras.batman
    comma
    curl
    devenv
    entr
    fd
    gnumake
    graphviz # mermaid-killer
    # geckodriver  # either do in environment.systemPackages, or link to bin
    htmlq
    httpie
    httpstat
    hyperfine
    imagemagick
    jq
    just
    lazygit
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
    python-lsp-server
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
