local status, saga = pcall(require, "lspsaga")
if (not status) then return end

saga.setup(
	{
		-- keybinds for navigation in lspsaga window
		scroll_preview = { scroll_down = "<C-d>", scroll_up = "<C-f>" },
		-- use enter to open file with definition preview
		definition = {
			edit = "<CR>",
		},
		ui = {
			colors = {
				normal_bg = "#022746",
			},
		},
	}
)
