local M = {}

local function toggle_task(bufnr, line_number)
    local line = vim.api.nvim_buf_get_lines(bufnr, line_number - 1, line_number, false)[1]
    if not line then
        return
    end

    local prefix, state, suffix = line:match("^(%s*[-*+]%s+%[)([ xX])(%].*)$")

    if not state then
        return
    end

    local new_state = state == " " and "x" or " "
    vim.api.nvim_buf_set_lines(bufnr, line_number - 1, line_number, false, { prefix .. new_state .. suffix })
end

function M.setup()
    local bufnr = vim.api.nvim_get_current_buf()

    vim.keymap.set("n", "<leader>c", function()
        toggle_task(bufnr, vim.api.nvim_win_get_cursor(0)[1])
    end, { buffer = bufnr, desc = "Toggle Markdown task" })
    vim.keymap.set("x", "<leader>c", function()
        local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
        local visual_start_line = vim.fn.line("v")

        for line_number = math.min(cursor_line, visual_start_line), math.max(cursor_line, visual_start_line) do
            toggle_task(bufnr, line_number)
        end
    end, { buffer = bufnr, desc = "Toggle Markdown tasks" })

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
