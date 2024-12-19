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

vim.opt.cursorline = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true
vim.wo.signcolumn = "yes"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.keymap.set("n", "<space>bd", "<cmd>bd<CR>")
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")
vim.keymap.set("n", "<space>xx", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")
-- vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<space>w", "<C-w>")
vim.keymap.set("n", "<space>fs", "<cmd>write<CR>")
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")
vim.keymap.set("n", "<M-w>", "<cmd>cclose<CR>")
vim.keymap.set("n", "<M-o>", "<cmd>copen<CR>")
vim.keymap.set({ "n", "t" }, "<M-p>", "<cmd>bprevious<CR>")
vim.keymap.set({ "n", "t" }, "<M-n>", "<cmd>bnext<CR>")
vim.keymap.set({ "n", "t" }, "<M-q>", "<cmd>bdelete!<CR>")

require("config.lazy")

vim.notify = require("fidget.notification").notify
vim.cmd("colorscheme tokyonight")
