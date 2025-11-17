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
        "[](#0c3276)"
        "$username"
        "[](fg:#0c3276 bg:#175ddc)"
        "$directory"
        "[](fg:#175ddc bg:#2cdde9)"
        "$git_branch"
        "$git_commit"
        "$git_status"
        "$git_state"
        "[](fg:#2cdde9)"
        "($status) "
      ];
      right_format = lib.concatStrings [
        "($all"
        "[](fg:#a2f4fd) )"
        "($hostname $shlvl)"
        "[ 󰇝 ](fg:#a2f4fd)"
        "($cmd_duration[󰇝 ](fg:#a2f4fd))"
        "$time"
      ];

      username = {
        show_always = true;
        style_user = "bg:#0c3276 fg:#f3f6f9";
        style_root = "bg:#0c3276 fg:#f3f6f9";
        format = "[ $user ]($style)";
      };
      directory = {
        style = "bg:#175ddc fg:#f3f6f9";
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
        style = "bg:#2cdde9 fg:#000000";
        format = "[ $symbol $branch]($style)";
      };
      git_commit = {
        style = "bg:#2cdde9 fg:#000000";
        commit_hash_length = 4;
        only_detached = true;
        tag_disabled = false;
        format = "[ $hash$tag]($style)";
      };
      git_status = {
        style = "bg:#2cdde9 fg:#000000";
        diverged = "󱦲$ahead_count󱦳$behind_count";
        ahead = "󱦲$count";
        behind = "󱦳$count";
        format = "[$all_status$ahead_behind ]($style)";
      };
      git_state = {
        style = "bg:#2cdde9 fg:#ff6550 bold";
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
        # style = "fg:#a2f4fd";
        format = "[ $symbol ($version) ]($style)";
      };
      rust = {
        # symbol = "";
        # style = "fg:#a2f4fd";
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
        style = "fg:#a2f4fd";
        format = "[ $symbol ($version) ]($style)";
        detect_extensions = ["ts" "tsx" "cts" "mts"];
      };

      # Other Right-hand-side

      hostname = {
        ssh_symbol = "";
        style = "fg:#fdc700";
        format = "[@$hostname]($style)";
        ssh_only = false;
        disabled = false;
      };
      shlvl = {
        disabled = false;
        threshold = 1;
        style = "fg:#fdc700";
        format = "[$shlvl󰹺]($style)";
      };
      cmd_duration = {
        disabled = false;
        min_time_to_notify = 500;
      };
      time = {
        disabled = false;
        time_format = "%R"; # Hour:Minute Format
        style = "fg:#a2f4fd";
        format = "[$time]($style)";
      };

      # Things I don't like
      package = {
        disabled = true;
      };
    };
  };
}
