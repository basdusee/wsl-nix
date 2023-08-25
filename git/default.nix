{ pkgs, uservars, ... }:

{
  programs = {

    # main git configuration
    git = {
      enable = true;
      userName = uservars.fullname;
      userEmail = uservars.email;

      # enable the delta pager, which looks nice
      delta = {
        enable = true;
        options = {
          # side-by-side = true;
          line-numbers = true;
          true-color = "always";
          syntax-theme = "gruvbox-dark";
        };
      };

      extraConfig = {
        core = {
          editor = "nvim";
          whitespace = "trailing-space, space-before-tab";
        };
        merge = {
          conflictstyle = "diff3";
        };
      };
    };

    # delta needs a proper `less`, so let's install that also
    less = { enable = true; };

  };
}
