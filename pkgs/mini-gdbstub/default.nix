{ lib
, stdenv
, fetchFromGitHub
, gnumake
}:

stdenv.mkDerivation rec {
  pname = "mini-gdbstub";
  version = "2024-07-25";

  src = fetchFromGitHub {
    owner = "xinyangli";
    repo = "mini-gdbstub";
    rev = "3dff8d1ccffb3411c6ec4b8c0567af7c8738e8a0";
    hash = "sha256-AWVfSsRvEScZMRL7ZuKbPYvFmbRARodf87r3SWUEJqA=";
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
