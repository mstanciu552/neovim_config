local M = {}
local globals = require("globals")

M.config = function()
	local lsp_installer = require("nvim-lsp-installer")

	lsp_installer.on_server_ready(function(server)
		local opts = {
			on_attach = function(client, bufnr)
				if
					client.name == "tsserver"
					-- or client.name == "sumneko_lua"
					or client.name == "rust_analyzer"
					or client.name == "rust_analyzer-standalone"
					or client.name == "gopls"
				then
					-- client.resolved_capabilities.document_formatting = false -- Weird that it works
					client.server_capabilities.document_formatting = false -- Weird that it works
				end

				client.server_capabilities.document_formatting = true
				client.server_capabilities.document_range_formatting = true

				if globals.hover_diagnostics then
					vim.api.nvim_create_autocmd("CursorHold", {
						buffer = 0,
						callback = function()
							local opts = {
								focusable = false,
								close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
								border = "rounded",
								source = "always",
								prefix = " ",
								scope = "cursor",
							}
							vim.diagnostic.open_float(nil, opts)
						end,
					})
				end
			end,
			capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
			-- Lua vim global definition
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim", "awesome", "describe", "it" },
					},
				},
			},
		}

		server:setup(opts)
	end)
end

return M
