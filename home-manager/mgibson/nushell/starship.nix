{
  config,
  lib,
  ...
}: {
  home.sessionVariables.STARSHIP_CACHE = "${config.home.homeDirectory}/starship";

  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    settings = {
      format = lib.concatStrings [
        "[](#0d3c32)"
        "$username"
        "[](fg:#0d3c32 bg:#145e4e)"
        "$directory"
        "[](fg:#145e4e bg:#24aa8d)"
        "$git_branch"
        "$git_commit"
        "$git_status"
        "$git_state"
        "[](fg:#24aa8d)"
        "($status) "
      ];
      right_format = lib.concatStrings [
        "($all"
        "[](fg:#55dbbe) )"
        "($hostname $shlvl)"
        "[ 󰇝 ](fg:#55dbbe)"
        "($cmd_duration[󰇝 ](fg:#55dbbe))"
        "$time"
      ];

      username = {
        show_always = true;
        style_user = "bg:#0d3c32 fg:#bdbdbd";
        style_root = "bg:#0d3c32 fg:#6d6d6d";
        format = "[ $user ]($style)";
      };
      directory = {
        style = "bg:#145e4e fg:#bdbdbd";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };
      directory.substitutions = {
        "Documents" = "󰈙 ";
        "Downloads" = " ";
        "Music" = " ";
        "Pictures" = " ";
      };
      git_branch = {
        symbol = "";
        style = "bg:#24aa8d fg:#11111b";
        format = "[ $symbol $branch]($style)";
      };
      git_commit = {
        style = "bg:#24aa8d fg:#11111b";
        commit_hash_length = 4;
        only_detached = true;
        tag_disabled = false;
        format = "[ $hash$tag]($style)";
      };
      git_status = {
        style = "bg:#24aa8d fg:#11111b";
        diverged = "󱦲$ahead_count󱦳$behind_count";
        ahead = "󱦲$count";
        behind = "󱦳$count";
        format = "[$all_status$ahead_behind ]($style)";
      };
      git_state = {
        style = "bg:#24aa8d fg:#aa2441 bold";
        format = "\([ $state($progress_current/$progress_total) ]($style)\)";
      };
      status = {
        disabled = false;
        format = "[$symbol]($style)";
      };

      ## Langages
      c = {
        format = "[ $symbol ($version) ]($style)";
      };
      docker_context = {
        format = "[ $symbol $context ]($style) $path";
      };
      dotnet = {
        symbol = "󰌛 ";
        detect_extensions = ["csproj" "fsproj" "xproj" "sln"];
      };
      golang = {
        format = "[ $symbol ($version) ]($style)";
      };
      nodejs = {
        # symbol = "";
        # style = "fg:#55dbbe";
        format = "[ $symbol ($version) ]($style)";
      };
      rust = {
        # symbol = "";
        # style = "fg:#55dbbe";
        format = "[ $symbol ($version) ]($style)";
      };
      custom.nix = {
        disabled = false;
        symbol = "󱄅";
        style = "bold blue";
        format = "[ $symbol nix ]($style)";
        detect_extensions = ["nix"];
      };
      custom.typescript = {
        disabled = false;
        symbol = "󰛦";
        style = "fg:#55dbbe";
        format = "[ $symbol ($version) ]($style)";
        detect_extensions = ["ts" "tsx" "cts" "mts"];
      };

      # Other Right-hand-side

      hostname = {
        ssh_symbol = "";
        style = "fg:#e6cd69";
        format = "[@$hostname]($style)";
        ssh_only = false;
        disabled = false;
      };
      shlvl = {
        disabled = false;
        threshold = 1;
        style = "fg:#e6cd69";
        format = "[$shlvl󰹺]($style)";
      };
      cmd_duration = {
        disabled = false;
        min_time_to_notify = 500;
      };
      time = {
        disabled = false;
        time_format = "%R"; # Hour:Minute Format
        style = "fg:#55dbbe";
        format = "[$time]($style)";
      };
    };
  };
}
