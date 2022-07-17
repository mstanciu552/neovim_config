local M = {}

M.virtual_text = false
M.bufferline = true
M.which_key = false
M.format_on_save = true
M.transparent = false
M.theme = false
M.underline = true
M.hover_diagnostics = false

local statusline_options = {
	"eviline",
	"neonline",
	"spaceline",
}
M.statusline = statusline_options[3]

local themes = {
	"tokyonight", -- 1
	"nightfox", -- 2
	"monokai", -- 3
	"kanagawa", -- 4
	"onedark", -- 5
	"darkplus", -- 6
	"doom-one", -- 7
	"nvcode", -- 8
	"catppuccin", -- 9
	"github_dark", -- 10
	"gruvbox", -- 11
	"palenight", -- 12
}

M.colorscheme = themes[10]

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
				vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
					underline = M.underline,
					virtual_text = M.virtual_text,
				})
		end,
	})
end

return M
