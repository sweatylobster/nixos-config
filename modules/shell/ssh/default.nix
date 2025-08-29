{ config, ... }:
{
  programs.ssh = {
    enable = true;
    includes = [ "~/.ssh/config.local" ];
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        serverAliveInterval = 60;
        identityFile = "~/.ssh/id_ed25519";
        setEnv = {
          TERM = "xterm-256color";
        };

        sendEnv = [
          "COLORTERM"
        ];

        extraOptions = {
          IgnoreUnknown = "UseKeychain";
          UseKeychain = "yes";
        };
      };
      "dev" = {
        forwardAgent = true;
        extraOptions = {
          RequestTTY = "true";
          RemoteCommand = "tmux new -A -s default";
        };
      };
      "github.com" = {
        serverAliveInterval = 0;
        extraOptions = {
          ControlMaster = "auto";
          ControlPath = "~/.ssh/github.sock";
          ControlPersist = "5m";
        };
      };
    };
  };

  home.file.".ssh/rc".source = config.lib.file.mkOutOfStoreSymlink ./rc;
}
