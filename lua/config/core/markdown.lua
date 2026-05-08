local M = {}

function M.setup()
    vim.opt_local.autoindent = true
    vim.opt_local.smartindent = false
    vim.opt_local.cindent = false
    vim.opt_local.indentexpr = ""
    vim.opt_local.formatoptions = "jqlnro"
    vim.opt_local.comments = "b:- [ ],b:* [ ],b:+ [ ],b:*,b:-,b:+,n:>"
    vim.opt_local.commentstring = "<!-- %s -->"
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.formatlistpat = "^\\s*\\d\\+[.\\)]\\s\\+\\|^\\s*[-*+]\\s\\+\\|^\\[^\\ze[^\\]]\\+\\]:"
end

return M
