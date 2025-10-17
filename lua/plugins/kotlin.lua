return {
  -- Ensure Kotlin filetype is detected
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "kotlin",
        "java", -- Useful for Spring Boot as many annotations are Java-based
      })
    end,
  },

  -- Kotlin language server configuration
  {
    "neovim/nvim-lspconfig",
    ft = { "kotlin" }, -- Load for Kotlin files
    opts = {
      servers = {
        kotlin_language_server = {
          filetypes = { "kotlin" },
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern("settings.gradle", "settings.gradle.kts", "build.gradle", "build.gradle.kts", "pom.xml")(fname)
              or util.find_git_ancestor(fname)
          end,
          -- Disable problematic features to prevent crashes
          capabilities = (function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            -- Disable document highlight (causes crashes with Spring Boot)
            capabilities.textDocument.documentHighlight = false
            return capabilities
          end)(),
          settings = {
            kotlin = {
              compiler = {
                jvm = {
                  target = "17", -- Adjust based on your Spring Boot version
                },
              },
              linting = {
                debounceTime = 250,
              },
              completion = {
                snippets = {
                  enabled = true,
                },
              },
              -- Disable inlay hints to reduce crashes
              inlayHints = {
                typeHints = false,
                parameterHints = false,
                chainedHints = false,
              },
            },
          },
          init_options = {
            storagePath = vim.fn.stdpath("data") .. "/kotlin-language-server",
          },
        },
      },
    },
  },

  -- Formatting with conform.nvim (better than null-ls)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        kotlin = { "ktlint" },
      },
      formatters = {
        ktlint = {
          command = "ktlint",
          args = { "--format", "--stdin", "$FILENAME" },
        },
      },
      format_on_save = {
        timeout_ms = 3000,
        lsp_fallback = true,
      },
    },
  },

  -- Mason base plugin
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "kotlin-language-server",
        "ktlint",
        "jdtls",
      })
    end,
  },

  -- Enhanced Java/Spring Boot support with nvim-jdtls
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" }, -- Load only for Java files
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      local jdtls = require("jdtls")
      local home = os.getenv("HOME")
      local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
      local workspace_dir = home .. "/.local/share/eclipse-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

      local config = {
        cmd = {
          "jdtls",
          "-data",
          workspace_dir,
        },
        -- Suppress Java stderr warnings
        on_stderr = function(_, data)
          if data then
            local output = table.concat(data, "\n")
            -- Filter out Java warnings and INFO messages
            if not output:match("WARNING:") and not output:match("INFO:") then
              vim.schedule(function()
                vim.notify(output, vim.log.levels.ERROR)
              end)
            end
          end
        end,
        root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
        settings = {
          java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = "fernflower" },
            completion = {
              favoriteStaticMembers = {
                "org.assertj.core.api.Assertions.*",
                "org.junit.jupiter.api.Assertions.*",
                "org.mockito.Mockito.*",
                "org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*",
                "org.springframework.test.web.servlet.result.MockMvcResultMatchers.*",
              },
              filteredTypes = {
                "com.sun.*",
                "io.micrometer.shaded.*",
                "java.awt.*",
                "jdk.*",
                "sun.*",
              },
            },
            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            },
            codeGeneration = {
              toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
              },
              useBlocks = true,
            },
            configuration = {
              runtimes = {
                {
                  name = "JavaSE-17",
                  path = home .. "/.sdkman/candidates/java/current",
                },
              },
            },
          },
        },
        init_options = {
          bundles = {},
        },
        handlers = {
          -- Suppress "Command not supported" errors
          ["language/status"] = function() end,
          ["$/progress"] = function() end,
        },
      }

      -- Start jdtls for Java files
      jdtls.start_or_attach(config)
    end,
  },

  -- Spring Boot specific support
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mfussenegger/nvim-jdtls",
    },
    opts = function(_, opts)
      -- Extend existing servers config
      opts.servers = opts.servers or {}

      -- Add setup hook to configure Spring Boot properties completion
      opts.setup = opts.setup or {}
      opts.setup.kotlin_language_server = function(_, server_opts)
        -- Suppress stderr warnings (Java deprecation warnings, SLF4J, etc.)
        server_opts.cmd = { "kotlin-language-server" }
        server_opts.on_stderr = function(_, data)
          -- Filter out known harmless warnings
          if data then
            local output = table.concat(data, "\n")
            -- Ignore Java deprecation warnings and SLF4J messages
            if not output:match("WARNING:") and not output:match("SLF4J:") then
              -- Only log actual errors
              vim.schedule(function()
                vim.notify(output, vim.log.levels.ERROR)
              end)
            end
          end
        end

        server_opts.on_attach = function(client, bufnr)
          -- Disable code lens to prevent errors
          if client.server_capabilities.codeLensProvider then
            client.server_capabilities.codeLensProvider = false
          end
        end

        -- Suppress specific LSP error handlers
        server_opts.handlers = {
          ["textDocument/documentHighlight"] = function() end,
          ["window/showMessage"] = function(err, result, ctx, config)
            -- Filter out known kotlin-language-server errors
            if result and result.message and not result.message:match("UnsupportedOperationException") then
              vim.lsp.handlers["window/showMessage"](err, result, ctx, config)
            end
          end,
        }

        require("lspconfig").kotlin_language_server.setup(server_opts)
        return true
      end
    end,
  },

  -- Enhanced completion for Spring Boot annotations
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Add Spring Boot annotation snippets
      luasnip.add_snippets("kotlin", {
        luasnip.snippet("@RestController", {
          luasnip.text_node("@RestController"),
        }),
        luasnip.snippet("@RequestMapping", {
          luasnip.text_node('@RequestMapping("'),
          luasnip.insert_node(1, "/api"),
          luasnip.text_node('")'),
        }),
        luasnip.snippet("@GetMapping", {
          luasnip.text_node('@GetMapping("'),
          luasnip.insert_node(1, "/"),
          luasnip.text_node('")'),
        }),
        luasnip.snippet("@PostMapping", {
          luasnip.text_node('@PostMapping("'),
          luasnip.insert_node(1, "/"),
          luasnip.text_node('")'),
        }),
        luasnip.snippet("@PutMapping", {
          luasnip.text_node('@PutMapping("'),
          luasnip.insert_node(1, "/"),
          luasnip.text_node('")'),
        }),
        luasnip.snippet("@DeleteMapping", {
          luasnip.text_node('@DeleteMapping("'),
          luasnip.insert_node(1, "/"),
          luasnip.text_node('")'),
        }),
        luasnip.snippet("@Service", {
          luasnip.text_node("@Service"),
        }),
        luasnip.snippet("@Repository", {
          luasnip.text_node("@Repository"),
        }),
        luasnip.snippet("@Component", {
          luasnip.text_node("@Component"),
        }),
        luasnip.snippet("@Autowired", {
          luasnip.text_node("@Autowired"),
        }),
        luasnip.snippet("@Entity", {
          luasnip.text_node("@Entity"),
        }),
        luasnip.snippet("@Table", {
          luasnip.text_node('@Table(name = "'),
          luasnip.insert_node(1, "table_name"),
          luasnip.text_node('")'),
        }),
      })

      -- Improve completion behavior
      opts.completion = opts.completion or {}
      opts.completion.completeopt = "menu,menuone,noinsert"

      return opts
    end,
  },

  -- Better diagnostic display (like IntelliJ's error highlighting)
  {
    "folke/trouble.nvim",
    opts = {
      use_diagnostic_signs = true,
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
    },
  },
}
