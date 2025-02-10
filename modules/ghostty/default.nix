{ config, ... }: {
  xdg.configFile."ghostty/config" = {
    src = config.lib.file.mkOutOfStoreSymlink ./config;
  };
}
