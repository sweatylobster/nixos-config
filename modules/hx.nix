{ pkgs, ... }: {
  programs.helix = {
    enable = true;
    languages = {
      language = [
        {
          name = "rust";
          auto-format = true;
        }
      ];
    };
  };
}
