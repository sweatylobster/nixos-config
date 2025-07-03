{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {

      # Pick nerd fonts with this :)
      # fc-list | rg 'NerdFonts/.+..f: (\w+ Nerd Font Mono)' -o -r '$1' | sort | uniq | fzf --cycle --reverse

      # favorites:
      # [ DejaVuSansM, FiraMono, Hack, Hasklug, Lilex, MartianMono (size=12), UbuntoMono (size=18),  ]
      font = {
        size = if pkgs.stdenv.isLinux then 12 else 16;
        normal = {
          family = "MartianMono Nerd Font Mono";
          style = "Regular";
        };
        # bold.family = "MartianMono Nerd Font Mono";
        # italic.family = "MartianMono Nerd Font Mono";
        # bold_italic.family = "MartianMono Nerd Font Mono";
      };
      window = {
        decorations = "None";
        blur = false;
        opacity = 0.84;
        option_as_alt = "Both";
      };
    };
  };
}
