with import <nixpkgs> {};

mkShell {

  shellHook = ''
    echo "Welcome to the Clojure metaverse(tm)"
    clj
  '';

  # Programs installed in the shell
  packages = [
    clojure
    leiningen
  ];


}
