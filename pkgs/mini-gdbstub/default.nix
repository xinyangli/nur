{ lib
, stdenv
, fetchFromGitHub
, gnumake
}:

stdenv.mkDerivation rec {
  pname = "mini-gdbstub";
  version = "2024-04-25";

  src = fetchFromGitHub {
    owner = "xinyangli";
    repo = "mini-gdbstub";
    rev = "b434a22822b1d2f5a067faf621f9d246c70f3a93";
    hash = "sha256-tnnpwfYpVhIufbz+2rgiUhspo+Cuqco35b+eax20vQo=";
  };

  nativeBuildInputs = [
    gnumake
  ];

  installPhase = ''
    mkdir -p $out/lib $out/include
    cp build/libgdbstub.a $out/lib
    cp include/gdbstub.h $out/include
  '';

  meta = with lib; {
    description = "An implementation of the GDB Remote Serial Protocol to help you adding debug mode on emulator";
    homepage = "https://github.com/xinyangli/mini-gdbstub";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "mini-gdbstub";
    platforms = platforms.all;
  };
}
