local status, prettier = pcall(require, "prettier")
if (not status) then return end

prettier.setup({
	bin = 'prettierd', -- or `'prettierd'` (v0.22+)
	["null-ls"] = {
		condition = function()
			return prettier.config_exists({
					-- if `false`, skips checking `package.json` for `"prettier"` key
					check_package_json = true,
				})
		end,
	},
	filetypes = {
		"css",
		"graphql",
		"html",
		"javascript",
		"javascriptreact",
		"json",
		"less",
		"markdown",
		"scss",
		"typescript",
		"typescriptreact",
		"yaml",
	},
})
