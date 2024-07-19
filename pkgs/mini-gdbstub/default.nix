{ lib
, stdenv
, fetchFromGitHub
, gnumake
}:

stdenv.mkDerivation rec {
  pname = "mini-gdbstub";
  version = "2024-07-16";

  src = fetchFromGitHub {
    owner = "xinyangli";
    repo = "mini-gdbstub";
    rev = "0aff46d138960f59b1fa4f31bc7a5afbf15a9811";
    hash = "sha256-aDe+46teDiEbdACr44881fGTEGVhKKMHvLuA5xH79cQ=";
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
