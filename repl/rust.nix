{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {

  nativeBuildInputs = with pkgs; [ 
    rustc
    cargo
    gcc
  ];

  buildInputs = with pkgs; [
    rustfmt
    clippy
    rust-analyzer
    elf2uf2-rs
  ];

  # Certain Rust tools won't work without this
  RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";

}
