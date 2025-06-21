{ ... }: {
  # blue light killa
  services.gammastep = {
    enable = true;
    latitude = 34.3;
    longitude = -118.1;
    provider = "manual";
    tray = true;
    temperature = {
      day = 6500;
      night = 1000;
    };
    settings = {
      general = {
        brightness-day = 1.0;
        brightness-night = 0.20;
        fade = 1;
        adjustment-method = "wayland";
      };
    };
  };
}
