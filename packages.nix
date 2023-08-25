{ pkgs, ... }:

{

  home.packages = with pkgs; [

    # new age Rust tools
    bat             # better cat 
    exa             # better ls
    fd              # better find
    ripgrep         # better grep
    tldr            # shorter man

    # network tools
    dnstracer       # follow dns servers to root
    ipcalc          # simple subnet calculator
    minicom         # serial console
    nmap            # portscanner. THE portscanner.
    ngrep           # network packet analyzer
    openssh         # ssh, but it's very open (the OpenBSD ssh).
    socat           # network plumbing
    tcpreplay       # replay a captured tcp stream, on the network
    tcptraceroute   # traceroute, but with tcp packets
    rsync           # sync dirs, local or over the network
    wget            # get thigs from the web
    mosh            # stateless ssh, easy reconnect
    mtr             # tui traceroute

    # file (system) tools
    binwalk         # 
    dos2unix        # strip cr\lf to only cr
    hexedit         # hex (and ascii) editor 
    jq              # json query, parse json files
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

    # tools
    btop            # better htop
    et              # "egg-timer", uses libnotify
    fzf             # fuzzy finder
    git             # well, git
    git-crypt       # encrypt stuff like credentials
    glow            # markdown reader
    gnupg           # gnu privacy guard
    htop            # system performance
    insomnia        # postman api thingy
    magic-wormhole  # transfer files and text safely
    meld            # gui differ
    neofetch        # distro displayer
    zbar            # command line qr and barcode reader

    # shenanigans
    asciiquarium    # fishes, in your terminal
    cmatrix         # the matrix on the console
    hollywood       # fill your screen with busy nonsense
    sl              # ls mistyping punisher

    # language servers for neovim
    rnix-lsp        # nix files lsp
    rust-analyzer   # rustlang lsp

    # more elaborate tools
    podman          # like docker, but better

  ];
}
