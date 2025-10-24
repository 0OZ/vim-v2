-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Override LazyVim's move line keymaps to check if buffer is modifiable
vim.keymap.set("n", "<A-j>", function()
  if vim.bo.modifiable then
    vim.cmd("m .+1<cr>==")
  end
end, { desc = "Move Down" })

vim.keymap.set("n", "<A-k>", function()
  if vim.bo.modifiable then
    vim.cmd("m .-2<cr>==")
  end
end, { desc = "Move Up" })

vim.keymap.set("v", "<A-j>", function()
  if vim.bo.modifiable then
    vim.cmd("m '>+1<cr>gv=gv")
  end
end, { desc = "Move Down" })

vim.keymap.set("v", "<A-k>", function()
  if vim.bo.modifiable then
    vim.cmd("m '<-2<cr>gv=gv")
  end
end, { desc = "Move Up" })

-- VSCode-style: Move line up/down with Alt + arrow keys
vim.keymap.set("n", "<M-Up>", function()
  if vim.bo.modifiable then
    vim.cmd("move .-2")
    vim.cmd("normal! ==")
  end
end, { noremap = true, silent = true, desc = "Move Up" })

vim.keymap.set("n", "<M-Down>", function()
  if vim.bo.modifiable then
    vim.cmd("move .+1")
    vim.cmd("normal! ==")
  end
end, { noremap = true, silent = true, desc = "Move Down" })

vim.keymap.set("v", "<M-Up>", function()
  if vim.bo.modifiable then
    vim.cmd("move '<-2")
    vim.cmd("normal! gv=gv")
  end
end, { noremap = true, silent = true, desc = "Move Up" })

vim.keymap.set("v", "<M-Down>", function()
  if vim.bo.modifiable then
    vim.cmd("move '>+1")
    vim.cmd("normal! gv=gv")
  end
end, { noremap = true, silent = true, desc = "Move Down" })

-- Override Ctrl+] to use LSP definition instead of tags
vim.keymap.set("n", "<C-]>", function()
  vim.lsp.buf.definition()
end, { desc = "Go to Definition (LSP)" })

-- Add Ctrl+\ to find references (Note: LazyVim also has 'gr' for this)
vim.keymap.set("n", "<C-\\>", function()
  vim.lsp.buf.references()
end, { desc = "Find References (LSP)" })

-- Also add Ctrl+T to go back (standard vim behavior)
vim.keymap.set("n", "<C-t>", "<C-o>", { desc = "Go Back" })

-- Biome: Fix imports and remove unused (TypeScript/TSX)
vim.keymap.set("n", "<leader>xi", function()
  local ft = vim.bo.filetype
  if ft == "typescript" or ft == "typescriptreact" or ft == "javascript" or ft == "javascriptreact" then
    local bufnr = vim.api.nvim_get_current_buf()
    local filepath = vim.api.nvim_buf_get_name(bufnr)

    if filepath == "" then
      vim.notify("Buffer must be saved to a file first", vim.log.levels.WARN)
      return
    end

    -- Save the buffer first
    vim.cmd("write")

    -- Run biome check with organize imports
    local cmd = string.format("biome check --write --unsafe %s 2>&1", vim.fn.shellescape(filepath))
    local output = vim.fn.system(cmd)
    local exit_code = vim.v.shell_error

    -- Reload the buffer
    vim.cmd("edit!")

    if exit_code == 0 then
      vim.notify("Imports organized with Biome", vim.log.levels.INFO)
    else
      vim.notify("Biome failed: " .. output, vim.log.levels.ERROR)
    end
  else
    vim.notify("Biome organize imports only works on TS/TSX/JS/JSX files", vim.log.levels.WARN)
  end
end, { desc = "Organize Imports (Biome)" })

-- macOS Clipboard configuration
if vim.fn.has("macunix") == 1 then
  vim.g.clipboard = {
    name = "macOS-clipboard",
    copy = {
      ["+"] = "pbcopy",
      ["*"] = "pbcopy",
    },
    paste = {
      ["+"] = "pbpaste",
      ["*"] = "pbpaste",
    },
    cache_enabled = 0,
  }
else
  -- SSH Clipboard (OSC52) for remote sessions
  vim.g.clipboard = {
    name = "osc52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
end
