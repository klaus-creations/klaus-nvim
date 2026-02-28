-- Set transparent highlights and colorscheme
function ColorMyPencils(color)
	color = color or "tokyonight"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "night", -- 🔥 darker + hacker-friendly
				transparent = true,
				terminal_colors = true,
				styles = {
					comments = { italic = false },
					keywords = { italic = false },
					sidebars = "dark",
					floats = "dark",
				},
				on_highlights = function(hl, c)
					-- Hacker green & cyan accents (matches Kitty)
					hl.String = { fg = "#00ff9c" }
					hl.Function = { fg = "#00ffd5" }
					hl.Keyword = { fg = "#b36bff" }
					hl.Type = { fg = "#4dc9ff" }
				end,
			})

			ColorMyPencils("tokyonight")
		end,
	},

	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_background = true,
			})
		end,
	},
}

