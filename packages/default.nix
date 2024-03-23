{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "tree-sitter-graph";
  version = "0.11.2";

  src = fetchFromGitHub {
    owner = "tree-sitter";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-YHSIcCz0HhugKgzRyo44sHvtqH8ZcBdTEGk+MpNY/CY=";
  };

  cargoPatches = [./add-Cargo.lock.patch];
  cargoSha256 = "sha256-De+IYPFZ6nwtOnaWmaJr2T3aVqqZxFjlGJIn4YQKiLs=";
  cargoDeps = rustPlatform.importCargoLock {
    lockFile = ./Cargo.lock;
  };
  cargoBuildFlags = ["--all-features"];

  meta = {
    description = "Construct graphs from parsed source code";
    homepage = "https://github.com/tree-sitter/tree-sitter-graph";
    license = lib.licenses.mit;
    maintainers = [];
  };
}
