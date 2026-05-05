return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    init = function()
        vim.g.mkdp_browser = "chromium"
        vim.g.mkdp_echo_preview_url = 1
        -- vim.g.mkdp_markdown_css = vim.fn.expand("~/.config/nvim/markdown-preview.css")
    end,
    build = "cd app && npm install",
}
