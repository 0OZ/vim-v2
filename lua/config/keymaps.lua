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

-- Override Ctrl+] to use LSP definition instead of tags
vim.keymap.set("n", "<C-]>", function()
  vim.lsp.buf.definition()
end, { desc = "Go to Definition (LSP)" })

-- Also add Ctrl+T to go back (standard vim behavior)
vim.keymap.set("n", "<C-t>", "<C-o>", { desc = "Go Back" })
