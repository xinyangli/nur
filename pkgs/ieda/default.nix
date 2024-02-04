{ stdenvNoCC
, lib
, cargo
, fetchgit
, pkgsStatic
, gcc11
, cmake
, ninja
, flex
, bison
, zlib
, tcl
, gflags
, glog
, boost180
, eigen
, yaml-cpp
, libunwind
, metis
, gmp
, python3
}:

stdenvNoCC.mkDerivation rec {
  name = "iEDA";
  version = "0.3";
  # src = fetchFromGitHub {
  #   owner = "OSCC-Project";
  #   repo = "iEDA";
  #   rev = "a7df35fb4667cc099ab76d10da113f09060ac0ea";
  #   hash = "sha256-ShMZ20EoFM34JUjmBh2enHTarM0qQbYb5A5eoC9D/VA=";
  # };
  src = fetchgit {
    url = "https://gitee.com/oscc-project/iEDA.git";
    name = "iEDA";
    rev = "4de9f6c2dc602852fc1b668a866ffee0d96e2dcb";
    hash = "sha256-BBVLVa2vuKdhz0Eb5aRrlkAMXlLcrTKWW63G3L3XgyE="; 
  };
  patches = [ ./fixtcl.patch ./fix_header.patch ];

  nativeBuildInputs = [
    gcc11
    cargo
    cmake
    ninja
    flex
    bison
    zlib
  ];

  buildInputs = [
    tcl
    pkgsStatic.gtest
    gflags
    glog
    boost180
    eigen
    yaml-cpp
    libunwind
    metis
    gmp
    python3
  ];

  cmakeFlags = [
    "-DBUILD_STATIC_LIB=off"
  ];

  CXXFLAGS = "-fpermissive";
  meta = with lib; {
    description = "An open-source EDA infracstrucutre and tools from netlist to GDS for ASIC design.";
    homepage = "https://gitee.com/oscc-project/iEDA";
    license = licenses.mulan-psl2;
    maintainers = with maintainers; [ ];
    broken = true;
  };
}
