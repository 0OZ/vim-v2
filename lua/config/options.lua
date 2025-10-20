-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Disable animations and make UI faster
vim.o.updatetime = 250 -- Faster completion and diagnostics
vim.o.timeoutlen = 300 -- Faster which-key popup
vim.o.ttimeoutlen = 10 -- Faster key code delay

-- Disable smooth scrolling
vim.o.smoothscroll = false

-- LSP log level (use "debug" for troubleshooting, "warn" for normal use, "error" to suppress most messages)
vim.lsp.log.level = "error"

-- LSP diagnostics configuration
vim.diagnostic.config({
  virtual_text = true, -- Show errors inline
  signs = true, -- Show error signs in gutter
  underline = true, -- Underline errors
  update_in_insert = false, -- Don't show errors while typing
  severity_sort = true, -- Sort by severity
  float = {
    border = "rounded",
    source = "always", -- Show error source (e.g., "kotlin_language_server")
  },
})
