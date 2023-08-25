with import <nixpkgs> {};

let
  # Python libraries installed in the environment
  pythonEnv = python3.withPackages (ps: with ps; [
    requests
    polars
    ipython
  ]);

in mkShell {

  shellHook = ''
    echo "Welcome to the Python metaverse(tm)"
    xonsh
  '';

  # Programs installed in the shell
  packages = [
    pythonEnv
    black
    poetry
    mypy
    jupyter
    xonsh
  ];

}
