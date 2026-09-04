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
    [
      # custom packages
      (pkgs.callPackage ../../pkgs/bins { })

      age
      chafa
      comma
      curl
      datamash
      entr
      fd
      ffmpeg
      ghostscript
      gnumake
      gum
      hexyl
      htmlq
      hyperfine
      imagemagick
      jq
      just
      moreutils
      mpv
      mupdf
      # ncdu
      # netcat-gnu
      nmap
      # ocrmypdf
      odin
      # pandoc
      poppler-utils
      # pstree
      ripgrep
      taskwarrior-tui
      timewarrior
      tldr
      typst
      ueberzugpp
      unixtools.watch
      unzip
      uv
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
      nixfmt
      ols
      prettier
      python312Packages.python-lsp-server
      ruff
      rust-analyzer
      rustc
      rustfmt
      shellcheck
      shfmt
      stylua
      lua-language-server
      tinymist
      tree-sitter
      ty
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
