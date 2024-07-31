return {
    "folke/trouble.nvim",
    keys = {
        {
            "<leader>tt",
            function() require("trouble").toggle() end,
            desc = "Trouble",
            mode = { "n" },
        },
        -- {
        --     "]d",
        --     function() require("trouble").next({ skip_groups = true, jump = true }) end,
        --     desc = "Next trouble",
        --     mode = { "n" },
        -- },
        -- {
        --     "[d",
        --     function() require("trouble").previous({ skip_groups = true, jump = true }) end,
        --     desc = "Prev trouble",
        --     mode = { "n" },
        -- },
    },
    config = function()
        require("trouble").setup({
            icons = false,
        })
    end,

}
