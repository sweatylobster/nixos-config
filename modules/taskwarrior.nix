{ pkgs, ... }: {
  programs.taskwarrior = {
    enable = true;
    package = pkgs.taskwarrior3;
    extraConfig = ''
      context.tf.read=project:tf
      context.tf.write=project:tf
      context.tfa.read=project:tfa
      context.tfa.write=project:tfa
      context.tfb.read=project:tfb
      context.tfb.write=project:tfb
      context.tfc.read=project:tfc
      context.tfc.write=project:tfc
      context.calls.read=project:calls
      context.calls.write=project:calls
      context.refactor.read=project:refactor
      context.refactor.write=project:refactor

      context.melissa.read=project:melissa
      context.melissa.write=project:melissa

      context.me.read=project:me
      context.me.write=project:me
      context.ingenieri.read=project:ingenieri
      context.ingenieri.write=project:ingenieri
    '';
  };
}
