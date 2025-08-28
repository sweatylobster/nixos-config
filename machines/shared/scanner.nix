{ pkgs, ... }:
{

  # https://nixos.wiki/wiki/Scanners

  # Enable the "Scanner Access Now Easy" backend.
  hardware.sane = {
    enable = true;
    disabledDefaultBackends = [ "escl" ];
    brscan5 = {
      enable = true;
      netDevices = {
        home = {
          model = "ADS-4700W";
          ip = "10.124.1.23";
        };
      };
    };
    # brscan4.enable = true;
  };

  # Pick up scanner connected via USB.
  services.ipp-usb.enable = true;

  # NOTE: Might be necessary.
  services.udev.packages = [ pkgs.sane-airscan ];

}
