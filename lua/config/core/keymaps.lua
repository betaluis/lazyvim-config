local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.keymap.set

-- Leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Save
keymap("n", "<Space>w", ":w<CR>", opts)

-- netrw
keymap("n", "<leader>ee", "<cmd>Ex<CR>", opts)
keymap("n", "<leader>ei", "<cmd>Rex<CR>", opts)

-- Select all
keymap("n", "<C-a>", "gg<S-v>G")

-- Move commands
keymap("v", "J", ":m '>+2<CR>gv=gv")
keymap("v", "K", ":m '<-1<CR>gv=gv")
keymap("n", "J", "mzJ`z")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- Greatest keymap
keymap("x", "<leader>p", '"_dP')

-- Clipboard keymaps
keymap("n", "<leader>y", '"+y')
keymap("v", "<leader>y", '"+y')
keymap("n", "<leader>Y", '"+Y')

keymap("n", "<leader>d", '"_d')
keymap("v", "<leader>d", '"_d')

keymap("n", "Y", "y$", { desc = "Yank to end of line" })
keymap("n", "<leader>V", "v$", { desc = "Select to end of line" })

-- Move selected lines
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- This is going to get me canceled
keymap("i", "ii", "<Esc>")

keymap("n", "Q", "<nop>")
keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
keymap("n", "<leader>f", function()
    vim.lsp.buf.format()
end)

keymap("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap("n", "<C-y>", "<cmd>cprev<CR>zz")
keymap("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap("n", "<leader>y", "<cmd>cprev<CR>zz")

keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Copilot
keymap("n", "<C-g>", "copilot#Accept('<CR>')", { silent = true })

-- Disable copilot
keymap("n", "<C-g>", ":Copilot disable<CR>", { silent = true })
