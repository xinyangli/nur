{ lib
, rustPlatform
, fetchFromGitHub
}:

rustPlatform.buildRustPackage rec {
  pname = "pcap2socks";
  version = "0.6.2";

  src = fetchFromGitHub {
    owner = "xinyangli";
    repo = "pcap2socks";
    rev = "2c34673b0013160ee3f083f724d31b0b60ad2889";
    hash = "sha256-YkSHhbybvIM8obfWnw475YVrrysgDlHQsOYPm53028Q=";
  };

  cargoLock = let
    fixupLockFile = path: (builtins.readFile path);
  in {
    lockFileContents = fixupLockFile ./Cargo.lock;
    outputHashes = {
      "netifs-0.3.0" = "sha256-DOHEDP1iazHFOt1x5DpxRjr8KD7Sm7/RxKI492HDk3I=";
    };
  };

  meta = with lib; {
    description = "Redirect traffic to SOCKS proxy with pcap";
    homepage = "https://github.com/zhxie/pcap2socks";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "pcap2socks";
  };
}
