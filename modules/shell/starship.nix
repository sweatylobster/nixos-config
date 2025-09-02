{ ... }:
{
  programs.starship = {
    enable = true;
    enableTransience = true;
    settings = {
      cmd_duration = {
        min_time = 500;
        format = "[$duration]($style) ";
      };
      git_branch.symbol = " ";
      git_status.format = "[$ahead_behind$untracked$modified]($style) ";
      directory = {
        read_only = " ";
        truncate_to_repo = false;
      };
      username.format = "[$user]($style)";
      hostname = {
        ssh_symbol = "@";
        format = "$ssh_symbol[$hostname](bright-blue) ";
      };
    };
  };
}
