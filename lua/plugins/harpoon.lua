return {
    "ThePrimeagen/harpoon",
    keys = {
        {
            "<leader>a",
            function() require("harpoon.mark").add_file() end,
            desc = "Harpoon add file",
            mode = { "n" },
        },
        {
            "<C-e>",
            function() require("harpoon.ui").toggle_quick_menu() end,
            desc = "Harpoon menu",
            mode = { "n" },
        },
        {
            "<C-h>",
            function() require("harpoon.ui").nav_file(1) end,
            desc = "Navigate file 1",
            mode = { "n" },
        },
        {
            "<C-t>",
            function() require("harpoon.ui").nav_file(2) end,
            desc = "Navigate file 2",
            mode = { "n" },
        },
        {
            "<C-n>",
            function() require("harpoon.ui").nav_file(3) end,
            desc = "Navigate file 3",
            mode = { "n" },
        },
        {
            "<C-s>",
            function() require("harpoon.ui").nav_file(4) end,
            desc = "Navigate file 4",
            mode = { "n" },
        },
    },
}
