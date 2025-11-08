{ pkgs, lib, ... }:
{

  # NOTE: Removing allow unfree packages due to evaluation warning:
  # ```evaluation warning: <name> profile: You have set either `nixpkgs.config` \
  #     or `nixpkgs.overlays` while using `home-manager.useGlobalPkgs`.```
  # nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowUnfreePredicate = (_: true);

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  home.packages =
    with pkgs;
    with pkgs.nodePackages_latest;
    [
      # custom packages
      (pkgs.callPackage ../../pkgs/bins { })

      age
      chafa
      comma
      curl
      datamash
      devenv
      entr
      fd
      ffmpeg
      gnumake
      gum
      # graphviz # mermaid-killer
      hexyl
      htmlq
      hyperfine
      imagemagick
      jq
      just
      moreutils
      mpv
      mupdf
      ncdu
      netcat-gnu
      # nh
      nmap
      ocrmypdf
      # pandoc
      poppler-utils
      pstree
      ripgrep
      scc
      taskwarrior-tui
      timewarrior
      tldr
      typst
      ueberzugpp
      unpaper
      unixtools.watch
      unzip
      wget
      xidel

      # treesitter, lsps, formatters, and stuff :)
      bash-language-server
      cargo
      clang-tools
      ghc
      go
      gopls
      haskell-language-server
      jq-lsp
      nil
      nixfmt-rfc-style
      pgformatter
      prettier
      pyright
      python312Packages.python-lsp-server
      ruff
      rust-analyzer
      rustc
      rustfmt
      shellcheck
      shfmt
      sql-formatter
      stylua
      lua-language-server
      tinymist
      tree-sitter
      websocat # for typst-preview.nvim
      yamllint
      zig
      zls
    ]
    ++ (lib.optionals pkgs.stdenv.isLinux [
      discord
      dune3d # cad
      gqrx
      hackrf
      prismlauncher
    ]);
}
