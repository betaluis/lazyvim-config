local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.keymap.set

local function insert_text_at_cursor(text)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()
    local new_line = line:sub(1, col) .. text .. line:sub(col + 1)
    vim.api.nvim_buf_set_lines(0, row - 1, row, false, { new_line })
    vim.api.nvim_win_set_cursor(0, { row, col + #text })
end

-- Leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Save
keymap("n", "<Space>w", ":w<CR>", opts)

-- netrw workflow
keymap("n", "<leader>ee", "<cmd>Ex<CR>", opts)
keymap("n", "<leader>ei", "<cmd>Vex<CR>", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

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
keymap("i", "jj", "<Esc>")

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

-- Date/time insert
keymap("n", "<leader>dd", function()
    insert_text_at_cursor(os.date("%Y-%m-%d"))
end, { desc = "Insert date" })

keymap("n", "<leader>dt", function()
    insert_text_at_cursor(os.date("%Y-%m-%d %H:%M"))
end, { desc = "Insert datetime" })

vim.api.nvim_create_user_command("InsertDate", function()
    insert_text_at_cursor(os.date("%Y-%m-%d"))
end, { desc = "Insert current date" })

vim.api.nvim_create_user_command("InsertDateTime", function()
    insert_text_at_cursor(os.date("%Y-%m-%d %H:%M"))
end, { desc = "Insert current datetime" })

-- File path helpers
keymap("n", "<leader>fp", function()
    local path = vim.fn.expand("%:p")
    if path == "" then
        vim.notify("No file path", vim.log.levels.WARN)
        return
    end

    vim.fn.setreg("+", path)
    vim.notify(path)
end, { desc = "Copy full file path" })

-- Copilot
keymap("n", "<C-g>", "copilot#Accept('<CR>')", { silent = true })

-- Disable copilot
keymap("n", "<C-g>", ":Copilot disable<CR>", { silent = true })
