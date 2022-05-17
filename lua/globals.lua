local M = {}

M.virtual_text = true
M.bufferline = false
M.which_key = false
M.format_on_save = true
M.transparent = false
M.theme = false

local statusline_options = {
	"eviline",
	"neonline",
	"spaceline",
}
M.statusline = statusline_options[1]

local themes = {
	"tokyonight", -- 1
	"nightfox", -- 2
	"monokai", -- 3
	"kanagawa", -- 4
	"onedark", -- 5
	"darkplus", -- 6
	"doom-one", -- 7
	"nvcode", -- 8
}

-- M.colorscheme = themes[math.random(1, #themes)]
M.colorscheme = themes[5]

M.lsp_matlab = false

local telescope_themes = {
	"dropdown", -- 1
	"normal", -- 2
	"ivy", -- 3
}

M.telescope_theme = telescope_themes[3]

M.rename_file = function()
	local fname = vim.api.nvim_buf_get_name(0)
	local new_name = vim.fn.input("New File: ", fname, "file")

	local ok, err, code = os.rename(fname, new_name)

	if not err then
		if code == 13 then
			vim.api.nvim_err_writeln("Permissions issue")
		end
	end
	print(ok)
end

-- TODO Fix this
M.toggle_virtual_text = function()
	vim.api.nvim_buf_attach(0, false, {
		on_lines = function()
			M.virtual_text = not M.virtual_text
			vim.lsp.handlers["textDocument/publishDiagnostics"] =
				vim.lsp.with(
					vim.lsp.diagnostic.on_publish_diagnostics,
					{
						underline = true,
						virtual_text = M.virtual_text,
					}
				)
		end,
	})
end

return M
