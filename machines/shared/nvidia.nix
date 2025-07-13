{ config, ... }:
{

  nixpkgs.config.nvidia.acceptLicense = true;

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # FIXME: Unsure if necessary.
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };

}
