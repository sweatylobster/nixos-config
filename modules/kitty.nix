{ config, pkgs, ... }: {
  # https://home-manager-options.extranix.com/?query=kitty&release=master
  programs.kitty = {
    enable = true;
	environment = { works = "yes"; };
	font = {
	  name = "FiraCode";
	  size = 18;
	};
	keybindings = {};
	shellIntegration.enableZshIntegration = true;
	theme = "Tokyo Night"; # "tokyo_night_night";
  };
}
