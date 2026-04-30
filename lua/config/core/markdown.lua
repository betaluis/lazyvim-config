vim.opt_local.autoindent = true
vim.opt_local.formatoptions = "tcqlnr" -- 'r' for auto-continuing lists, 'n' for numbered lists
vim.opt_local.comments = "fb:*,fb:-,fb:+,n:>" -- Recognize Markdown list markers
vim.opt_local.commentstring = "<!-- %s -->" -- Markdown comment string
vim.opt_local.shiftwidth = 2 -- Indentation width
vim.opt_local.tabstop = 2 -- Tab width
vim.opt_local.softtabstop = 2 -- Tab width in insert mode
-- vim.opt_local.formatlistpat = [[^\s*\d\+[.\)]\s\+]] .. [[\|^\s*[-*+]\s\+]] .. [[\|^\[^\ze[^\]]\+\]:]] -- Recognize lists for formatting
