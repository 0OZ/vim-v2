--- Re-sign tree-sitter parser .so files so macOS doesn't kill nvim (code signature invalid).
local function codesign_parsers()
  local parser_dir = vim.fn.stdpath("data") .. "/site/parser"
  local parsers = vim.fn.glob(parser_dir .. "/*.so", false, true)
  for _, so in ipairs(parsers) do
    vim.fn.system({ "codesign", "--force", "--sign", "-", so })
  end
end

return {
  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })()
      codesign_parsers()
    end,
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
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      -- Re-sign parsers after any :TSInstall or :TSUpdate
      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = codesign_parsers,
      })
    end,
  },
}
