---@diagnostic disable: unused-local, undefined-global
return {
  {
    "sindrets/winshift.nvim",
    event = "VeryLazy",
    vim.keymap.set("n", "<space>wg", "<cmd>WinShift<CR>", { desc = "Interectively Shift Windows" }),
  },
  {
    "hat0uma/csvview.nvim",
    config = function()
      require("csvview").setup({
        parser = {
          --- The number of lines that the asynchronous parser processes per cycle.
          --- This setting is used to prevent monopolization of the main thread when displaying large files.
          --- If the UI freezes, try reducing this value.
          --- @type integer
          async_chunksize = 50,

          --- The delimiter character
          --- You can specify a string, a table of delimiter characters for each file type, or a function that returns a delimiter character.
          --- e.g:
          ---  delimiter = ","
          ---  delimiter = function(bufnr) return "," end
          ---  delimiter = {
          ---    default = ",",
          ---    ft = {
          ---      tsv = "\t",
          ---    },
          ---  }
          --- @type string | {default: string, ft: table<string,string>} | fun(bufnr:integer): string
          delimiter = {
            default = ",",
            ft = {
              tsv = "\t",
            },
          },

          --- The quote character
          --- If a field is enclosed in this character, it is treated as a single field and the delimiter in it will be ignored.
          --- e.g:
          ---  quote_char= "'"
          --- You can also specify it on the command line.
          --- e.g:
          --- :CsvViewEnable quote_char='
          --- @type string
          quote_char = '"',

          --- The comment prefix characters
          --- If the line starts with one of these characters, it is treated as a comment.
          --- Comment lines are not displayed in tabular format.
          --- You can also specify it on the command line.
          --- e.g:
          --- :CsvViewEnable comment=#
          --- @type string[]
          comments = {
            -- "#",
            -- "--",
            -- "//",
          },
        },
        view = {
          --- minimum width of a column
          --- @type integer
          min_column_width = 5,

          --- spacing between columns
          --- @type integer
          spacing = 2,

          --- The display method of the delimiter
          --- "highlight" highlights the delimiter
          --- "border" displays the delimiter with `│`
          --- see `Features` section of the README.
          ---@type "highlight" | "border"
          display_mode = "highlight",
        },
      })
    end,
  },
  {
    {
      "j-hui/fidget.nvim",
      lazy = false,
      enabled = true,
      config = function()
        vim.notify = require("fidget.notification").notify
      end,

      opts = {
        notification = {
          history_size = 128, -- Number of removed messages to retain in history
          override_vim_notify = true, -- Automatically override vim.notify() with Fidget
        },
      },
    },
  },
  {
    "S1M0N38/love2d.nvim",
    event = "VeryLazy",
    cmd = "LoveRun",
    opts = {},
    keys = {
      { "<leader>v", ft = "lua", desc = "LÖVE" },
      { "<leader>vv", "<cmd>LoveRun<cr>", ft = "lua", desc = "Run LÖVE" },
      { "<leader>vs", "<cmd>LoveStop<cr>", ft = "lua", desc = "Stop LÖVE" },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    -- enabled = false,
    event = "FileType markdown",
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },   -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@diagnostic disable-next-line: undefined-doc-name
    ---@type render.md.UserConfig
    opts = {},
    config = function()
      require("render-markdown").setup({
        -- Whether Markdown should be rendered by default or not
        enabled = true,
        -- Vim modes that will show a rendered view of the markdown file, :h mode(), for
        -- all enabled components. Individual components can be enabled for other modes.
        -- Remaining modes will be unaffected by this plugin.
        render_modes = { "n", "c", "t", "i" },
        -- Maximum file size (in MB) that this plugin will attempt to render
        -- Any file larger than this will effectively be ignored
        max_file_size = 10.0,
        -- Milliseconds that must pass before updating marks, updates occur
        -- within the context of the visible window, not the entire buffer
        debounce = 100,
        -- Pre configured settings that will attempt to mimic various target
        -- user experiences. Any user provided settings will take precedence.
        --  obsidian: mimic Obsidian UI
        --  lazy:     will attempt to stay up to date with LazyVim configuration
        --  none:     does nothing
        preset = "none",
        -- The level of logs to write to file: vim.fn.stdpath('state') .. '/render-markdown.log'
        -- Only intended to be used for plugin development / debugging
        log_level = "error",
        -- Print runtime of main update method
        -- Only intended to be used for plugin development / debugging
        log_runtime = false,
        -- Filetypes this plugin will run on
        file_types = { "markdown" },
        -- Out of the box language injections for known filetypes that allow markdown to be
        -- interpreted in specified locations, see :h treesitter-language-injections
        -- Set enabled to false in order to disable
        injections = {
          gitcommit = {
            enabled = true,
            query = [[
                    ((message) @injection.content
                        (#set! injection.combined)
                        (#set! injection.include-children)
                        (#set! injection.language "markdown"))
                ]],
          },
        },
        anti_conceal = {
          -- This enables hiding any added text on the line the cursor is on
          enabled = true,
          -- Which elements to always show, ignoring anti conceal behavior. Values can either be booleans
          -- to fix the behavior or string lists representing modes where anti conceal behavior will be
          -- ignored. Possible keys are:
          --  head_icon, head_background, head_border, code_language, code_background, code_border
          --  dash, bullet, check_icon, check_scope, quote, table_border, callout, link, sign
          ignore = {
            code_background = true,
            sign = true,
          },
          -- Number of lines above cursor to show
          above = 0,
          -- Number of lines below cursor to show
          below = 0,
        },
        padding = {
          -- Highlight to use when adding whitespace, should match background
          highlight = "Normal",
        },
        latex = {
          -- Whether LaTeX should be rendered, mainly used for health check
          enabled = true,
          -- Additional modes to render LaTeX
          render_modes = false,
          -- Executable used to convert latex formula to rendered unicode
          converter = "latex2text",
          -- Highlight for LaTeX blocks
          highlight = "RenderMarkdownMath",
          -- Amount of empty lines above LaTeX blocks
          top_pad = 0,
          -- Amount of empty lines below LaTeX blocks
          bottom_pad = 0,
        },
        on = {
          -- Called when plugin initially attaches to a buffer
          attach = function() end,
          -- Called after plugin renders a buffer
          render = function() end,
        },
        heading = {
          -- Turn on / off heading icon & background rendering
          enabled = true,
          -- Additional modes to render headings
          render_modes = false,
          -- Turn on / off any sign column related rendering
          sign = true,
          -- Replaces '#+' of 'atx_h._marker'
          -- The number of '#' in the heading determines the 'level'
          -- The 'level' is used to index into the list using a cycle
          -- If the value is a function the input is the nesting level of the heading within sections
          icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
          -- Determines how icons fill the available space:
          --  right:   '#'s are concealed and icon is appended to right side
          --  inline:  '#'s are concealed and icon is inlined on left side
          --  overlay: icon is left padded with spaces and inserted on left hiding any additional '#'
          position = "overlay",
          -- Added to the sign column if enabled
          -- The 'level' is used to index into the list using a cycle
          signs = { "󰫎 " },
          -- Width of the heading background:
          --  block: width of the heading text
          --  full:  full width of the window
          -- Can also be a list of the above values in which case the 'level' is used
          -- to index into the list using a clamp
          width = "full",
          -- Amount of margin to add to the left of headings
          -- If a floating point value < 1 is provided it is treated as a percentage of the available window space
          -- Margin available space is computed after accounting for padding
          -- Can also be a list of numbers in which case the 'level' is used to index into the list using a clamp
          left_margin = 0,
          -- Amount of padding to add to the left of headings
          -- If a floating point value < 1 is provided it is treated as a percentage of the available window space
          -- Can also be a list of numbers in which case the 'level' is used to index into the list using a clamp
          left_pad = 0,
          -- Amount of padding to add to the right of headings when width is 'block'
          -- If a floating point value < 1 is provided it is treated as a percentage of the available window space
          -- Can also be a list of numbers in which case the 'level' is used to index into the list using a clamp
          right_pad = 0,
          -- Minimum width to use for headings when width is 'block'
          -- Can also be a list of integers in which case the 'level' is used to index into the list using a clamp
          min_width = 0,
          -- Determines if a border is added above and below headings
          -- Can also be a list of booleans in which case the 'level' is used to index into the list using a clamp
          border = false,
          -- Always use virtual lines for heading borders instead of attempting to use empty lines
          border_virtual = false,
          -- Highlight the start of the border using the foreground highlight
          border_prefix = false,
          -- Used above heading for border
          above = "▄",
          -- Used below heading for border
          below = "▀",
          -- The 'level' is used to index into the list using a clamp
          -- Highlight for the heading icon and extends through the entire line
          backgrounds = {
            "RenderMarkdownH1Bg",
            "RenderMarkdownH2Bg",
            "RenderMarkdownH3Bg",
            "RenderMarkdownH4Bg",
            "RenderMarkdownH5Bg",
            "RenderMarkdownH6Bg",
          },
          -- The 'level' is used to index into the list using a clamp
          -- Highlight for the heading and sign icons
          foregrounds = {
            "RenderMarkdownH1",
            "RenderMarkdownH2",
            "RenderMarkdownH3",
            "RenderMarkdownH4",
            "RenderMarkdownH5",
            "RenderMarkdownH6",
          },
        },
        paragraph = {
          -- Turn on / off paragraph rendering
          enabled = true,
          -- Additional modes to render paragraphs
          render_modes = false,
          -- Amount of margin to add to the left of paragraphs
          -- If a floating point value < 1 is provided it is treated as a percentage of the available window space
          left_margin = 0,
          -- Minimum width to use for paragraphs
          min_width = 0,
        },
        code = {
          -- Turn on / off code block & inline code rendering
          enabled = true,
          -- Additional modes to render code blocks
          render_modes = false,
          -- Turn on / off any sign column related rendering
          sign = true,
          -- Determines how code blocks & inline code are rendered:
          --  none:     disables all rendering
          --  normal:   adds highlight group to code blocks & inline code, adds padding to code blocks
          --  language: adds language icon to sign column if enabled and icon + name above code blocks
          --  full:     normal + language
          style = "full",
          -- Determines where language icon is rendered:
          --  right: right side of code block
          --  left:  left side of code block
          position = "left",
          -- Amount of padding to add around the language
          -- If a floating point value < 1 is provided it is treated as a percentage of the available window space
          language_pad = 0,
          -- Whether to include the language name next to the icon
          language_name = true,
          -- A list of language names for which background highlighting will be disabled
          -- Likely because that language has background highlights itself
          -- Or a boolean to make behavior apply to all languages
          -- Borders above & below blocks will continue to be rendered
          disable_background = { "diff" },
          -- Width of the code block background:
          --  block: width of the code block
          --  full:  full width of the window
          width = "full",
          -- Amount of margin to add to the left of code blocks
          -- If a floating point value < 1 is provided it is treated as a percentage of the available window space
          -- Margin available space is computed after accounting for padding
          left_margin = 0,
          -- Amount of padding to add to the left of code blocks
          -- If a floating point value < 1 is provided it is treated as a percentage of the available window space
          left_pad = 0,
          -- Amount of padding to add to the right of code blocks when width is 'block'
          -- If a floating point value < 1 is provided it is treated as a percentage of the available window space
          right_pad = 0,
          -- Minimum width to use for code blocks when width is 'block'
          min_width = 0,
          -- Determines how the top / bottom of code block are rendered:
          --  none:  do not render a border
          --  thick: use the same highlight as the code body
          --  thin:  when lines are empty overlay the above & below icons
          border = "thin",
          -- Used above code blocks for thin border
          above = "▄",
          -- Used below code blocks for thin border
          below = "▀",
          -- Highlight for code blocks
          highlight = "RenderMarkdownCode",
          -- Highlight for language, overrides icon provider value
          highlight_language = nil,
          -- Padding to add to the left & right of inline code
          inline_pad = 0,
          -- Highlight for inline code
          highlight_inline = "RenderMarkdownCodeInline",
        },
        dash = {
          -- Turn on / off thematic break rendering
          enabled = true,
          -- Additional modes to render dash
          render_modes = false,
          -- Replaces '---'|'***'|'___'|'* * *' of 'thematic_break'
          -- The icon gets repeated across the window's width
          icon = "─",
          -- Width of the generated line:
          --  <number>: a hard coded width value, if a floating point value < 1 is provided it is
          --            treated as a percentage of the available window space
          --  full:     full width of the window
          width = "full",
          -- Amount of margin to add to the left of dash
          -- If a floating point value < 1 is provided it is treated as a percentage of the available window space
          left_margin = 0,
          -- Highlight for the whole line generated from the icon
          highlight = "RenderMarkdownDash",
        },
        bullet = {
          -- Turn on / off list bullet rendering
          enabled = true,
          -- Additional modes to render list bullets
          render_modes = false,
          -- Replaces '-'|'+'|'*' of 'list_item'
          -- How deeply nested the list is determines the 'level', how far down at that level determines the 'index'
          -- If a function is provided both of these values are passed in using 1 based indexing
          -- If a list is provided we index into it using a cycle based on the level
          -- If the value at that level is also a list we further index into it using a clamp based on the index
          -- If the item is a 'checkbox' a conceal is used to hide the bullet instead
          icons = { "●", "○", "◆", "◇" },
          -- Replaces 'n.'|'n)' of 'list_item'
          -- How deeply nested the list is determines the 'level', how far down at that level determines the 'index'
          -- If a function is provided both of these values are passed in using 1 based indexing
          -- If a list is provided we index into it using a cycle based on the level
          -- If the value at that level is also a list we further index into it using a clamp based on the index
          ordered_icons = function(level, index, value)
            value = vim.trim(value)
            local value_index = tonumber(value:sub(1, #value - 1))
            return string.format("%d.", value_index > 1 and value_index or index)
          end,
          -- Padding to add to the left of bullet point
          left_pad = 0,
          -- Padding to add to the right of bullet point
          right_pad = 0,
          -- Highlight for the bullet icon
          highlight = "RenderMarkdownBullet",
        },
        -- Checkboxes are a special instance of a 'list_item' that start with a 'shortcut_link'
        -- There are two special states for unchecked & checked defined in the markdown grammar
        checkbox = {
          -- Turn on / off checkbox state rendering
          enabled = true,
          -- Additional modes to render checkboxes
          render_modes = false,
          -- Determines how icons fill the available space:
          --  inline:  underlying text is concealed resulting in a left aligned icon
          --  overlay: result is left padded with spaces to hide any additional text
          position = "inline",
          unchecked = {
            -- Replaces '[ ]' of 'task_list_marker_unchecked'
            icon = "󰄱 ",
            -- Highlight for the unchecked icon
            highlight = "RenderMarkdownUnchecked",
            -- Highlight for item associated with unchecked checkbox
            scope_highlight = nil,
          },
          checked = {
            -- Replaces '[x]' of 'task_list_marker_checked'
            icon = "󰱒 ",
            -- Highlight for the checked icon
            highlight = "RenderMarkdownChecked",
            -- Highlight for item associated with checked checkbox
            scope_highlight = nil,
          },
          -- Define custom checkbox states, more involved as they are not part of the markdown grammar
          -- As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks
          -- Can specify as many additional states as you like following the 'todo' pattern below
          --   The key in this case 'todo' is for healthcheck and to allow users to change its values
          --   'raw':             Matched against the raw text of a 'shortcut_link'
          --   'rendered':        Replaces the 'raw' value when rendering
          --   'highlight':       Highlight for the 'rendered' icon
          --   'scope_highlight': Highlight for item associated with custom checkbox
          custom = {
            todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo", scope_highlight = nil },
          },
        },
        quote = {
          -- Turn on / off block quote & callout rendering
          enabled = true,
          -- Additional modes to render quotes
          render_modes = false,
          -- Replaces '>' of 'block_quote'
          icon = "▋",
          -- Whether to repeat icon on wrapped lines. Requires neovim >= 0.10. This will obscure text if
          -- not configured correctly with :h 'showbreak', :h 'breakindent' and :h 'breakindentopt'. A
          -- combination of these that is likely to work is showbreak = '  ' (2 spaces), breakindent = true,
          -- breakindentopt = '' (empty string). These values are not validated by this plugin. If you want
          -- to avoid adding these to your main configuration then set them in win_options for this plugin.
          repeat_linebreak = false,
          -- Highlight for the quote icon
          highlight = "RenderMarkdownQuote",
        },
        pipe_table = {
          -- Turn on / off pipe table rendering
          enabled = true,
          -- Additional modes to render pipe tables
          render_modes = false,
          -- Pre configured settings largely for setting table border easier
          --  heavy:  use thicker border characters
          --  double: use double line border characters
          --  round:  use round border corners
          --  none:   does nothing
          preset = "none",
          -- Determines how the table as a whole is rendered:
          --  none:   disables all rendering
          --  normal: applies the 'cell' style rendering to each row of the table
          --  full:   normal + a top & bottom line that fill out the table when lengths match
          style = "full",
          -- Determines how individual cells of a table are rendered:
          --  overlay: writes completely over the table, removing conceal behavior and highlights
          --  raw:     replaces only the '|' characters in each row, leaving the cells unmodified
          --  padded:  raw + cells are padded to maximum visual width for each column
          --  trimmed: padded except empty space is subtracted from visual width calculation
          cell = "padded",
          -- Amount of space to put between cell contents and border
          padding = 1,
          -- Minimum column width to use for padded or trimmed cell
          min_width = 0,
            -- Characters used to replace table border
            -- Correspond to top(3), delimiter(3), bottom(3), vertical, & horizontal
            -- stylua: ignore
            border = {
                '┌', '┬', '┐',
                '├', '┼', '┤',
                '└', '┴', '┘',
                '│', '─',
            },
          -- Gets placed in delimiter row for each column, position is based on alignment
          alignment_indicator = "━",
          -- Highlight for table heading, delimiter, and the line above
          head = "RenderMarkdownTableHead",
          -- Highlight for everything else, main table rows and the line below
          row = "RenderMarkdownTableRow",
          -- Highlight for inline padding used to add back concealed space
          filler = "RenderMarkdownTableFill",
        },
        -- Callouts are a special instance of a 'block_quote' that start with a 'shortcut_link'
        -- Can specify as many additional values as you like following the pattern from any below, such as 'note'
        --   The key in this case 'note' is for healthcheck and to allow users to change its values
        --   'raw':        Matched against the raw text of a 'shortcut_link', case insensitive
        --   'rendered':   Replaces the 'raw' value when rendering
        --   'highlight':  Highlight for the 'rendered' text and quote markers
        --   'quote_icon': Optional override for quote.icon value for individual callout
        callout = {
          note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
          tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "RenderMarkdownSuccess" },
          important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint" },
          warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "RenderMarkdownWarn" },
          caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution", highlight = "RenderMarkdownError" },
          -- Obsidian: https://help.obsidian.md/Editing+and+formatting/Callouts
          abstract = { raw = "[!ABSTRACT]", rendered = "󰨸 Abstract", highlight = "RenderMarkdownInfo" },
          summary = { raw = "[!SUMMARY]", rendered = "󰨸 Summary", highlight = "RenderMarkdownInfo" },
          tldr = { raw = "[!TLDR]", rendered = "󰨸 Tldr", highlight = "RenderMarkdownInfo" },
          info = { raw = "[!INFO]", rendered = "󰋽 Info", highlight = "RenderMarkdownInfo" },
          todo = { raw = "[!TODO]", rendered = "󰗡 Todo", highlight = "RenderMarkdownInfo" },
          hint = { raw = "[!HINT]", rendered = "󰌶 Hint", highlight = "RenderMarkdownSuccess" },
          success = { raw = "[!SUCCESS]", rendered = "󰄬 Success", highlight = "RenderMarkdownSuccess" },
          check = { raw = "[!CHECK]", rendered = "󰄬 Check", highlight = "RenderMarkdownSuccess" },
          done = { raw = "[!DONE]", rendered = "󰄬 Done", highlight = "RenderMarkdownSuccess" },
          question = { raw = "[!QUESTION]", rendered = "󰘥 Question", highlight = "RenderMarkdownWarn" },
          help = { raw = "[!HELP]", rendered = "󰘥 Help", highlight = "RenderMarkdownWarn" },
          faq = { raw = "[!FAQ]", rendered = "󰘥 Faq", highlight = "RenderMarkdownWarn" },
          attention = { raw = "[!ATTENTION]", rendered = "󰀪 Attention", highlight = "RenderMarkdownWarn" },
          failure = { raw = "[!FAILURE]", rendered = "󰅖 Failure", highlight = "RenderMarkdownError" },
          fail = { raw = "[!FAIL]", rendered = "󰅖 Fail", highlight = "RenderMarkdownError" },
          missing = { raw = "[!MISSING]", rendered = "󰅖 Missing", highlight = "RenderMarkdownError" },
          danger = { raw = "[!DANGER]", rendered = "󱐌 Danger", highlight = "RenderMarkdownError" },
          error = { raw = "[!ERROR]", rendered = "󱐌 Error", highlight = "RenderMarkdownError" },
          bug = { raw = "[!BUG]", rendered = "󰨰 Bug", highlight = "RenderMarkdownError" },
          example = { raw = "[!EXAMPLE]", rendered = "󰉹 Example", highlight = "RenderMarkdownHint" },
          quote = { raw = "[!QUOTE]", rendered = "󱆨 Quote", highlight = "RenderMarkdownQuote" },
          cite = { raw = "[!CITE]", rendered = "󱆨 Cite", highlight = "RenderMarkdownQuote" },
        },
        link = {
          -- Turn on / off inline link icon rendering
          enabled = true,
          -- Additional modes to render links
          render_modes = false,
          -- How to handle footnote links, start with a '^'
          footnote = {
            -- Replace value with superscript equivalent
            superscript = true,
            -- Added before link content when converting to superscript
            prefix = "",
            -- Added after link content when converting to superscript
            suffix = "",
          },
          -- Inlined with 'image' elements
          image = "󰥶 ",
          -- Inlined with 'email_autolink' elements
          email = "󰀓 ",
          -- Fallback icon for 'inline_link' and 'uri_autolink' elements
          hyperlink = "󰌹 ",
          -- Applies to the inlined icon as a fallback
          highlight = "RenderMarkdownLink",
          -- Applies to WikiLink elements
          wiki = { icon = "󱗖 ", highlight = "RenderMarkdownWikiLink" },
          -- Define custom destination patterns so icons can quickly inform you of what a link
          -- contains. Applies to 'inline_link', 'uri_autolink', and wikilink nodes. When multiple
          -- patterns match a link the one with the longer pattern is used.
          -- Can specify as many additional values as you like following the 'web' pattern below
          --   The key in this case 'web' is for healthcheck and to allow users to change its values
          --   'pattern':   Matched against the destination text see :h lua-pattern
          --   'icon':      Gets inlined before the link text
          --   'highlight': Optional highlight for the 'icon', uses fallback highlight if not provided
          custom = {
            web = { pattern = "^http", icon = "󰖟 " },
            youtube = { pattern = "youtube%.com", icon = "󰗃 " },
            github = { pattern = "github%.com", icon = "󰊤 " },
            neovim = { pattern = "neovim%.io", icon = " " },
            stackoverflow = { pattern = "stackoverflow%.com", icon = "󰓌 " },
            discord = { pattern = "discord%.com", icon = "󰙯 " },
            reddit = { pattern = "reddit%.com", icon = "󰑍 " },
          },
        },
        sign = {
          -- Turn on / off sign rendering
          enabled = true,
          -- Applies to background of sign text
          highlight = "RenderMarkdownSign",
        },
        -- Mimics Obsidian inline highlights when content is surrounded by double equals
        -- The equals on both ends are concealed and the inner content is highlighted
        inline_highlight = {
          -- Turn on / off inline highlight rendering
          enabled = true,
          -- Additional modes to render inline highlights
          render_modes = false,
          -- Applies to background of surrounded text
          highlight = "RenderMarkdownInlineHighlight",
        },
        -- Mimic org-indent-mode behavior by indenting everything under a heading based on the
        -- level of the heading. Indenting starts from level 2 headings onward.
        indent = {
          -- Turn on / off org-indent-mode
          enabled = false,
          -- Additional modes to render indents
          render_modes = false,
          -- Amount of additional padding added for each heading level
          per_level = 2,
          -- Heading levels <= this value will not be indented
          -- Use 0 to begin indenting from the very first level
          skip_level = 1,
          -- Do not indent heading titles, only the body
          skip_heading = false,
        },
        html = {
          -- Turn on / off all HTML rendering
          enabled = true,
          -- Additional modes to render HTML
          render_modes = false,
          comment = {
            -- Turn on / off HTML comment concealing
            conceal = true,
            -- Optional text to inline before the concealed comment
            text = nil,
            -- Highlight for the inlined text
            highlight = "RenderMarkdownHtmlComment",
          },
        },
        -- Window options to use that change between rendered and raw view
        win_options = {
          -- See :h 'conceallevel'
          conceallevel = {
            -- Used when not being rendered, get user setting
            default = vim.api.nvim_get_option_value("conceallevel", {}),
            -- Used when being rendered, concealed text is completely hidden
            rendered = 3,
          },
          -- See :h 'concealcursor'
          concealcursor = {
            -- Used when not being rendered, get user setting
            default = vim.api.nvim_get_option_value("concealcursor", {}),
            -- Used when being rendered, disable concealing text in all modes
            rendered = "",
          },
        },
        -- More granular configuration mechanism, allows different aspects of buffers
        -- to have their own behavior. Values default to the top level configuration
        -- if no override is provided. Supports the following fields:
        --   enabled, max_file_size, debounce, render_modes, anti_conceal, padding,
        --   heading, paragraph, code, dash, bullet, checkbox, quote, pipe_table,
        --   callout, link, sign, indent, latex, html, win_options
        overrides = {
          -- Override for different buflisted values, see :h 'buflisted'
          buflisted = {},
          -- Override for different buftype values, see :h 'buftype'
          buftype = {
            nofile = {
              padding = { highlight = "NormalFloat" },
              sign = { enabled = false },
            },
          },
          -- Override for different filetype values, see :h 'filetype'
          filetype = {},
        },
        -- Mapping from treesitter language to user defined handlers
        -- See 'Custom Handlers' document for more info
        custom_handlers = {},
      })
    end,
  },
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    config = function()
      -- Setup orgmode
      require("orgmode").setup({
        org_agenda_files = "~/Learn/**/*",
        org_default_notes_file = "~/notes/Learn.org",
      })
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
  },
  {
    "vim-scripts/ReplaceWithRegister",
    event = "VeryLazy",
    dependencies = {
      "vim-scripts/ReplaceWithSameIndentRegister",
    },
  },
  {
    "tpope/vim-sensible",
    event = "VeryLazy",
  },
  {
    "leath-dub/snipe.nvim",
    event = "VeryLazy",
    keys = {
      {
        "gb",
        function()
          require("snipe").open_buffer_menu()
        end,
        desc = "Open Snipe buffer menu",
      },
    },
    opts = {},
  },
  {
    "abecodes/tabout.nvim",
    ---@diagnostic disable-next-line: duplicate-index
    -- event = "VeryLazy",
    lazy = false,
    config = function()
      require("tabout").setup({
        tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = "<C-d>", -- reverse shift default action,
        enable_backwards = true, -- well ...
        completion = false, -- if the tabkey is used in a completion pum
        tabouts = {
          { open = "'", close = "'" },
          { open = "<", close = ">" },
          { open = '"', close = '"' },
          { open = "`", close = "`" },
          { open = "(", close = ")" },
          { open = "[", close = "]" },
          { open = "{", close = "}" },
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {}, -- tabout will ignore these filetypes
      })
    end,
    dependencies = { -- These are optional
      "nvim-treesitter/nvim-treesitter",
      "L3MON4D3/LuaSnip",
      "hrsh7th/nvim-cmp",
    },
    opt = true, -- Set this to true if the plugin is optional
    ---@diagnostic disable-next-line: duplicate-index
    event = "InsertCharPre", -- Set the event to 'InsertCharPre' for better compatibility
    priority = 1000,
  },
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      -- Disable default tab keybinding in LuaSnip
      return {}
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    -- enabled = false,
    version = "*",
    -- config = true,
    config = function()
      require("toggleterm").setup({
        direction = "float",
      })
    end,

    -- vim.keymap.set({ "n", "i", "v", "t" }, "<C-/>", "<cmd>ToggleTerm direction=float<CR>"),
    vim.keymap.set({ "n", "i", "v", "t" }, "<C-/>", "<cmd>ToggleTerm direction=float<CR>"),
    vim.keymap.set({ "n", "i", "v", "t" }, "<M-z>", "<cmd>ToggleTerm size=20 direction=horizontal<CR>"),
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
  {
    "kevinhwang91/nvim-ufo",
    vent = "VeryLazy",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    config = function()
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
      })
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
    end,
  },
  {
    event = "VeryLazy",
    "tpope/vim-unimpaired",
  },
  {
    "folke/which-key.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = {
      ---@type false | "classic" | "modern" | "helix"
      preset = "modern",
      -- Delay before showing the popup. Can be a number or a function that returns a number.
      ---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
      delay = function(ctx)
        return ctx.plugin and 0 or 200
      end,
      ---@param mapping wk.Mapping
      filter = function(mapping)
        -- example to exclude mappings without a description
        -- return mapping.desc and mapping.desc ~= ""
        return true
      end,
      --- You can add any mappings here, or use `require('which-key').add()` later
      ---@type wk.Spec
      spec = {},
      -- show a warning when issues were detected with your mappings
      notify = true,
      -- Which-key automatically sets up triggers for your mappings.
      -- But you can disable this and setup the triggers manually.
      -- Check the docs for more info.
      ---@type wk.Spec
      triggers = {
        { "<auto>", mode = "nxso" },
      },
      -- Start hidden and wait for a key to be pressed before showing the popup
      -- Only used by enabled xo mapping modes.
      ---@param ctx { mode: string, operator: string }
      defer = function(ctx)
        return ctx.mode == "V" or ctx.mode == "<C-V>"
      end,
      plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        spelling = {
          enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- how many suggestions should be shown in the list?
        },
        presets = {
          operators = true, -- adds help for operators like d, y, ...
          motions = true, -- adds help for motions
          text_objects = true, -- help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g
        },
      },
      win = {
        -- don't allow the popup to overlap with the cursor
        no_overlap = true,
        -- width = 1,
        -- height = { min = 4, max = 25 },
        -- col = 0,
        -- row = math.huge,
        -- border = "none",
        padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
        title = true,
        title_pos = "center",
        zindex = 1000,
        -- Additional vim.wo and vim.bo options
        bo = {},
        wo = {
          -- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
        },
      },
      layout = {
        width = { min = 20 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
      },
      keys = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
      },
      ---@diagnostic disable-next-line: undefined-doc-name
      ---@type (string|wk.Sorter)[]
      --- Mappings are sorted using configured sorters and natural sort of the keys
      --- Available sorters:
      --- * local: buffer-local mappings first
      --- * order: order of the items (Used by plugins like marks / registers)
      --- * group: groups last
      --- * alphanum: alpha-numerical first
      --- * mod: special modifier keys last
      --- * manual: the order the mappings were added
      --- * case: lower-case first
      sort = { "local", "order", "group", "alphanum", "mod" },
      ---@type number|fun(node: wk.Node):boolean?
      expand = 0, -- expand groups when <= n mappings
      -- expand = function(node)
      --   return not node.desc -- expand all nodes without a description
      -- end,
      -- Functions/Lua Patterns for formatting the labels
      ---@type table<string, ({[1]:string, [2]:string}|fun(str:string):string)[]>
      replace = {
        key = {
          function(key)
            return require("which-key.view").format(key)
          end,
          -- { "<Space>", "SPC" },
        },
        desc = {
          { "<Plug>%(?(.*)%)?", "%1" },
          { "^%+", "" },
          { "<[cC]md>", "" },
          { "<[cC][rR]>", "" },
          { "<[sS]ilent>", "" },
          { "^lua%s+", "" },
          { "^call%s+", "" },
          { "^:%s*", "" },
        },
      },
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
        ellipsis = "…",
        -- set to false to disable all mapping icons,
        -- both those explicitly added in a mapping
        -- and those from rules
        mappings = true,
        --- See `lua/which-key/icons.lua` for more details
        --- Set to `false` to disable keymap icons from rules
        ---@type wk.IconRule[]|false
        rules = {},
        -- use the highlights from mini.icons
        -- When `false`, it will use `WhichKeyIcon` instead
        colors = true,
        -- used by key format
        keys = {
          Up = " ",
          Down = " ",
          Left = " ",
          Right = " ",
          C = "󰘴 ",
          M = "󰘵 ",
          D = "󰘳 ",
          S = "󰘶 ",
          CR = "󰌑 ",
          Esc = "󱊷 ",
          ScrollWheelDown = "󱕐 ",
          ScrollWheelUp = "󱕑 ",
          NL = "󰌑 ",
          BS = "󰁮",
          Space = "󱁐 ",
          Tab = "󰌒 ",
          F1 = "󱊫",
          F2 = "󱊬",
          F3 = "󱊭",
          F4 = "󱊮",
          F5 = "󱊯",
          F6 = "󱊰",
          F7 = "󱊱",
          F8 = "󱊲",
          F9 = "󱊳",
          F10 = "󱊴",
          F11 = "󱊵",
          F12 = "󱊶",
        },
      },
      show_help = true, -- show a help message in the command line for using WhichKey
      show_keys = true, -- show the currently pressed key and its label as a message in the command line
      -- disable WhichKey for certain buf types and file types.
      disable = {
        ft = {},
        bt = {},
      },
      debug = false, -- enable wk.log in the current directory
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "nanozuki/tabby.nvim",
    event = "VimEnter", -- if you want lazy load, see below
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      local theme = {
        fill = "TabLineFill",
        -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
        head = "TabLine",
        current_tab = "TabLineSel",
        tab = "TabLine",
        win = "TabLine",
        tail = "TabLine",
      }
      require("tabby").setup({
        line = function(line)
          return {
            {
              { "  ", hl = theme.head },
              line.sep("", theme.head, theme.fill),
            },
            line.tabs().foreach(function(tab)
              local hl = tab.is_current() and theme.current_tab or theme.tab
              return {
                line.sep("", hl, theme.fill),
                tab.is_current() and "" or "󰆣",
                tab.number(),
                tab.name(),
                tab.close_btn(""),
                line.sep("", hl, theme.fill),
                hl = hl,
                margin = " ",
              }
            end),
            line.spacer(),
            line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
              return {
                line.sep("", theme.win, theme.fill),
                win.is_current() and "" or "",
                win.buf_name(),
                line.sep("", theme.win, theme.fill),
                hl = theme.win,
                margin = " ",
              }
            end),
            {
              line.sep("", theme.tail, theme.fill),
              { "  ", hl = theme.tail },
            },
            hl = theme.fill,
          }
        end,
        -- option = {}, -- setup modules' option,
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true, -- show icons in the signs column
      sign_priority = 8, -- sign priority
      -- keywords recognized as todo comments
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      gui_style = {
        fg = "NONE", -- The gui style to use for the fg highlight group.
        bg = "BOLD", -- The gui style to use for the bg highlight group.
      },
      merge_keywords = true, -- when true, custom keywords will be merged with the defaults
      -- highlighting of the line containing the todo comment
      -- * before: highlights before the keyword (typically comment characters)
      -- * keyword: highlights of the keyword
      -- * after: highlights after the keyword (todo text)
      highlight = {
        multiline = true, -- enable multine todo comments
        multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
        before = "", -- "fg" or "bg" or empty
        keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "fg", -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
        comments_only = true, -- uses treesitter to match keywords in comments only
        max_line_len = 400, -- ignore lines longer than this
        exclude = {}, -- list of file types to exclude highlighting
      },
      -- list of named colors where we try to extract the guifg from the
      -- list of highlight groups or use the hex color if hl not found as a fallback
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = { "DiagnosticInfo", "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" },
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
        -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
      },
    },
  },
  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },
}
