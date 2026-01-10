{pkgs, ...}: {
  home.packages = with pkgs; [
    helix-gpt

    rust-analyzer
    lldb
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
      language-server.gpt = {
        command = "helix-gpt";
        args = ["--handler" "copilot"];
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
          language-servers = ["vscode-css-language-server" "tailwindcss-ls" "gpt"];
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
            "gpt"
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
            "gpt"
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
          language-servers = ["rust-analyzer" "gpt"];
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
            "gpt"
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
            "gpt"
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
