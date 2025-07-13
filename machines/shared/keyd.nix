{ ... }:
{
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "esc";
          };
          control = {
            "1" = "setlayout(main)";
            "2" = "setlayout(colemak-dh)";
          };
          "colemak-dh:layout" = {
            a = "a";
            b = "z";
            c = "d";
            d = "s";
            e = "f";
            f = "t";
            g = "g";
            h = "m";
            i = "u";
            j = "n";
            k = "e";
            l = "i";
            m = "h";
            n = "k";
            o = "y";
            p = ";";
            q = "q";
            r = "p";
            s = "r";
            t = "b";
            u = "l";
            v = "v";
            w = "w";
            x = "c";
            y = "j";
            z = "x";
            ";" = "o";
          };
        };
      };
    };
  };
}
