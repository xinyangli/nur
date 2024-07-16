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
    rev = "f89e5ffc7a68de26c586e96a0c001873d184c7b2";
    hash = "sha256-sgQ/4jlZXxK5pOz5mb7WxkjkWQa688z4p4A9Fva8144=";
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
