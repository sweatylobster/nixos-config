{ pkgs, pkgs-stable, ... }: {
  # https://home-manager-options.extranix.com/?query=kitty&release=master
  programs.kitty = {
    enable = true;
    # package = pkgs-stable.kitty;
    environment = { works = "yes"; };
    font = {
      # name = "MartianMono Nerd Font Mono";
      name = "BerkeleyMono";
      size = if pkgs.stdenv.isLinux then 12 else 14;
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
