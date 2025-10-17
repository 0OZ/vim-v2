return {
  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "lua",
        "python",
        "vim",
        "vimdoc",
        "query",
        "javascript",
        "typescript",
        "json",
        "html",
        "css",
        "go",
        "rust",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    },
  },
}
