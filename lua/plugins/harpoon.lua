return {
	"ThePrimeagen/harpoon",
	keys = {
		{
			"<leader>a",
			function()
				require("harpoon.mark").add_file()
			end,
			desc = "Harpoon add file",
			mode = { "n" },
		},
		{
			"<C-e>",
			function()
				require("harpoon.ui").toggle_quick_menu()
			end,
			desc = "Harpoon menu",
			mode = { "n" },
		},
		{
			"<C-h>",
			function()
				require("harpoon.ui").nav_file(4)
			end,
			desc = "Navigate file 4",
			mode = { "n" },
		},
		{
			"<C-t>",
			function()
				require("harpoon.ui").nav_file(5)
			end,
			desc = "Navigate file 5",
			mode = { "n" },
		},
		{
			"<C-n>",
			function()
				require("harpoon.ui").nav_file(6)
			end,
			desc = "Navigate file 6",
			mode = { "n" },
		},
		{
			"<C-s>",
			function()
				require("harpoon.ui").nav_file(7)
			end,
			desc = "Navigate file 7",
			mode = { "n" },
		},
	},
}
