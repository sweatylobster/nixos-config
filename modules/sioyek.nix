{ pkgs, pkgs-stable, ... }: {
  programs.sioyek = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then pkgs-stable.sioyek else pkgs.sioyek;
    config = {

      # using the nifty plugin suggestion
      # do a python with just the sioyek stuff
      # new_command _dual_panelify /opt/homebrew/anaconda3/bin/python -m sioyek.dual_panelify "%{sioyek_path}" "%{file_path}" "%{command_text}"

      # start with custom color
      startup_commands = "toggle_custom_color";

      # taken from a nice redditor on r/unixporn
      custom_background_color = "0.1019 0.1058 0.1490";
      custom_text_color = "0.7529 0.7921 0.9607";

    };
    bindings = {
      # move_left l  # overview definition
      move_down = "j";
      move_up = "k";
      # move_right h  # highlight

      # scrolling
      screen_down = "<C-d>";
      screen_up = "<C-u>";

      # page flipping
      next_page = "J";
      previous_page = "K";

      # NOTE: Can be useful
      # next_page '
      # previous_page ;
      # next_page l
      # previous_page h

      # good ol' dual panel pdf
      _dual_panelify = "<S-d>";

      # and the zathura keybinding to invert color scheme
      toggle_custom_color = "<C-r>";
    };
  };
}
