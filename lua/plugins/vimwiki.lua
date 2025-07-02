return {
  {
    'vimwiki/vimwiki',
    init = function()
      vim.g.vimwiki_list = {
        {
          path = '~/vimwiki', -- The path to your wiki directory
          syntax = 'markdown', -- Use Markdown syntax
          ext = '.md',         -- Use .md file extension
        }
      }
    end,
  },
}
