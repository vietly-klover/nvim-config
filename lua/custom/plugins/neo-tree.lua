-- return {
-- 	"nvim-tree/nvim-tree.lua",
-- 	version = "*",
-- 	dependencies = {
-- 		"nvim-tree/nvim-web-devicons",
-- 	},
-- 	config = function()
-- 		require("nvim-tree").setup {
-- 			git = {
-- 				ignore = false
-- 			},
-- 			filters = {
-- 				custom = { "\\.DS_Store" }
-- 			}
-- 		}
-- 		vim.keymap.set('n', '<leader>n', '<cmd> NvimTreeToggle <CR>', { desc = 'Toggle [N]vimTree' })
-- 	end,
-- }
return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require('neo-tree').setup {
			filesystem = {
				filtered_items = {
					visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
					hide_dotfiles = false,
					hide_gitignored = true,
				}
			}
		}

		vim.keymap.set('n', '<leader>n', '<cmd> Neotree toggle <CR>', { desc = 'Toggle [N]vimTree' })
	end,
}
