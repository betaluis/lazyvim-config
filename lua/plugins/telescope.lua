return {
    "nvim-telescope/telescope.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "folke/todo-comments.nvim",
    },
    keys = {
        {
            "<leader>pf",
            function()
                require("telescope.builtin").find_files()
            end,
            mode = { "n" },
        },
        {
            "<leader>pg",
            function()
                require("telescope.builtin").git_file()
            end,
            mode = { "n" },
        },
        {
            "<leader>pl",
            function()
                require("telescope.builtin").live_grep()
            end,
            mode = { "n" },
        },
        {
            "<leader>ps",
            function()
                require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
            end,
            mode = { "n" },
        },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local transform_mod = require("telescope.actions.mt").transform_mod

        local trouble = require("trouble")
        local trouble_telescope = require("trouble.sources.telescope")

        -- or create your custom action
        local custom_actions = transform_mod({
            open_trouble_qflist = function(prompt_bufnr)
                trouble.toggle("quickfix")
            end,
        })

        telescope.setup({
            defaults = {
                path_display = function(_, path)
                    local parts = vim.split(path, "/", { plain = true })
                    local file = table.remove(parts) or path

                    local count = math.min(3, #parts)
                    local parents = {}

                    for i = #parts - count + 1, #parts do
                        parents[#parents + 1] = parts[i]
                    end

                    if #parents > 0 then
                        return string.format("%s (%s/)", file, table.concat(parents, "/"))
                    end

                    return file
                end,
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                        ["<C-j>"] = actions.move_selection_next, -- move to next result
                        ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
                        ["<C-t>"] = trouble_telescope.open,
                    },
                },
            },
        })

        telescope.load_extension("fzf")
    end,
}
-- return {
-- 	"nvim-telescope/telescope.nvim",
-- 	version = "*",
-- 	dependencies = {
-- 		"nvim-lua/plenary.nvim",
-- 		-- optional but recommended
-- 		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
-- 	},
-- }
