return {
  -- Add gopls (Go language server)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            on_dir(
              vim.fs.root(fname, "go.work")
                or vim.fs.root(fname, "go.mod")
                or vim.fs.root(fname, ".git")
            )
          end,
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
              gofumpt = true,
              usePlaceholders = true,
              completeUnimported = true,
              codelenses = {
                gc_details = false,
              },
              -- Group internal packages into their own import block.
              -- Set this to your monorepo's module prefix, e.g. "github.com/acme".
              -- ["local"] = "github.com/your-org",
            },
          },
        },
      },
    },
  },

  -- Ensure gopls is installed via Mason
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",       -- Go language server
        "goimports",   -- Go imports formatter
        "gofumpt",     -- Go formatter
        "biome",       -- JavaScript/TypeScript formatter and linter
      },
    },
  },

  -- Disable golangci-lint via nvim-lint: its typecheck pass doesn't
  -- understand go.work monorepos and surfaces bogus "go.mod file not
  -- found" diagnostics. gopls already handles Go diagnostics.
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.go = {}
    end,
  },
}
