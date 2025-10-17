return {
  -- Add gopls (Go language server)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
              gofumpt = true,
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
      },
    },
  },
}
