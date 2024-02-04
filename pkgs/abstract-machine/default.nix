{ lib
, stdenvNoCC
, fetchFromGitHub
, pkgsCross
, gnumake
, isa ? "riscv32e"
, platform ? "nemu"
}:

let 
  isa_mapping = {
    riscv32e = "riscv64";
  };
in stdenvNoCC.mkDerivation rec {
  pname = "abstract-machine";
  version = "2023-08-29";

  src = fetchFromGitHub {
    owner = "NJU-ProjectN";
    repo = "abstract-machine";
    rev = "3348db971fd860be5cb28e21c18f9d0e65d0c96a";
    hash = "sha256-jZVivawwHXw5WCrHm5vOb9nDBqK6BFVer8Zec0/oZvc=";
  };

  nativeBuildInputs = [
    gnumake
    pkgsCross.${isa_mapping.${isa}}.gcc
  ];

  SRCS = src;
  AM_HOME = src;
  ARCH = "${isa}-${platform}";
  MAKECMDGOALS = "image";

  meta = with lib; {
    description = "A minimal, modularized, and machine-independent hardware abstraction layer";
    homepage = "https://github.com/NJU-ProjectN/abstract-machine.git";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    broken = true;
  };
}
