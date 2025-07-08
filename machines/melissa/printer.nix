{ pkgs, ... }:
{

  services.printing.drivers = [
    pkgs.brlaser
  ];

  hardware.printers = {
    ensurePrinters = [
      {
        name = "Brother_HL_L2460DW";
        location = "Island over Ethernet via nixos";
        deviceUri = "dnssd://Brother%20HL-L2460DW._ipp._tcp.local/?uuid=e3248000-80ce-11db-8000-b42200d7215d";
        model = "drv:///sample.drv/generpcl.ppd";
      }
    ];
    ensureDefaultPrinter = "Brother_HL_L2460DW_USB";
  };

}
