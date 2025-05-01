{ ... }: {
  # hyprpaper config for wallpapers; weeb defaults aren't for me
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = "/home/cowmaster/Pictures/moebius-slain.jpg";
      wallpaper = ", /home/cowmaster/Pictures/moebius-slain.jpg";
    };
  };
}
