return {
    "stevearc/conform.nvim",
    -- Load conform.nvim on specific events
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
        format_on_save = {
            timeout_ms = 1500,
            lsp_fallback = true,
        },

        formatters_by_ft = {
            javascript = { "prettier" },
            typescript = { "prettier" },
            javascriptreact = { "prettier" },
            typescriptreact = { "prettier" },
            css = { "prettier" },
            html = { "prettier" },
            json = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
        },

    },
}
