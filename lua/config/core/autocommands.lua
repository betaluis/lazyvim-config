local autocommand = vim.api.nvim_create_autocmd
local keymap = vim.keymap.set

-- Use 'q' to quit from common plugins
autocommand({ 'Filetype' }, {
    pattern = { 'qf', 'help', 'man', 'lspinfo', 'spectre_panel', 'lir' },
    callback = function()
        vim.cmd [[
            noremap <silent> <buffer> q :close<CR>
            set nobuflisted
        ]]
    end,
})

autocommand({ "Filetype" }, {
    pattern = { "netrw" },
    callback = function()
        vim.cmd [[
            nmap <buffer> H u
            nmap <buffer> h -^
            nmap <buffer> l <CR>
            nmap <buffer> . gh
            nmap <buffer> P <C-w>z
            setlocal number

        ]]
    end
})

-- Mail
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.txt", "*.md", "mail"},
  command = "setlocal spell",
})

-- Yank Highlight
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end
})
