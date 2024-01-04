{ stdenv
, fetchFromGitHub
, lib
, SDL2
, SDL2_image
, python3
}:

stdenv.mkDerivation rec {
  name = "nvboard";
  version = "0.3";
  src = fetchFromGitHub {
    owner = "NJU-ProjectN";
    repo = "nvboard";
    rev = "23e79f86a6f915592cdf0af1c045a6f96082823c";
    hash = "sha256-/sC2XD19MVgwKJH/rdCsfewR/Yf7cyd9okQV/AErP+k=";
  };
  patches = [ ./fixpics.patch ];

  propagatedBuildInputs = [
    SDL2
    SDL2_image
  ];

  buildInputs = [
    python3
  ];

  buildPhase = ''
    export CXXFLAGS="-DNVBOARD_HOME=\\\"$out/share/nvboard\\\""
    echo $CXXFLAGS
    make NVBOARD_HOME=$(pwd) -f ./scripts/nvboard.mk
  '';

  installPhase = ''
    mkdir -p $out/lib
    mkdir -p $out/include
    mkdir -p $out/bin
    mkdir -p $out/share/nvboard/pic
    mkdir -p $out/share/nvboard/board

    cp ./build/nvboard.a $out/lib/libnvboard.a
    cp ./include/* $out/include/
    cp ./pic/* $out/share/nvboard/pic
    cp ./board/* $out/share/nvboard/board

    # Pin binding script
    sed -i "s|os.environ.get('NVBOARD_HOME')|\"$out/share/nvboard\"|g" ./scripts/auto_pin_bind.py
    install ./scripts/auto_pin_bind.py $out/bin/auto_pin_bind
  '';
}
