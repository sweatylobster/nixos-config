{ config, pkgs, ... }: {
  programs.gh = {
    enable = true;

    settings = {
      version = 1;
      aliases = {
        clone = "repo clone";
      };
      editor = "nvim";
      git_protocol = "ssh";
    };
  };
}
