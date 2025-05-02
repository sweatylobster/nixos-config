{ ... }: {
  programs.lsd = {
    enable = true;
    settings = {
      layout = "oneline";
      sorting = {
        dir-grouping = "first";
      };
    };
  };
}
