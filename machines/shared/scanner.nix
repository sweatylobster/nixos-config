{ pkgs, ... }: {

  # https://nixos.wiki/wiki/Scanners

  # Enable the "Scanner Access Now Easy" backend.
  hardware.sane = {
    enable = true;
    brscan5.enable = true;
  };

  # Pick up scanner connected via USB.
  services.ipp-usb.enable = true;

  # NOTE: Might be necessary.
  # services.udev.packages = [ pkgs.sane-airscan ];

}
