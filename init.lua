vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.cmd("set wildmenu")
vim.cmd("set path+=**")
vim.cmd("let g:projectile#enable_devicons = 0")
vim.cmd("let g:projectile#search_prog = 'rg'")
vim.cmd("let g:projectile#enabled = 1")

vim.api.nvim_create_augroup("RestoreCursor", {})

vim.api.nvim_create_autocmd("BufRead", {
  group = "RestoreCursor",
  callback = function()
    local ft = vim.bo.filetype
    local line = vim.fn.line("'\"")
    if line >= 1 and line <= vim.fn.line("$") and ft ~= "commit" and not vim.tbl_contains({ "xxd", "gitrebase" }, ft) then
      vim.cmd("normal! g`\"")
    end
  end,
})

vim.opt.cursorline = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true
vim.wo.signcolumn = "yes"
vim.opt.tabstop = 2
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

vim.keymap.set("n", "<space>bd", "<cmd>bd<CR>", { desc = "Delete Buffer" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit Insert Mode in Terminal" })
vim.keymap.set("v", "<space>x", ":lua<CR>", { desc = "Source Line" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Remove Search Highlights" })
vim.keymap.set("n", "<space>w", "<C-w>", { desc = "Switch Windows" })
vim.keymap.set("n", "<space>fs", "<cmd>write<CR>", { desc = "Save File" })
vim.keymap.set({ "n", "t" }, "<M-n>", "<cmd>bnext<CR>", { desc = "Next Buffer" })
vim.keymap.set({ "n", "t" }, "<M-q>", "<cmd>bdelete!<CR>", { desc = "Delete Buffer" })
vim.keymap.set({ "n", "t" }, "<M-p>", "<cmd>bprevious<CR>", { desc = "Previous Buffer" })

require("config.lazy")

vim.cmd("colorscheme tokyonight")
