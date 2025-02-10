{ pkgs, ... }: {
  programs.taskwarrior = {
    enable = true;
    package = pkgs.taskwarrior3;
    dataLocation = "$HOME/.task";
    colorTheme = "bubblegum-256"; # "dark-blue-256";
    extraConfig = ''
      context.topflight.read=project:topflight or project:aguila or +collections or +billing or +accounting or +aguila or +conexem or +medisoft
      context.topflight.write=project:topflight
      context.medisoft.read=project:medisoft or +medisoft
      context.medisoft.write=project:medisoft
      context.personal.read=project:personal
      context.personal.write=project:personal
    '';
  };
}
