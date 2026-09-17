{ ... }:
{
  programs.swayimg = {
    enable = true;
    initLua = ''
      swayimg.gallery.on_key("h", function() swayimg.gallery.select("left") end)
      swayimg.gallery.on_key("j", function() swayimg.gallery.select("down") end)
      swayimg.gallery.on_key("k", function() swayimg.gallery.select("up") end)
      swayimg.gallery.on_key("l", function() swayimg.gallery.select("right") end)

      local function nudge(dx, dy)
        local pos = swayimg.viewer.get_position()
        swayimg.viewer.set_abs_position(pos.x+dx, pos.y+dy)
      end


      swayimg.viewer.on_key("h", function() nudge(80,   0) end)
      swayimg.viewer.on_key("j", function() nudge(0,  -80) end)
      swayimg.viewer.on_key("k", function() nudge(0,   80) end)
      swayimg.viewer.on_key("l", function() nudge(-80,  0) end)

      swayimg.viewer.on_key("Shift+j", function() swayimg.viewer.open("next") end)
      swayimg.viewer.on_key("Shift+k", function() swayimg.viewer.open("prev") end)

      swayimg.viewer.on_key("Shift+greater", function() swayimg.viewer.open("next_dir") end)
      swayimg.viewer.on_key("Shift+less", function() swayimg.viewer.open("prev_dir") end)
    '';
  };
}
