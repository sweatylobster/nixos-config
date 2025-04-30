{ ... }: {
  programs.broot = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      modal = true;
      initial_mode = "input";
      quit_on_last_cancel = false;
      # default_flags = "-gh";
      special_paths = {
        "~/.config" = { "show" = "always"; };
        "~/Library" = { "show" = "never"; };
        "~/go" = { "show" = "never"; };
        "~/Applications" = { "show" = "never"; };
      };
      verbs = [
        { invocation = "git-root"; shortcut = "gr"; internal = "focus {git-root}"; }
        { invocation = "home"; key = "ctrl-h"; internal = ":focus ~"; }
        { invocation = "code"; internal = ":focus ~/code"; }
      ];
    };
  };
}
