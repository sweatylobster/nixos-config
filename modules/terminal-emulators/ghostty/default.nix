{ ... }: {
  xdg.configFile."ghostty/config" = {
    source = ./ghostty.conf;
  };
}
