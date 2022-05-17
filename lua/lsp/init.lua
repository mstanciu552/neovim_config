local M = {}
local globals = require("globals")

M.config = function()
	vim.diagnostic.config({
		virtual_text = {
			prefix = "● ",
			format = function(diagnostic)
				if globals.virtual_text then
					return require("neodim").ignore_vtext(diagnostic)
				end
			end,
		},
		signs = true,
		underline = true,
		update_in_insert = false,
	})
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = false,
	})
end

return M
