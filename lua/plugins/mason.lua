return
{
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library",   words = { "vim%.uv" } },
            { path = "${3rd}/love2d/library" },
          },
        },
      },
      {
        "mfussenegger/nvim-dap",
        "saghen/blink.cmp",
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim",
        "mfussenegger/nvim-lint",
        "mhartington/formatter.nvim",
        -- "neovim/nvim-lspconfig",
      },
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          {
            "SmiteshP/nvim-navic",

            config = function()
              local navic = require("nvim-navic")


              navic.setup {
                icons = {
                  File          = "󰈙 ",
                  Module        = " ",
                  Namespace     = "󰌗 ",
                  Package       = " ",
                  Class         = "󰌗 ",
                  Method        = "󰆧 ",
                  Property      = " ",
                  Field         = " ",
                  Constructor   = " ",
                  Enum          = "󰕘",
                  Interface     = "󰕘",
                  Function      = "󰊕 ",
                  Variable      = "󰆧 ",
                  Constant      = "󰏿 ",
                  String        = "󰀬 ",
                  Number        = "󰎠 ",
                  Boolean       = "◩ ",
                  Array         = "󰅪 ",
                  Object        = "󰅩 ",
                  Key           = "󰌋 ",
                  Null          = "󰟢 ",
                  EnumMember    = " ",
                  Struct        = "󰌗 ",
                  Event         = " ",
                  Operator      = "󰆕 ",
                  TypeParameter = "󰊄 ",
                },
                lsp = {
                  auto_attach = false,
                  preference = nil,
                },
                highlight = false,
                separator = " > ",
                depth_limit = 0,
                depth_limit_indicator = "..",
                safe_output = true,
                lazy_update_context = false,
                click = false,
                format_text = function(text)
                  return text
                end,
              }
              -- require("lspconfig").clangd.setup {
              --   on_attach = function(client, bufnr)
              --     navic.attach(client, bufnr)
              --   end
              -- }
            end

          },
          "MunifTanjim/nui.nvim"
        },
        opts = { lsp = { auto_attach = true } }
      },
    },

    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      require("mason").setup()
      require("mason-lspconfig").setup()

      require("mason-lspconfig").setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities,

            on_attach = function(client, bufnr)
              if client.server_capabilities.documet_Symbol_Provider then
                require("nvim-navic").attach(client, bufnr)
              end
            end
          }
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        -- ["rust_analyzer"] = function ()
        --   require("rust-tools").setup {}
        -- end
      }
      -- After setting up mason-lspconfig you may set up servers via lspconfig
      -- require("lspconfig").lua_ls.setup {}
      -- require("lspconfig").rust_analyzer.setup {}
      -- ...

      vim.cmd("set tabstop=2")

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          ---@diagnostic disable-next-line: missing-parameter
          -- if client.supports_method('textDocument/formatting') then
          --   if vim.bo.filetype == "lua" then
          --     vim.api.nvim_create_autocmd('BufWritePre', {
          --       buffer = args.buf,
          --       callback = function()
          --         vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
          --       end,
          --     })
          --   end
          -- if vim.bo.filetype == "nix" then
          --   vim.api.nvim_create_autocmd('BufWritePre', {
          --     buffer = args.buf,
          --     callback = function()
          --       vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
          --     end,
          --   })
          -- end
          -- end
        end,
      })

      local live_rename = require("live-rename")

      vim.keymap.set("n", "<space>cf", function() vim.lsp.buf.format() end, { desc = "Format Buffer" })
      -- vim.keymap.set("n", "<space>cr", function() vim.lsp.buf.rename() end, { desc = "Rename with LSP" })
      vim.keymap.set("n", "<leader>ci", "<cmd>Navbuddy<Cr>", { desc = "Navbuddy" })
      vim.keymap.set("n", "<leader>cr", live_rename.rename, { desc = "LSP rename" })
      vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { desc = "Go To Defination" })
      vim.keymap.set("n", "grr", function() vim.lsp.buf.references() end, { desc = "Go To References" })
      -- vim.keymap.set("n", "<space>ca", function() vim.lsp.buf.code_action() end, { desc = "Show Code Actions" })
    end
  },
}
