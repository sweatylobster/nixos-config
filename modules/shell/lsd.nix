{ ... }: {
  programs.lsd = {
    enable = true;
    enableAliases = true;
    settings = {
      layout = "oneline";
      sorting = {
        dir-grouping = "first";
      };
    };
  };
}
