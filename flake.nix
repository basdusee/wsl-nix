{
  description = "Home Manager config for WSL2 (Debian), in a flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, ... }@attrs:

    {

      # use `home-manager switch --flake .#wsl` to activate this config
      homeConfigurations =  let

        # import settings from a separate file, which can be edited locally
	uservars = import ./config.nix;
        pkgs = import nixpkgs { system = "x86_64-linux"; };

      in {

        "wsl" = home-manager.lib.homeManagerConfiguration {

          inherit pkgs;

          modules = [

            {
                # import softwarez, "packages.nix" is a general list with software
                # the other imports are for specific programs with lots of settings.
                imports = let
                  vars = (attrs // {inherit uservars; inherit pkgs;});
                in [
                  ./packages.nix
                  (import ./git vars)
                  (import ./neovim vars)
                  ./starship
                  ./tmux
                ];

                # Import the necessary home-manager settings from our config vars
                home =  let
		  # #uservars = import ./config.nix;
		  inherit uservars;
		in {
                  username = uservars.username;
                  homeDirectory = uservars.homeDirectory;
                  stateVersion = uservars.nixVersion; # Please read some comment about something. 
                  sessionVariables = { EDITOR = "nvim";};
                };

                # plz use nvim as default editor

                programs = {

                  # Let Home Manager install and manage itself.
                  home-manager.enable = true;

                  # Enable some tools with extra settings
                  bat.enable = true;
                  jq.enable = true;
                  direnv.enable = true;

                  # shell config goes here, I have a very plain vanilla zsh, but with starship for bling.
                  zsh = {
                    enable = true;
		    shellAliases = {
		      k = "kubectl";
		      sysrebuild = "pushd && cd ~/.config/home-manager && git add -A && home-manager switch --flake .#wsl && popd";
		    };
                    history = {
                      size = 10000;
                      save = 10000;
                      extended = true;
                    };
                    initExtra = ''
		    [[ $commands[kubectl] ]] && source <(kubectl completion zsh)
                    if [ -e ${uservars.homeDirectory}/.nix-profile/etc/profile.d/nix.sh ]; then . ${uservars.homeDirectory}/.nix-profile/etc/profile.d/nix.sh; fi
                    '';
                  };

              };
            }
        ];

      };
      };
    };
}
