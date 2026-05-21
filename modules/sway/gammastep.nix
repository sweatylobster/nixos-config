{ ... }:
{
  # blue light killa
  services.gammastep = {
    enable = true;
    latitude = 34.3;
    longitude = -118.1;
    provider = "manual";
    tray = true;
    temperature = {
      day = 6500;
      night = 2200;
    };
    settings = {
      general = {
        brightness-day = 1.0;
        brightness-night = 0.84;
        fade = 1;
        adjustment-method = "wayland";
      };
    };
  };
}
