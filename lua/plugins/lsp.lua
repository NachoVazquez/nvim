return {
  -- neodev
  {
    "folke/neodev.nvim",
    opts = {
      debug = true,
      experimental = {
        pathStrict = true,
      },
      library = {
        runtime = "~/projects/neovim/runtime/",
      },
    },
  },

  -- tools
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "prettierd",
        "stylua",
        "selene",
        "luacheck",
        "eslint_d",
        "shellcheck",
        -- "deno",
        "shfmt",
        "black",
        "isort",
        "flake8",
      },
    },
  },

  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = {
        "<leader>f",
        require("lazyvim.plugins.lsp.format").format,
        desc = "Format Document",
        has = "documentFormatting",
      }
      keys[#keys + 1] = {
        "<leader>f",
        require("lazyvim.plugins.lsp.format").format,
        desc = "Format Range",
        mode = "v",
        has = "documentRangeFormatting",
      }
      if require("lazyvim.util").has("inc-rename.nvim") then
        keys[#keys + 1] = {
          "<leader>rn",
          function()
            require("inc_rename")
            return ":IncRename " .. vim.fn.expand("<cword>")
          end,
          expr = true,
          desc = "Rename",
          has = "rename",
        }
      else
        keys[#keys + 1] = { "<leader>rn", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
      end
    end,
    opts = {
      ---@type lspconfig.options
      servers = {
        astro = {},
        ansiblels = {},
        bashls = {},
        clangd = {},
        -- denols = false,
        cssls = {},
        dockerls = {},
        tsserver = {},
        svelte = {},
        eslint = {},
        html = {},
        -- gopls = {},
        marksman = {},
        pyright = {},
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              procMacro = { enable = true },
              cargo = { allFeatures = true },
              checkOnSave = {
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
            },
          },
        },
        yamlls = {},
        lua_ls = {
          -- cmd = { "/home/folke/projects/lua-language-server/bin/lua-language-server" },
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Both",
              },
              misc = {
                parameters = {
                  "--log-level=trace",
                },
              },
              diagnostics = {
                -- enable = false,
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = false,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
        teal_ls = {},
        vimls = {},
        tailwindcss = {},
        intelephense = {},
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        clangd = function(_, opts)
          opts.capabilities.offsetEncoding = { "utf-16" }
        end,
      },
    },
  },

  -- null-ls
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   config = function()
  --     local nls = require("null-ls")
  --     nls.setup({
  --       debounce = 150,
  --       save_after_format = false,
  --       sources = {
  --         -- nls.builtins.formatting.prettierd,
  --         nls.builtins.formatting.stylua,
  --         -- nls.builtins.formatting.fixjson.with({ filetypes = { "jsonc" } }),
  --         nls.builtins.formatting.eslint_d,
  --         -- nls.builtins.diagnostics.shellcheck,
  --         nls.builtins.formatting.shfmt,
  --         nls.builtins.diagnostics.markdownlint,
  --         -- nls.builtins.diagnostics.luacheck,
  --         nls.builtins.formatting.prettierd.with({
  --           filetypes = { "markdown" }, -- only runs `deno fmt` for markdown
  --         }),
  --         nls.builtins.diagnostics.selene.with({
  --           condition = function(utils)
  --             return utils.root_has_file({ "selene.toml" })
  --           end,
  --         }),
  --         -- nls.builtins.code_actions.gitsigns,
  --         nls.builtins.formatting.isort,
  --         nls.builtins.formatting.black,
  --         nls.builtins.diagnostics.flake8,
  --       },
  --       root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", ".git"),
  --     })
  --   end,
  -- },
}
