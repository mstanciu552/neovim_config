local M = {}

M.config = function()
	vim.api.nvim_command([[
    augroup RemoveWinNewline
      autocmd BufWritePost *.cs silent %s/\r//g
    augroup END
  ]])

	-- Rust start tools
	-- vim.api.nvim_create_autocmd({"BufEnter"}, {
	--   pattern = {"*.rs"},
	--   callback = function ()
	--     vim.cmd 'RustStartStandaloneServerForBuffer'
	--   end
	-- })
end

return M
