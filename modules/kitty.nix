{ ... }: {
  # https://home-manager-options.extranix.com/?query=kitty&release=master
  programs.kitty = {
    enable = true;
    environment = { works = "yes"; };
    font = {
      # name = "MartianMono Nerd Font Mono";
      name = "BerkeleyMono";
      size = 14;
    };
    keybindings = { };
    shellIntegration.enableFishIntegration = true;
    settings = {
      enable_audio_bell = false;
      hide_window_decorations = true;
      background_opacity = "0.84";
      macos_option_as_alt = "both";
    };
    themeFile = "tokyo_night_night"; # "Tokyo Night";
  };
}
