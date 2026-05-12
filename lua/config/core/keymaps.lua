local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Helpers: text/path operations
local function insert_text_at_cursor(text)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()
    local new_line = line:sub(1, col) .. text .. line:sub(col + 1)
    vim.api.nvim_buf_set_lines(0, row - 1, row, false, { new_line })
    vim.api.nvim_win_set_cursor(0, { row, col + #text })
end

local function display_path(path)
    local home = vim.env.HOME or ""
    if home ~= "" then
        return path:gsub("^" .. vim.pesc(home), "~")
    end
    return path
end

local function relative_path_from_current(file_path)
    local current = vim.api.nvim_buf_get_name(0)
    if current == "" then
        return file_path
    end

    local base_dir = vim.fs.normalize(vim.fs.dirname(current))
    local target = vim.fs.normalize(file_path)
    local base_parts = vim.split(base_dir, "/", { plain = true, trimempty = true })
    local target_parts = vim.split(target, "/", { plain = true, trimempty = true })

    local i = 1
    while i <= #base_parts and i <= #target_parts and base_parts[i] == target_parts[i] do
        i = i + 1
    end

    local rel_parts = {}
    for _ = i, #base_parts do
        table.insert(rel_parts, "..")
    end
    for j = i, #target_parts do
        table.insert(rel_parts, target_parts[j])
    end

    if #rel_parts == 0 then
        return "."
    end

    return table.concat(rel_parts, "/")
end

local function pick_file_and_copy_relative_path()
    local ok_builtin, builtin = pcall(require, "telescope.builtin")
    local ok_actions, actions = pcall(require, "telescope.actions")
    local ok_state, action_state = pcall(require, "telescope.actions.state")
    if not (ok_builtin and ok_actions and ok_state) then
        vim.notify("Telescope not available", vim.log.levels.ERROR)
        return
    end

    builtin.find_files({
        attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
                local entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                if not entry then
                    return
                end

                local selected = entry.path or entry.filename or entry[1]
                if not selected or selected == "" then
                    return
                end

                local abs = vim.fn.fnamemodify(selected, ":p")
                local rel = relative_path_from_current(abs)
                vim.fn.setreg("+", rel)
                vim.notify(rel)
            end)
            return true
        end,
    })
end

local function wrap_visual_markdown_link()
    local srow, scol = unpack(vim.api.nvim_buf_get_mark(0, "<"))
    local erow, ecol = unpack(vim.api.nvim_buf_get_mark(0, ">"))

    if srow > erow or (srow == erow and scol > ecol) then
        srow, erow = erow, srow
        scol, ecol = ecol, scol
    end

    if srow ~= erow then
        vim.notify("Link wrap supports single-line selection", vim.log.levels.WARN)
        return
    end

    local line = vim.api.nvim_buf_get_lines(0, srow - 1, srow, false)[1]
    if not line then
        return
    end

    local before = line:sub(1, scol)
    local selected = line:sub(scol + 1, ecol + 1)
    local after = line:sub(ecol + 2)
    local replaced = before .. "[" .. selected .. "]()" .. after
    vim.api.nvim_buf_set_lines(0, srow - 1, srow, false, { replaced })

    local cursor_col = #before + #selected + 3
    vim.api.nvim_win_set_cursor(0, { srow, cursor_col })
    vim.cmd("startinsert")
end

-- Section: leader/bootstrap
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
keymap("n", "<Space>w", ":w<CR>", opts)

<<<<<<< HEAD
-- netrw workflow
keymap("n", "<leader>ee", "<cmd>Ex<CR>", opts)
keymap("n", "<leader>ei", "<cmd>Vex<CR>", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
=======
-- Section: file explorer + window nav
-- keymap("n", "<leader>ee", "<cmd>Neotree toggle filesystem reveal left<CR>", opts)
-- keymap("n", "<leader>ei", "<cmd>Neotree focus filesystem left<CR>", opts)
-- keymap("n", "<C-h>", "<cmd>Neotree focus filesystem left<CR>", opts)
>>>>>>> 9f40cb0 (99 binding to open last select session)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Section: movement + view centering
keymap("n", "<C-a>", "gg<S-v>G")
keymap("n", "J", "mzJ`z")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- Section: clipboard/edit helpers
keymap("x", "<leader>p", '"_dP')
keymap("n", "<leader>y", '"+y')
keymap("v", "<leader>y", '"+y')
keymap("n", "<leader>Y", '"+Y')
keymap("n", "<leader>d", '"_d')
keymap("v", "<leader>d", '"_d')
keymap("n", "Y", "y$", { desc = "Yank to end of line" })
keymap("n", "<leader>V", "v$", { desc = "Select to end of line" })
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
keymap("i", "jj", "<Esc>")
keymap("n", "Q", "<nop>")

-- Section: quickfix/location + tooling
keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
keymap("n", "<leader>f", function()
    vim.lsp.buf.format()
end)
keymap("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap("n", "<C-y>", "<cmd>cprev<CR>zz")
keymap("n", "<leader>k", "<cmd>lnext<CR>zz")

-- Section: markdown writing helpers
keymap("n", "<leader>dd", function()
    insert_text_at_cursor(os.date("%Y-%m-%d"))
end, { desc = "Insert date" })
keymap("n", "<leader>dt", function()
    insert_text_at_cursor(os.date("%Y-%m-%d %H:%M"))
end, { desc = "Insert datetime" })
keymap("x", "<leader>ml", wrap_visual_markdown_link, { desc = "Wrap selection as markdown link" })

vim.api.nvim_create_user_command("InsertDate", function()
    insert_text_at_cursor(os.date("%Y-%m-%d"))
end, { desc = "Insert current date" })

vim.api.nvim_create_user_command("InsertDateTime", function()
    insert_text_at_cursor(os.date("%Y-%m-%d %H:%M"))
end, { desc = "Insert current datetime" })

-- Section: file path helpers
keymap("n", "<leader>fp", function()
    local path = vim.fn.expand("%:p")
    if path == "" then
        vim.notify("No file path", vim.log.levels.WARN)
        return
    end

    local shown = display_path(path)
    vim.fn.setreg("+", shown)
    vim.notify(shown)
end, { desc = "Copy full file path" })

keymap("n", "<leader>fr", pick_file_and_copy_relative_path, { desc = "Find file and copy relative path" })

-- Section: copilot
keymap("n", "<C-g>", "copilot#Accept('<CR>')", { silent = true })
keymap("n", "<C-g>", ":Copilot disable<CR>", { silent = true })
