{ pkgs, lib, ... }: {

  # NOTE: Removing allow unfree packages due to evaluation warning:
  # ```evaluation warning: <name> profile: You have set either `nixpkgs.config` \
  #     or `nixpkgs.overlays` while using `home-manager.useGlobalPkgs`.```
  # nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowUnfreePredicate = (_: true);

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  home.packages = with pkgs; with pkgs.nodePackages_latest; [
    # custom packages
    (pkgs.callPackage ../pkgs/bins { })

    age
    binwalk
    chafa
    comma
    curl
    datamash
    devenv
    entr
    fd
    gnumake
    # graphviz # mermaid-killer
    hexyl
    htmlq
    httpie
    # httpstat
    hyperfine
    imagemagick
    jq
    just
    lazygit
    # miller
    moreutils
    ncdu
    netcat-gnu
    # nh
    nix-direnv
    nmap
    nodejs
    onefetch
    # pandoc
    poppler-utils
    pstree
    # python312
    ripgrep
    scc
    slides
    starship
    taskwarrior-tui
    texliveFull
    timewarrior
    tldr
    typst
    ueberzugpp
    unixtools.watch
    unzip
    wget
    # yarn

    # treesitter, lsps, formatters, and stuff :)
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
    tinymist
    websocat # for typst-preview.nvim
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
