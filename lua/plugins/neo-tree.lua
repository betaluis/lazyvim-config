return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		enabled = false,
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false, -- neo-tree will lazily load itself
		-- init = function()
		-- 	-- let neo-tree handle directory buffers instead of netrw
		-- 	vim.g.loaded_netrw = 1
		-- 	vim.g.loaded_netrwplugin = 1
		-- end,
		opts = {},
		config = function()
			local neotree = require("neo-tree")

			neotree.setup({
				window = {
					position = "float",
					mappings = {
						["l"] = "open",
						["<C-l>"] = "open",
						["h"] = "close_node",
						["<C-h>"] = "close_node",
						["-"] = "navigate_up",
						["."] = "toggle_hidden",
					},
				},
				filesystem = {
					window = {
						position = "float",
					},
					hijack_netrw_behavior = "open_current",
					follow_current_file = {
						enabled = true,
						leave_dirs_open = false,
					},
					filtered_items = {
						visible = true,
						hide_dotfiles = false,
						hide_gitignored = false,
						hide_hidden = false,
					},
				},
				event_handlers = {
					{
						event = "file_opened",
						handler = function()
							require("neo-tree.command").execute({ action = "close" })
						end,
					},
					{
						event = "neo_tree_buffer_enter",
						handler = function()
							-- This enables both relative and absolute numbers
							-- (the current line shows the absolute number)
							vim.opt_local.number = true
							vim.opt_local.relativenumber = true
						end,
					},
				},
			})
		end,
	},
}
