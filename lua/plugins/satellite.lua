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

      -- Add comprehensive error handling to prevent crashes on buffer/window operations
      local ok, view = pcall(require, "satellite.view")
      if ok and view then
        -- Wrap update function
        local original_update = view.update
        view.update = function(...)
          -- Silently ignore errors during buffer/window closing
          pcall(original_update, ...)
        end

        -- Wrap refresh function if it exists
        if view.refresh then
          local original_refresh = view.refresh
          view.refresh = function(...)
            pcall(original_refresh, ...)
          end
        end

        -- Wrap any view rendering functions
        if view.render then
          local original_render = view.render
          view.render = function(...)
            pcall(original_render, ...)
          end
        end
      end
    end,
  },
}
