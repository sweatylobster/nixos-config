{ config, pkgs, ... }: {
  # https://home-manager-options.extranix.com/?query=kitty&release=master
  programs.kitty = {
    enable = true;
	environment = { works = "yes"; };
	font = {
	  name = "MartianMono Nerd Font Mono";
	  size = 12;
	};
	keybindings = {};
	shellIntegration.enableZshIntegration = true;
	settings = {
	  enable_audio_bell = false;
	  hide_window_decorations = true;
	  background_opacity = "0.84";
	};
	theme = "Tokyo Night"; # "tokyo_night_night";
  };
}
