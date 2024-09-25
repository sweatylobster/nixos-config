{ pkgs, ... }: {
  # https://home-manager-options.extranix.com/?query=kitty&release=master
  programs.kitty = {
    enable = true;
    environment = { works = "yes"; };
    font = {
      name = "MartianMono Nerd Font Mono";
      size = if pkgs.stdenv.isLinux then 12 else 16;
    };
    keybindings = { };
    shellIntegration.enableZshIntegration = true;
    settings = {
      enable_audio_bell = false;
      hide_window_decorations = true;
      background_opacity = "0.84";
      macos_option_as_alt = "left";
    };
    themeFile = "tokyo_night_night"; # "Tokyo Night";
  };
}
