{ pkgs, lib, ... }: {

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkgs) [ "steam" "steam-original" "steam-unwrapped" "steam-run" ];

  programs.gamemode.enable = true;
}
