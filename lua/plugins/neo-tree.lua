return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false, -- neo-tree will lazily load itself
		init = function()
			-- let neo-tree handle directory buffers instead of netrw
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
		end,
		opts = {
			filesystem = {
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
				window = {
					mappings = {
						["l"] = "open",
						["<C-l>"] = "open",
						["h"] = "close_node",
						["<C-h>"] = "close_node",
						["-"] = "navigate_up",
						["%"] = "add",
						["."] = "toggle_hidden",
					},
				},
			},
		},
	},
}
