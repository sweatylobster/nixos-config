{...}: {
  home.username = "cowmaster";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
  programs.nix-index.enable = true;
}


# home-manager.users.cowmaster = { pkgs, ... }: {
#   home.packages = with pkgs; [
#     httpie 
#     yazi 
#   ];
#
#   programs = {
#     # Use zsh :)
#     zsh = {
#       enable = true;
#       enableCompletion = true;
#       syntaxHighlighting = {
#         enable = true;
#       };
#     };
#     # Use starship!
#     starship.enable = true;
#   };
#
#   home.stateVersion = "24.05";
# };

