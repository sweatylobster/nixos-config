{ pkgs, ... }: {
  programs.broot = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      modal = true;
      initial_mode = "input";
      quit_on_last_cancel = false;
      special_paths = {
        "~/.config" = { "show" = "always"; };
        # Paths to ignore.
        "~/Applications" = { "show" = "never"; };
        "~/Library" = { "show" = "never"; };
        "~/go" = { "show" = "never"; };
        "~/nix-darwin" = { "show" = "never"; };
      };
      verbs = [
        # cd to commonly-used directories. Workaround the lack of zoxide.
        { invocation = "git-root"; shortcut = "cdr"; internal = "focus {git-root}"; }
        { invocation = "go-home"; shortcut = "cdh"; key = "ctrl-h"; internal = ":focus ~"; }
        { invocation = "go-code"; shortcut = "cdc"; internal = ":focus ~/code"; }
        { invocation = "go-aguila"; shortcut = "cda"; internal = ":focus ~/code/aguila"; }
        { invocation = "go-nixos-config"; shortcut = "cdn"; internal = ":focus ~/nixos-config/"; }
      ];
      preview_transformers = [
        {
          input_extensions = [ "pdf" ];
          output_extension = "png";
          mode = "image";
          command = [ "${pkgs.mupdf-headless}/bin/mutool" "draw" "-w" "1000" "-o" "{output-path}" "{input-path}" ];
        }
      ];
    };
  };
}
