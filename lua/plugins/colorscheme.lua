return {
	-- "folke/tokyonight.nvim",
    -- "rose-pine/neovim",
    -- "catppuccin/nvim",
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
        vim.cmd([[ colorscheme kanagawa ]])
    end
}
