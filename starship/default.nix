{ config, lib,  ... }:

{

  programs.starship = {

    enable = true;

    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = false;
    enableIonIntegration = false;

    settings = {
      # no blank lines after prompt
      add_newline = true;

      # single line prompt
      line_break.disabled = true;

      #format = "$all";
      right_format = "$time";
      continuation_prompt = "▶▶";

      # not enabled, but working? should be default disabled?
      # status {};

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[✖](bold red)" ;
        vimcmd_symbol = "[➜](bold green)";
        vimcmd_replace_one_symbol = "[➜](bold purple)";
        vimcmd_replace_symbol = "[➜](bold purple)";
        vimcmd_visual_symbol = "[➜](bold yellow)";
      };

      cmd_duration.disabled = true;

      username ={
        style_user = "yellow bold";
        style_root = "red bold";
        format = "($style) ";
        show_always = false;
        disabled = false;
      };

      hostname = {
        ssh_only = true;
        format =  "[$hostname](bold blue) ";
        disabled = false;
      };

      directory = {
        format = "[$path]($style)[$read_only]($read_only_style) ";
        style = "bold cyan";
        read_only = "🔒";
        read_only_style = "bold yellow";
        truncation_length = 5;
        truncation_symbol = "…/";
        truncate_to_repo = true;
        home_symbol = "~";
      };

      # let's disable cached sudo credentials for now, doesn't add a lot
      sudo = {
        style = "bold green";
        symbol = "<#> ";
        disabled = true;
      };

      # time on the right side
      time = {
        disabled = false;
        style = "yellow";
        format = "[$time]($style)";
      };

      nix_shell = {
        symbol = "[❄️](bold blue) ";
        style = "bold blue";
        format = "via [$symbol$state( \($name\))]($style) ";
        impure_msg = "[impure](bold red)";
        pure_msg = "[pure](bold green)";
        disabled = false;
      };

      # to be considered
      container.disabled = true;
      docker_context.disabled = true;
      # env_var = ??? -> display an env var on the prompt
      # fill = ???? -> fills up the rest of a line with a symbol
      jobs.disabled = true; # show current running background jobs
      kubernetes.disabled = true; # show kubernetes namespace and context, might be interesting
      package.disabled = true; # show current package version of cargo, python, helm packages


      # disable all those stupid language modules and stuff
      aws.disabled = true;
      azure.disabled = true;
      battery.disabled = true;
      buf.disabled = true;
      bun.disabled = true;
      c.disabled = true;
      cmake.disabled = true;
      cobol.disabled = true;
      conda.disabled = true;
      crystal.disabled = true;
      daml.disabled = true;
      dart.disabled = true;
      deno.disabled = true;
      dotnet.disabled = true;
      elixir.disabled = true;
      elm.disabled = true;
      erlang.disabled = true;
      gcloud.disabled = true;
      golang.disabled = true;
      haskell.disabled = true;
      helm.disabled = true;
      hg_branch.disabled = true;
      java.disabled = true;
      julia.disabled = true;
      kotlin.disabled = true;
      localip.disabled = true;
      lua.disabled = true;
      memory_usage.disabled = true;
      meson.disabled = true;
      nim.disabled = true;
      nodejs.disabled = true;
      ocaml.disabled = true;
      openstack.disabled = true;
      perl.disabled = true;
      php.disabled = true;
      pulumi.disabled = true;
      purescript.disabled = true;
      python.disabled = true;
      raku.disabled = true;
      red.disabled = true;
      rlang.disabled = true;
      ruby.disabled = true;
      rust.disabled = true;
      scala.disabled = true;
      shell.disabled = true;
      shlvl.disabled = true;
      singularity.disabled = true;
      spack.disabled = true;
      swift.disabled = true;
      terraform.disabled = true;
      vagrant.disabled = true;
      vlang.disabled = true;
      vcsh.disabled = true;
      zig.disabled = true;
    };
  };
}
