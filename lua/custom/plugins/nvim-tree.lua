return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup {
			git = {
				ignore = false
			},
			filters = {
				custom = {"\\.DS_Store"}
			}
		}
		vim.keymap.set('n', '<leader>n', '<cmd> NvimTreeToggle <CR>', { desc = 'Toggle [N]vimTree' })
	end,
}
