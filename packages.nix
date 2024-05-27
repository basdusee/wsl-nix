{ pkgs, ... }:

{
  home.packages = with pkgs; [

    # Clojure stuff
    clojure         # Clojure
    leiningen       # Clojure management tool

    # Python3 stuff
    # Python libraries installed in the environment
    (python3.withPackages (ps: with ps; [
      flake8
      ipython
      notebook
      polars
      requests
      python-pkcs11   # for EJBCA REST api test
      pyopenssl       # for EJBCA REST api test
      yubico          # for EJBCA REST api test
    ]))
    black
    #jupyter        # no worky with custom python3.withPackages
    poetry
    mypy
    xonsh           # advanced python shell

    # (All the) Julia stuff
    julia           # jep, that's it.

    # Rust stable stuff
    cargo
    clippy
    gcc
    rust-analyzer   # rustlang lsp
    rustc
    rustfmt

    # new age Rust tools
    #bat            # better cat, via programs.bat.enable = true;
    eza             # better ls
    fd              # better find
    ripgrep         # better grep
    tldr            # shorter man

    # network tools
    dnstracer       # follow dns servers to root
    ipcalc          # simple subnet calculator
    minicom         # serial console
    mosh            # stateless ssh, easy reconnect
    mtr             # tui traceroute
    nmap            # portscanner. THE portscanner.
    ngrep           # network packet analyzer
    openssh         # ssh, but it's very open (the OpenBSD ssh).
    rsync           # sync dirs, local or over the network
    socat           # network plumbing
    stunnel         # TLS "stuff"
    tcpreplay       # replay a captured tcp stream, on the network
    tcptraceroute   # traceroute, but with tcp packets
    wget            # get thigs from the web

    # file (system) tools
    binwalk         # 
    dos2unix        # strip cr\lf to only cr
    file            # plain old file identifier
    hexedit         # hex (and ascii) editor 
    #jq             # json query, via home-manager programs.jq.enable
    mc              # midnight commander, nc clone
    nnn             # extremely minimal file manager
    unzip           # extract zip files

    # Office stuff
    asciidoctor     # make documents from sort-of markdown
    diff-pdf        # something something diff two pdfs
    free42          # calculator
    gimp            # photo editing and drawing
    gnumeric        # spreadsheet
    inkscape        # vector drawing
    mdp             # command line markdown presentation tool
    nyxt            # hackable browser

    # devops tools
    curl            # well, curl is the definition of devops
    dive            # for reading/examining docker images
    git             # well, git
    git-crypt       # encrypt stuff like credentials
    insomnia        # postman api thingy
    k9s             # mega ultra kubernetes ding
    podman          # like docker, but better

    # local tools
    apg             # password generator
    bottom          # top version in Rust
    btop            # better htop
    cpufetch        # neofetch but cpu specific
    et              # "egg-timer", uses libnotify
    fzf             # fuzzy finder
    glow            # markdown reader
    gnupg           # gnu privacy guard
    gnutls          # p11tool, psktool, certtool, gnutls-cli
    htop            # system performance
    magic-wormhole  # transfer files and text safely
    meld            # gui differ
    neofetch        # distro displayer
    opensc          # smart card libraries and tools
    openssl         # All the certs stuff
    p11-kit         # library for loading and sharing pkcs11 modules
    p7zip           # 7z compressor
    pcsctools       # Some tools to check pcsc stuff
    pkcs11helper    # helper library for pkcs11 integration from OpenSC
    speedtest-cli   # test network speed
    yubico-piv-tool # Yubikey tool en PIV lib for pkcs11
    zbar            # command line qr and barcode reader

    # shenanigans
    asciiquarium    # fishes, in your terminal
    cmatrix         # the matrix on the console
    hollywood       # fill your screen with busy nonsense
    sl              # ls mistyping punisher
    xorg.xeyes      # Actually useful for stopping certain bugs in WSL?
    oneko           # cute cat chasing your mouse
  ];

}
