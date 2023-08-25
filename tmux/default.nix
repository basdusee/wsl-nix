{ config, lib, pkgs, ... }:

{

  programs.tmux = {

    # Main settings
    enable = true;
    prefix = "C-a";                  # change C-b to C-a
    terminal = "tmux-256color";      # set the in-tmux TERM value
    shell = "${pkgs.zsh}/bin/zsh";   # needed for newSession apparently  
    clock24 = true;                  # set 24 clock format
    keyMode = "vi";                  # use vi keybindings, of course
    historyLimit = 5000;             # size of the history, default is 2000
    newSession = true;               # spawn new session if reattaching and no sessions exist
    sensibleOnTop = false;           # don't run the sensible plugin, not needed 
    tmuxp.enable = false;            # don't know what tmuxp is, but don't want it.
    tmuxinator.enable = false;       # don't know what tmuxinator is, bot don't want it.

    extraConfig = (builtins.readFile ./tmux-extra.conf);

    # Defaults, didn't change these settings
    #agressiveResize = false;        # default value, resize to smallest session
    #baseIndex = 0;                  # default value, first pane is 0
    #customPaneNavigationAndResize = false;  # custom hjkl bindings in vi mode
    #disableConfirmationPrompt = false;      # disable confirmation on kill pane
    #escapeTime = 500;               # miliseconds wait after escape for input
    #package = pkgs.tmux;            # the package to use, is tmux of course
    #reverseSplit = false;           # reverse the window split shortcuts
    #resizeAmount = 5;               # how much the resize command does
    #secureSocket = true;            # socket in /run, which is more secure, but tmux exits on use logout
    #plugins = [];                   # no plugins for now
    
  };
}
