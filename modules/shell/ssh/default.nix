{ config, ... }:
{
  programs.ssh = {
    enable = true;
    includes = [ "~/.ssh/config.local" ];
    enableDefaultConfig = true;
    # settings = {
    #   "*" = {
    #     serverAliveInterval = 60;
    #     identityFile = "~/.ssh/id_ed25519";
    #     setEnv = {
    #       TERM = "xterm-256color";
    #     };
    #
    #     sendEnv = [
    #       "COLORTERM"
    #     ];
    #
    #     IgnoreUnknown = "UseKeychain";
    #     UseKeychain = "yes";
    #   };
    #   "dev" = {
    #     forwardAgent = true;
    #     RequestTTY = "true";
    #     RemoteCommand = "tmux new -A -s default";
    #   };
    #   "github.com" = {
    #     serverAliveInterval = 0;
    #     ControlMaster = "auto";
    #     ControlPath = "~/.ssh/github.sock";
    #     ControlPersist = "5m";
    #   };
    # };
  };

  home.file.".ssh/rc".source = config.lib.file.mkOutOfStoreSymlink ./rc;
}
