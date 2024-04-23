return {
  'mrcjkb/rustaceanvim',
  version = '^4', -- Recommended
  lazy = false,  -- This plugin is already lazy
  dependencies = {
    -- "lvimuser/lsp-inlayhints.nvim"
  },
  config = function()
    vim.g.rustaceanvim = {
      tools = {
        hover_actions = {
          auto_focus = true,
        },
      },
    }
  end

}
