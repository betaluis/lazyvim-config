local options = {
    guicursor = "",
    rnu = true,
    nu = true,
    ai = true,
    si = true,

    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    hlsearch = false,
    incsearch = true,
    ignorecase = true,
    mouse = "a",

    smartindent = true,
    smarttab = true,
    wrap = false,

    clipboard = "", -- gives access to clipboard
    scrolloff = 8,
    sidescrolloff = 8,
    guifont = "monospace:h17",
    termguicolors = true,

    foldlevel = 20,
    foldmethod = "manual",

    updatetime = 50,
    colorcolumn = "80",

    swapfile = false, -- creates a swapfile
    backup = false,
    undodir = os.getenv("HOME") .. "/.vim/undodir",
    undofile = true,
}

local globalOptions = {
    mapleader = " ",
    -- netrw_keepdir = 0,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

for k, v in pairs(globalOptions) do
    vim.g[k] = v
end

