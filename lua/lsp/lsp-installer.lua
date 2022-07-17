local M = {}

local ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not ok then
	return
end

local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
	return
end

local servers = {
	"sumneko_lua",
	"pyright",
	"tsserver",
	"rust_analyzer",
}
local settings = {
	ensure_installed = servers,
	log_level = vim.log.levels.INFO,
}

M.config = function()
	lsp_installer.setup(settings)

	local opts = {}

	for _, server in pairs(servers) do
		opts = {
			on_attach = require("lsp.handlers").on_attach,
			capabilities = require("lsp.handlers").capabilities,
		}
		server = vim.split(server, "@")[1]

		if server == "sumneko_lua" then
			local sumneko_opts = require("lsp.settings.sumneko_lua")
			opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
		end

		if server == "rust_analyzer" then
			local rust_opts = require("lsp.settings.rust")

			local ok, rust_tools = pcall(require, "rust-tools")
			if not ok then
				return
			end

			rust_tools.setup(rust_opts)
			goto continue
		end

		lspconfig[server].setup(opts)
		::continue::
	end
end

return M
