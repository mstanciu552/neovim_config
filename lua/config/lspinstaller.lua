local M = {}

M.config = function()
	local lsp_installer = require("nvim-lsp-installer")

	lsp_installer.on_server_ready(function(server)
		if server.name == "tsserver" then
			return
		end
		local opts = {
			on_attach = function(client)
				client.resolved_capabilities.document_formatting = false
				client.resolved_capabilities.document_range_formatting = false
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
