local autocommand = vim.api.nvim_create_autocmd
local keymap = vim.keymap.set

local function netrw_h()
	-- In tree view, close/squeeze the directory containing the cursor instead of
	-- changing the root to the parent directory. In other list styles, keep the
	-- previous "go up one directory" behavior.
	if vim.w.netrw_liststyle == 3 then
		local plug = vim.api.nvim_replace_termcodes("<Plug>NetrwTreeSqueeze", true, false, true)
		vim.api.nvim_feedkeys(plug, "m", false)
	else
		local keys = vim.api.nvim_replace_termcodes("-^", true, false, true)
		vim.api.nvim_feedkeys(keys, "m", false)
	end
end

-- Use 'q' to quit from common plugins
autocommand({ "Filetype" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
	callback = function()
		vim.cmd([[
            noremap <silent> <buffer> q :close<CR>
            set nobuflisted
        ]])
	end,
})

autocommand({ "Filetype" }, {
	pattern = { "netrw" },
	callback = function()
		keymap("n", "H", "u", { buffer = true, remap = true, silent = true })
		keymap("n", "h", netrw_h, { buffer = true, silent = true, desc = "Close tree dir or go up" })
		keymap("n", "l", "<CR>", { buffer = true, remap = true, silent = true })
		keymap("n", ".", "gh", { buffer = true, remap = true, silent = true })
		keymap("n", "P", "<C-w>z", { buffer = true, remap = true, silent = true })
		vim.opt_local.number = true
	end,
})

-- Mail
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.txt", "*.md", "mail" },
	command = "setlocal spell",
})

-- Yank Highlight
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("Filetype", {
	pattern = "netrw",
	callback = function()
		vim.opt_local.relativenumber = true
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		require("config.core.markdown").setup()
	end,
})
