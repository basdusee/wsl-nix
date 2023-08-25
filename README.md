# Nix (home-manager) config to be used inside a WSL

This repo consists of a nix config which can be cloned and activated.
After that all the nice and juicy tools I normally use are available.
And, they are all (pre)configured and working like intended.

## Installation

Let's install this piece of Nix on a Windows machine.

### Prerequisites

Please install Windows Terminal first. It's not really mandatory, but it's the only installable terminal on Windows 10/11 which is actually usable somewhat.
(it has it's quirks however, it's definately not iTerm2 or Alacritty).
Please take some time to configure Windows Terminal to your likings (fonts, color schemes etcetera).

There are enough resources online how to perfectly configure Windows Terminal, please use them.
I'm not goint to tell you here how to configure Windows Terminal, it's a very subjective and personal thing.

### Get WSL2 to work

First install/activate WSL2 on Windows, if this isn't done yet. Don't know exactly how I did it, but it's something like this in a PowerShell prompt:
- PS C:\Ugly\Stupid\Windows\Prompt> `wsl --install`

You only type the `wsl --install of course`. And oh, you need adminstrator rights.

Next, install Alpine WSL. It's in the Microsoft Store actually. Search for "Alpine WSL" in the store.

When "opening" the Alpine WSL "App" from the store, a (Linux) terminal pops up which asks you to define a user.
Please fill in a proper username and give it a password. 
This user is automatically added to the `wheel` group which is necessary.

### Alpine WSL nixification steps:

First follow the hint/instruction at the end of the Alpine "App" install terminal, and give root a password:
- PS C:\Stupid\Prompt> `wsl -u root -d Alpine passwd`

Next start up a Windows Terminal session with Alpine (push the `v` next to the `+` and select "Alpine").

- We first need to install some tools and enable `sudo`:
    - `su -`
    - root# `apk add --no-cache sudo curl xz git nano`
    - root# `echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel`
    - root# `chmod 440 /etc/sudoers.d/wheel`
    - (you can now delete the root password if you want with `passwd -d root`)
    - Do some preparation for later, replace `superman` with own username:
    - root# `echo '/home/superman/.nix-profile/bin/zsh' >> /etc/shells`
    - root# `exit`   (to bring you back to the user prompt)
- Install Nix, config nix and "activate" nix (the environment at least)
    - `curl -L https://nixos.org/nix/install | sh`
    - `mkdir -p ~/.config/nix/`
    - `echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf`
    - `echo "source /home/superman/.nix-profile/etc/profile.d/nix.sh" >> ~/.profile`
    - `source ~/.nix-profile/etc/profile.d/nix.sh`
- Create home-manager directory and pull the repo:
    - `cd ~/.config`
    - `git clone https://github.com/basdusee/wsl-nix.git home-manager`
    - `cd home-manager`
- Edit the stock configuration file and put in your own username and metadata:
    - `nano config.nix`
    - `git add -A`
    - Do the changes, and save the file. Put your login name in `username` because nix checks the `USER` env variable.
    - Optional: `git update-index --skip-worktree config.nix` (if you intent to ever do a pull request or a push to a repo).
- Do the initial home-manager check-out. We use `nix run` because there is no home-manager installed yet.
    - `nix run home-manager/release-23.05 -- switch --flake .#wsl`
- Change your shell to zsh:
    - `chsh` and in the dialog, insert `/home/superman/.nix-profile/bin/zsh`, to replace /bin/ash.
- Log out and back in, and it's all finished!

FINALLY FINISHED.

### Maintenance and change of config

- If you want to change the config later:
    - `cd ~/.config/home-manager`
    - `vi/vim/nano/whatever flake.nix` (edit the file flak.nix).
    - `home-manager switch --flake .#wsl`

- If you want to update all the packages
    - `cd ~/.config/home-manager`
    - `nix flake update`
    - `git add -A`
    - `home-manager switch --flake .#wsl`

Be aware of the fact that nix flakes uses the current staged files in git, not the actual files in the directory per se.
It copies all the staging files into the store and runs flake-magic there.
So do not forget to git add -A your files (git commit is not necessary but gives a warning if you don't).

## Problems and solutions (FAQ-ish thingy)

### There is no user in Alpine, it drops me in a root prompt directly

Someone (probably you) forgot to create a user during installation of the "App". 
This can easily be fixed fortunately.

Follow these steps as root, before doing anything else in the "Alpine WSL nixification' section.
- add a user (if this isn't done already) and add user to wheel group. We use "superman" as an example here, please use your own preferred username instead of superman.
    - `adduser superman`
    - `adduser superman wheel`
- give it a password:
    - `passwd superman`
- Become that user
    - `su superman`
- In the main procedure, do _not_ user `su -` to become root, but use `sudo` instead (just prepend the commands with `sudo`).

### WSL is not responding or borked, CPU usage is high for no apparent reason

If you occur a problem with WSL not working properly, like blinking cursor but it won't start, please start an _Administrator_ PowerShell terminal and do:
`PS C:\prompt> Restart-Service vmcompute`
This will restart Hyper-V and resets WSL. You could also restart the service directly from Services (don't know exactly which one it is) or simply restart your computer.

There is a known bug in WSL where if you (dis)connect a second monitor and/or put your laptop into sleep or some other weird related stuff, your CPU will spike at 100% and WSL gets very sluggy or just freezes.
Sorry, this is a bug, not a feature. Microsoft is working the past 2 years on it to fix it, presumably. WSL is still a lot crappier than real Linux.

