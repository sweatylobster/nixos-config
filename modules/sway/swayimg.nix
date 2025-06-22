{ ... }: {
  programs.swayimg = {
    enable = true;
    settings = {
      "keys.gallery" = {
        "Shift+asciicircum" = "first_file";
        "Shift+dollar" = "last_file";
        "h" = "step_left";
        "j" = "step_down";
        "k" = "step_up";
        "l" = "step_right";
        "Shift+J" = "page_down";
        "Shift+K" = "page_up";
      };
      "keys.viewer" = {
        # Zoom out and in
        "Ctrl+o" = "zoom -10";
        "Ctrl+i" = "zoom +10";
        # Vi-movements
        "h" = "step_left 10";
        "j" = "step_down 10";
        "k" = "step_up 10";
        "l" = "step_right 10";
        # For convenience when zooming (don't have to release ctrl)
        "Ctrl+h" = "step_left 10";
        "Ctrl+j" = "step_down 10";
        "Ctrl+k" = "step_up 10";
        "Ctrl+l" = "step_right 10";
        # Paging
        "Shift+J" = "next_file";
        "Shift+K" = "prev_file";
        # Complement default config
        "Shift+space" = "prev_file";
      };
    };
  };
}
