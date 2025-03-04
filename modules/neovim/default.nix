{ config, pkgs, lib, ... }:
let
  fromGitHub = owner: repo: ref: hash:
    pkgs.vimUtils.buildVimPlugin {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = pkgs.fetchFromGitHub {
        owner = owner;
        repo = repo;
        rev = ref;
        sha256 = hash;
      };
    };

in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      # ui
      tokyonight-nvim
      nvim-web-devicons
      nvim-notify
      lualine-nvim
      dressing-nvim

      # basics
      indent-blankline-nvim
      gitsigns-nvim
      todo-comments-nvim
      harpoon2
      vim-fugitive
      vim-rhubarb
      vim-abolish
      vim-repeat
      vim-rsi
      vim-eunuch
      vim-sleuth
      vim-speeddating
      telescope-nvim
      telescope-github-nvim
      telescope-zoxide
      auto-hlsearch-nvim
      vim-tmux-navigator
      cloak-nvim

      # personal basics
      oil-nvim
      flash-nvim
      vim-easy-align
      vimtex
      markdown-preview-nvim

      # questionable
      firenvim

      # coding
      nvim-lspconfig
      conform-nvim
      blink-cmp
      nvim-cmp
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp-calc
      cmp-treesitter
      nvim-autopairs
      nvim-ts-autotag
      cmp-nvim-lsp
      cmp-nvim-lsp-signature-help
      luasnip
      cmp_luasnip
      friendly-snippets
      neodev-nvim
      neogen
      nvim-surround
      treesj
      quickmath-nvim
      render-markdown-nvim
      yazi-nvim
      nvim-lsp-file-operations
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins:
        with plugins; [
          awk
          bash
          cpp
          css
          csv
          diff
          fish
          git_config
          git_rebase
          gitattributes
          gitcommit
          gitignore
          html
          http
          ini
          javascript
          just
          json
          jq
          lua
          make
          markdown
          markdown_inline
          nix
          python
          query
          regex
          rust
          scss
          sql
          ssh_config
          terraform
          tsx
          toml
          typescript
          vhs
          vim
          vimdoc
          yaml
          zig
        ]))
      nvim-treesitter-textobjects
      nvim-treesitter-context
      nvim-treesitter-endwise
      other-nvim
      hmts-nvim # treesitter injections for home-manager
      nvim-spectre

      # sql
      vim-dadbod
      vim-dadbod-ui
      vim-dadbod-completion
    ];
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink ./config;
  };
}

