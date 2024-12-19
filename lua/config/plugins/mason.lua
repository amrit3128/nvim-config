return {
  {
    "williamboman/mason.nvim",
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
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim",
        "mfussenegger/nvim-lint",
        "mhartington/formatter.nvim",
        -- "neovim/nvim-lspconfig",
      },
    },

    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()

      require("mason-lspconfig").setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {}
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
      vim.keymap.set("n", "<space>cf", function() vim.lsp.buf.format() end)

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          ---@diagnostic disable-next-line: missing-parameter
          if client.supports_method('textDocument/formatting') then
            if vim.bo.filetype == "lua" then
              vim.api.nvim_create_autocmd('BufWritePre', {
                buffer = args.buf,
                callback = function()
                  vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                end,
              })
            end
          end
        end,
      })

      vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
      -- vim.keymap.set("n", "grr", function() vim.lsp.buf.references() end)
      vim.keymap.set("n", "<space>ca", function() vim.lsp.buf.code_action() end)
    end
  },
}
