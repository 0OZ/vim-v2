return {
  -- Satellite: scrollbar with git, diagnostics, and search decorations
  {
    "lewis6991/satellite.nvim",
    event = "VeryLazy",
    opts = {
      current_only = false,
      winblend = 50,
      zindex = 40,
      excluded_filetypes = {
        "prompt",
        "TelescopePrompt",
        "noice",
        "notify",
        "neo-tree",
        "help",
        "alpha",
        "dashboard",
        "lazy",
        "mason",
        "NvimTree",
        "Trouble",
        "trouble",
      },
      width = 2,
      handlers = {
        cursor = {
          enable = true,
        },
        search = {
          enable = true,
        },
        diagnostic = {
          enable = true,
          signs = { "-", "=", "≡" },
        },
        gitsigns = {
          enable = true,
          signs = {
            add = "│",
            change = "│",
            delete = "-",
          },
        },
        marks = {
          enable = true,
          show_builtins = false,
        },
      },
    },
    config = function(_, opts)
      require("satellite").setup(opts)

      -- Add error handling to prevent crashes on buffer deletion
      local ok, view = pcall(require, "satellite.view")
      if ok and view then
        local original_update = view.update
        view.update = function(...)
          local success, err = pcall(original_update, ...)
          if not success and not err:match("unable to get a view") then
            vim.notify("Satellite error: " .. tostring(err), vim.log.levels.WARN)
          end
        end
      end
    end,
  },
}
