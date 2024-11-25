{ pkgs, ... }: {
  programs.taskwarrior = {
    enable = true;
    package = pkgs.taskwarrior3;
    dataLocation = "$HOME/.task";
    colorTheme = "bubblegum-256"; # "dark-blue-256";
    extraConfig = ''
      context.topflight.read=project:topflight
      context.topflight.write=project:topflight
      context.collections.read=project:collections
      context.collections.write=project:collections
      context.billing.read=project:billing
      context.billing.write=project:billing
      context.refactor.read=project:refactor
      context.refactor.write=project:refactor

      # Tiny Beelink (melissa=bee in Greek) NixOS machine
      context.melissa.read=project:melissa
      context.melissa.write=project:melissa

      context.me.read=project:me
      context.me.write=project:me
      context.ingenieri.read=project:ingenieri
      context.ingenieri.write=project:ingenieri
    '';
  };
}
