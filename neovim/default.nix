{ pkgs, uservars, ... }:

{
  programs.neovim = let
    nvimconfig = with builtins; replaceStrings ["{{userdir}}"] [uservars.homeDirectory] (readFile ./init.lua) ;
  in {

    enable = true;
    viAlias = true;
    # vimAlias = true; # not yet!! let's keep vim around
    # vimdiffAlias = true; ## not yet!!

    # load in the lua config file
    extraConfig = "lua << EOF\n" + nvimconfig + "\nEOF";

    withNodeJs = false; # this is the default
    withRuby = false; # default is true
    withPython3 = true;

    plugins = with pkgs.vimPlugins; [ 

          # the basics
          vim-sensible # sane defaults

          # colours
          vim-colorschemes # _lots_ of colour schemes
          tokyonight-nvim # nice color scheme
          awesome-vim-colorschemes # even more colours
          rainbow  # colour matching parenthesis in same color

          # syntax plugins, speaks for itself
          rust-vim
          salt-vim
          vim-toml
          vim-yaml
          vim-markdown
          vim-clang-format
          vim-addon-nix # nix syntax


          tabular
          fern-vim
          vim-clojure-static
          vim-clojure-highlight

          vim-salve # no idea what this was
          vim-projectionist # no idea what this is

          # neovim specific
          (nvim-treesitter.withPlugins (p: with p; [
            c
            diff
            dockerfile
            lua
            nix
            rust
            python
            clojure
            ocaml
            haskell
	  ]))  # syntax highlighting on steroids -- we're going to configure this later. see https://github.com/nvim-treesitter/nvim-treesitter
	  nvim-ts-rainbow    # Treesitter rainbow braces

          # neovim lsp 
          nvim-lspconfig     # LSP thingy, not necessary, makes configuring lsp easier

          # autocompleter. remember: activate all necessary plugins
          cmp-nvim-lsp       # LSP plugin (so it LSP autocompletes)
          cmp-buffer         # buffer plugin
          cmp-path           # path plugin
          cmp-cmdline        # cmdline plugin
          cmp-vsnip          # vsnip plugin, so you can autocomplete vsnippets
          nvim-cmp           # autocompleter, main package
          vim-vsnip          # Bullshit extra plugin needed by cmp


          # neovim Telescope related plugins
          popup-nvim
          plenary-nvim       # collection of util functions, async, job, filetypes etc.
          telescope-nvim     # awesome telescope plugin.
        ];

    extraPackages = with pkgs; [
      # rnix-lsp                     # .nix file lsp
      sumneko-lua-language-server  # lua lsp
    ];

  };
}
