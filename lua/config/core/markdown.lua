local M = {}

function M.setup()
    vim.opt_local.autoindent = true
    vim.opt_local.formatoptions = "tcqlnro"
    vim.opt_local.comments = "fb:*,fb:-,fb:+,n:>"
    vim.opt_local.commentstring = "<!-- %s -->"
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.formatlistpat = "^\\s*\\d\\+[.\\)]\\s\\+\\|^\\s*[-*+]\\s\\+\\|^\\[^\\ze[^\\]]\\+\\]:"
end

return M
