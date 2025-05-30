{ stdenv, ... }:
stdenv.mkDerivation {
  name = "caarlos0-bins";
  version = "unstable";
  src = ./bin;
  installPhase = ''
    mkdir -p $out/bin
    cp * $out/bin
  '';
}
