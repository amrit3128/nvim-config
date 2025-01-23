return {
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
              { path = "${3rd}/luv/library", words = { "vim%.uv" } },
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

                navic.setup({
                  icons = {
                    File = "󰈙 ",
                    Module = " ",
                    Namespace = "󰌗 ",
                    Package = " ",
                    Class = "󰌗 ",
                    Method = "󰆧 ",
                    Property = " ",
                    Field = " ",
                    Constructor = " ",
                    Enum = "󰕘",
                    Interface = "󰕘",
                    Function = "󰊕 ",
                    Variable = "󰆧 ",
                    Constant = "󰏿 ",
                    String = "󰀬 ",
                    Number = "󰎠 ",
                    Boolean = "◩ ",
                    Array = "󰅪 ",
                    Object = "󰅩 ",
                    Key = "󰌋 ",
                    Null = "󰟢 ",
                    EnumMember = " ",
                    Struct = "󰌗 ",
                    Event = " ",
                    Operator = "󰆕 ",
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
                })
                -- require("lspconfig").clangd.setup {
                --   on_attach = function(client, bufnr)
                --     navic.attach(client, bufnr)
                --   end
                -- }
              end,
            },
            "MunifTanjim/nui.nvim",
          },
          opts = { lsp = { auto_attach = true } },
        },
      },

      config = function()
        local capabilities = require("blink.cmp").get_lsp_capabilities()
        require("mason").setup()
        require("mason-lspconfig").setup()

        require("mason-lspconfig").setup_handlers({
          -- The first entry (without a key) will be the default handler
          -- and will be called for each installed server that doesn't have
          -- a dedicated handler.
          function(server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,

              on_attach = function(client, bufnr)
                if client.server_capabilities.documet_Symbol_Provider then
                  require("nvim-navic").attach(client, bufnr)
                end
              end,
            })
          end,
          -- Next, you can provide a dedicated handler for specific servers.
          -- For example, a handler override for the `rust_analyzer`:
          -- ["rust_analyzer"] = function ()
          --   require("rust-tools").setup {}
          -- end
        })
        -- After setting up mason-lspconfig you may set up servers via lspconfig
        -- require("lspconfig").lua_ls.setup {}
        -- require("lspconfig").rust_analyzer.setup {}
        -- ...

        vim.cmd("set tabstop=2")

        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if not client then
              return
            end

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

        -- vim.keymap.set("n", "<space>cf", function()
        --   vim.lsp.buf.format()
        -- end, { desc = "Format Buffer" })

        -- Hyprlang LSP
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
          pattern = { "*.hl", "hypr*.conf" },
          callback = function(event)
            print(string.format("starting hyprls for %s", vim.inspect(event)))
            vim.lsp.start({
              name = "hyprlang",
              cmd = { "hyprls" },
              root_dir = vim.fn.getcwd(),
            })
          end,
        })

        -- vim.keymap.set("n", "<space>cr", function() vim.lsp.buf.rename() end, { desc = "Rename with LSP" })
        vim.keymap.set("n", "<leader>i", "<cmd>Navbuddy<Cr>", { desc = "Navbuddy" })
        vim.keymap.set("n", "<leader>cr", live_rename.rename, { desc = "LSP rename" })
        vim.keymap.set("n", "gd", function()
          vim.lsp.buf.definition()
        end, { desc = "Go To Defination" })
        vim.keymap.set("n", "<space>gr", function()
          vim.lsp.buf.references()
        end, { desc = "Go To References" })
        vim.keymap.set("n", "<space>ca", function() vim.lsp.buf.code_action() end, { desc = "Show Code Actions" })
      end,
    },
  },
  {
    "saecki/live-rename.nvim",
    event = "VeryLazy",
    config = function()
      -- default config
      require("live-rename").setup({
        -- Send a `textDocument/prepareRename` request to the server to
        -- determine the word to be renamed, can be slow on some servers.
        -- Otherwise fallback to using `<cword>`.
        prepare_rename = true,
        --- The timeout for the `textDocument/prepareRename` request and final
        --- `textDocument/rename` request when submitting.
        request_timeout = 1500,
        -- Make an initial `textDocument/rename` request to gather other
        -- occurences which are edited and use these ranges to preview.
        -- If disabled only the word under the cursor will have a preview.
        show_other_ocurrences = true,
        -- Try to infer patterns from the initial `textDocument/rename` request
        -- and use these to show hopefully better edit previews.
        use_patterns = true,
        keys = {
          submit = {
            { "n", "<cr>" },
            { "v", "<cr>" },
            { "i", "<cr>" },
          },
          cancel = {
            { "n", "<esc>" },
            { "n", "q" },
          },
        },
        hl = {
          current = "CurSearch",
          others = "Search",
        },
      })
    end,
  },
  {
    "Chaitanyabsprip/fastaction.nvim",
    enabled = false,
    ---@type FastActionConfig
    opts = {},
    -- vim.keymap.set(
    --   { "n", "x" },
    --   "<leader>ca",
    --   '<cmd>lua require("fastaction").code_action()<CR>',
    --   ---@diagnostic disable-next-line: undefined-global
    --   { buffer = bufnr }
    -- ),
  },
  {
    "SmiteshP/nvim-navbuddy",
    event = "VeryLazy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "numToStr/Comment.nvim", -- Optional
      "nvim-telescope/telescope.nvim", -- Optional
    },
  },
  {
    "aznhe21/actions-preview.nvim",
    event = "VeryLazy",
    config = function()
      vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)
      local hl = require("actions-preview.highlight")
      require("actions-preview").setup({
        highlight_command = {
          -- Highlight diff using delta: https://github.com/dandavison/delta
          -- The argument is optional, in which case "delta" is assumed to be
          -- specified.
          hl.delta("usr/bin/delta"),
          -- You may need to specify "--no-gitconfig" since it is dependent on
          -- the gitconfig of the project by default.
          -- hl.delta("delta --no-gitconfig --side-by-side"),

          -- Highlight diff using diff-so-fancy: https://github.com/so-fancy/diff-so-fancy
          -- The arguments are optional, in which case ("diff-so-fancy", "less -R")
          -- is assumed to be specified. The existence of less is optional.
          hl.diff_so_fancy("/usr/bin/delta"),

          -- Highlight diff using diff-highlight included in git-contrib.
          -- The arguments are optional; the first argument is assumed to be
          -- "diff-highlight" and the second argument is assumed to be
          -- `{ colordiff = "colordiff", pager = "less -R" }`. The existence of
          -- colordiff and less is optional.
          hl.diff_highlight("/usr/bin/delta", { colordiff = "path/to/colordiff" }),

          -- And, you can use any command to highlight diff.
          -- Define the pipeline by `hl.commands`.
          hl.commands({
            { cmd = "/usr/bin/delta" },
            -- `optional` can be used to define that the command is optional.
            { cmd = "/usr/bin/delta", optional = true },
          }),
          -- If you use optional `less -R` (or similar command), you can also use `hl.with_pager`.
          hl.with_pager("/usr/bin/delta"),
          -- hl.with_pager("command-to-diff-highlight", "custom-pager"),
        },
      })
    end,
  },
}
