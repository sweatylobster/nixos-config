{ ... }: {
  imports = [
    ../shared/darwin.nix
  ];

  services.tailscale.enable = true;
}
