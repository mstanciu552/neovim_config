local M = {}

M.on_attach = function(client, bufnr)
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
end

M.capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
return M
