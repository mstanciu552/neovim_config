local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local events = require("luasnip.util.events")

local M = {}

function M.config()
	s("cll", t("console.log()"))
	require("luasnip.loaders.from_vscode").lazy_load()
end

return M
