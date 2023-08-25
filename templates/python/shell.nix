{ pkgs ? import <nixpkgs> {} }:

let
  # Python libraries installed in the environment
  pythonEnv = pkgs.python3Full.withPackages (ps: with ps; [
    requests
  ]);

in pkgs.mkShell {

  # Programs installed in the shell
  buildInputs = with pkgs; [
    pythonEnv
    black
    mypy
    poetry
  ];

}
