{ ... }: {
  programs.sioyek = {
    enable = true;
    config = {

      # Start with catppuccin colors.
      startup_commands = "toggle_custom_color";

      # The catppuccin colors in question.
      custom_background_color = "0.1019 0.1058 0.1490";
      custom_text_color = "0.7529 0.7921 0.9607";

      # v2.0.0; indexes quickly can use >=50MB of memory.
      super_fast_search = "1";

    };
    bindings = {
      move_down = "j";
      move_up = "k";

      # Scrolling.
      screen_down = "<C-d>";
      screen_up = "<C-u>";

      # Page flipping.
      next_page = "J";
      previous_page = "K";

      # NOTE: Useful for large documents.
      # next_page '
      # previous_page ;

      # Classic `zathura` keybinding to invert color scheme.
      toggle_custom_color = "<C-r>";

      fit_to_page_height_smart = "<C-=>";
    };
  };
}
