{ pkgs, ... }:
# let
#   homeDirectory = (if pkgs.stdenv.isDarwin then "/Users/" else "/home/")
#     + "max"  # but wouldn't work if this is cowmaster :/
# in
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      global = { load_dotenv = true; };
    };
  };
}
