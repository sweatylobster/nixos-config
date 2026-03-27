{ pkgs, ... }:
# TODO: For broot.nix and yazi.nix, load a sort of "${DIRS[@]}", as in the tmux-sessionizer script.
# This Nix list or attr set can be defined in `modules/home.nix` and expanded as we please in these other locations.
{
  programs.broot = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      modal = true;
      initial_mode = "input";
      quit_on_last_cancel = false;
      special_paths = {
        "~/.config" = {
          "show" = "always";
        };
        # Paths to ignore.
        "~/Applications" = {
          "show" = "never";
        };
        "~/Library" = {
          "show" = "never";
        };
        "~/go" = {
          "show" = "never";
        };
        "~/nix-darwin" = {
          "show" = "never";
        };
      };
      verbs = [
        # cd to commonly-used directories. Workaround the lack of zoxide.
        {
          invocation = "git_root";
          shortcut = "cdr";
          internal = "focus {git-root}";
        }
        {
          invocation = "go_home";
          shortcut = "cdh";
          key = "ctrl-h";
          internal = ":focus ~";
        }
        {
          invocation = "go_code";
          shortcut = "cdc";
          internal = ":focus ~/code";
        }
        {
          invocation = "go_aguila";
          shortcut = "cda";
          internal = ":focus ~/code/aguila";
        }
        {
          invocation = "go_nixos_config";
          shortcut = "cdn";
          internal = ":focus ~/nixos-config/";
        }
      ];
      preview_transformers = [
        {
          input_extensions = [ "pdf" ];
          output_extension = "png";
          mode = "image";
          command = [
            "${pkgs.mupdf-headless}/bin/mutool"
            "draw"
            "-w"
            "1000"
            "-o"
            "{output-path}"
            "{input-path}"
          ];
        }
      ];
    };
  };
}
