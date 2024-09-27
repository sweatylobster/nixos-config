{ ... }: {
  programs.zathura = {
    enable = true;
    mappings = {
      D = ''set "first-page-column 1:1"'';
      "<C-f>" = "toggle_fullscreen";
      # "<C-d>" = "first-page-column 2:1";
    };
    options = {
      database = "sqlite";

      first-page-column = "1:1";

      # catppuccin colors
      default-fg = "#CDD6F4";
      default-bg = "#1E1E2E";

      completion-bg = "#313244";
      completion-fg = "#CDD6F4";
      completion-highlight-bg = "#575268";
      completion-highlight-fg = "#CDD6F4";
      completion-group-bg = "#313244";
      completion-group-fg = "#89B4FA";

      statusbar-fg = "#CDD6F4";
      statusbar-bg = "#313244";

      notification-bg = "#313244";
      notification-fg = "#CDD6F4";
      notification-error-bg = "#313244";
      notification-error-fg = "#F38BA8";
      notification-warning-bg = "#313244";
      notification-warning-fg = "#FAE3B0";

      inputbar-fg = "#CDD6F4";
      inputbar-bg = "#313244";

      recolor-lightcolor = "#1E1E2E";
      recolor-darkcolor = "#CDD6F4";

      index-fg = "#CDD6F4";
      index-bg = "#1E1E2E";
      index-active-fg = "#CDD6F4";
      index-active-bg = "#313244";

      render-loading-bg = "#1E1E2E";
      render-loading-fg = "#CDD6F4";

      highlight-color = "#575268";
      highlight-fg = "#F5C2E7";
      highlight-active-color = "#F5C2E7";
    };
  };
}
