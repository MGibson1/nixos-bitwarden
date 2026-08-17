{pkgs, ...}: let
  helix-assist = pkgs.callPackage ../../packages/helix-assist.nix {};

  # Cost/latency dials, billed per request. Upstream defaults: 200ms, claude-haiku-4-5, 1.
  assistDebounceMs = 1000;
  assistModel = "claude-haiku-4-5";
  assistSuggestions = 1;
in {
  home.packages = with pkgs; [
    rust-analyzer
    lldb

    zellij
    yazi

    helix-assist
  ];

  programs.helix = {
    enable = true;
    settings = {
      editor = {
        scroll-lines = 1; # default: 3
        line-number = "relative";
        mouse = true;
        default-yank-register = "+"; # use system clipboard

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
    };

    languages = {
      language-server.helix-assist = {
        command = "${helix-assist}/bin/helix-assist";
        args = [
          "--handler"
          "anthropic"
          "--anthropic-model"
          assistModel
          "--debounce"
          (toString assistDebounceMs)
          "--num-suggestions"
          (toString assistSuggestions)
        ];
      };

      language-server.rust-analyzer = {
        command = "rust-analyzer";
        config.check = {
          command = "clippy";
          cargo = {
            allFeatures = true;
          };
        };
      };
      language-server.typescript-language-server.config.tsserver = {
        path = "${pkgs.typescript}/lib/node_modules/typescript/lib/tsserver.js";
      };

      language = [
        {
          name = "css";
          language-servers = ["vscode-css-language-server" "tailwindcss-ls" "helix-assist"];
          auto-format = true;
        }
        {
          name = "html";
          language-servers = ["vscode-html-language-server" "tailwindcss-ls"];
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath" "%{buffer_name}"];
          };
          auto-format = true;
        }
        {
          name = "javascript";
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = ["format"];
            }
            "helix-assist"
          ];
          auto-format = true;
        }
        {
          name = "json";
          language-servers = [
            {
              name = "vscode-json-language-server";
              except-features = ["format"];
            }
          ];
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath" "%{buffer_name}"];
          };
          auto-format = true;
        }
        {
          name = "jsonc";
          language-servers = [
            {
              name = "vscode-json-language-server";
              except-features = ["format"];
            }
          ];
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath" "%{buffer_name}"];
          };
          file-types = ["jsonc" "hujson"];
          auto-format = true;
        }
        {
          name = "jsx";
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = ["format"];
            }
            "tailwindcss-ls"
            "helix-assist"
          ];
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath" "%{buffer_name}"];
          };
          auto-format = true;
        }
        {
          name = "markdown";
          language-servers = ["marksman"];
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath" "%{buffer_name}"];
          };
          auto-format = true;
        }
        {
          name = "nix";
          formatter = {
            command = "nixpkgs-fmt";
          };
          auto-format = true;
        }
        {
          name = "rust";
          language-servers = ["rust-analyzer" "helix-assist"];
          formatter = {
            command = "cargo";
            args = ["+nightly" "fmt"];
          };
          auto-format = true;
        }
        {
          name = "sql";
          formatter = {
            command = "sql-formatter";
            args = ["-l" "postgresql" "-c" "{\"keywordCase\": \"lower\", \"dataTypeCase\": \"lower\", \"functionCase\": \"lower\", \"expressionWidth\": 120, \"tabWidth\": 4}"];
          };
          auto-format = true;
        }
        {
          name = "toml";
          language-servers = ["taplo"];
          formatter = {
            command = "taplo";
            args = ["fmt" "-o" "column_width=120" "-"];
          };
          auto-format = true;
        }
        {
          name = "tsx";
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = ["format"];
            }
            "tailwindcss-ls"
            "helix-assist"
          ];
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath" "%{buffer_name}"];
          };
          auto-format = true;
        }
        {
          name = "typescript";
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = ["format"];
            }
            "helix-assist"
          ];
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath" "%{buffer_name}"];
          };
          auto-format = true;
        }
        {
          name = "yaml";
          language-servers = ["yaml-language-server"];
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath" "%{buffer_name}"];
          };
          auto-format = true;
        }
      ];
    };
  };
}
