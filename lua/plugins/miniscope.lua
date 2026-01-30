return {
	"echasnovski/mini.indentscope",
	version = false, -- Use latest release
	config = function()
		require("mini.indentscope").setup({
			-- Example config
			delay = 0,
			animation = 0,
			symbol = "╎",
			options = { try_as_border = true },
		})
	end,
}
