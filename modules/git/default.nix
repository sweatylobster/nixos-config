{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    delta.enable = true;
    userName = "Max de Hoyos";
    userEmail = "max.dehoyos@gmail.com";
  };
}
