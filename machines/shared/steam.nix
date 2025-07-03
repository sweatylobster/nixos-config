{ pkgs, lib, ... }:
{

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;
  };

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkgs) [
      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
    ];
  # https://github.com/ValveSoftware/gamescope/issues/1178
  # Use with `gamescope [OPTS] -e --backend sdl -- %command%`
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.gamemode.enable = true;
}
