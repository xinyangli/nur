{ stdenv
, lib
, fetchFromGitHub
, cmake
, coreutils
, ninja
, git
, circtVersion
, python3
}:
let
  pythonEnv = python3.withPackages (ps: [ ps.psutil ]);
  versionHash = {
    "v1_43_0" = "sha256-RkjigboswLkLgLkgOGahQLIygCkC3Q9rbVw3LqIzREY=";
  };
in
stdenv.mkDerivation rec {
  pname = "circt";
  version = circtVersion;
  src = fetchFromGitHub {
    owner = "llvm";
    repo = "circt";
    rev = "firtool-${version}";
    sha256 = versionHash.${"v" + builtins.replaceStrings ["."] ["_"] circtVersion};
    fetchSubmodules = true;
  };

  requiredSystemFeatures = [ "big-parallel" ];

  nativeBuildInputs = [
    cmake
    ninja
    git
    pythonEnv
  ];

  cmakeDir = "../llvm/llvm";
  cmakeFlags = [
    "-DLLVM_ENABLE_BINDINGS=OFF"
    "-DLLVM_ENABLE_OCAMLDOC=OFF"
    "-DLLVM_BUILD_EXAMPLES=OFF"
    "-DLLVM_OPTIMIZED_TABLEGEN=ON"
    "-DLLVM_ENABLE_PROJECTS=mlir"
    "-DLLVM_EXTERNAL_PROJECTS=circt"
    "-DLLVM_EXTERNAL_CIRCT_SOURCE_DIR=.."
    "-DCIRCT_LLHD_SIM_ENABLED=OFF"
  ];

  LIT_FILTER_OUT = if stdenv.cc.isClang then "CIRCT :: Target/ExportSystemC/.*\.mlir" else null;

  preConfigure = ''
    find ./test -name '*.mlir' -exec sed -i 's|/usr/bin/env|${coreutils}/bin/env|g' {} \;
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    mv bin/{{fir,hls}tool,circt-{as,dis,lsp-server,opt,reduce,translate}} $out/bin
    runHook postInstall
  '';

  doCheck = true;
  checkTarget = "check-circt check-circt-integration";

  meta = {
    description = "Circuit IR compilers and tools";
    homepage = "https://circt.org/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ sharzy ];
    platforms = lib.platforms.all;
  };
}
