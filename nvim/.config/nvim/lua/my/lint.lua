local M = {}

local null_ls = require('null-ls')
local helpers = require("null-ls.helpers")

M.jsonlint = helpers.make_builtin {
	method = null_ls.methods.DIAGNOSTICS,
	filetypes = { "json" },
	generator_opts = {
		command = "jsonlint",
		args = { "--compact", },
		to_stdin = true,
		from_stderr = true,
		on_output = require('my.null-ls').from_efm([[%ELine %l:%c,%Z\s%#Reason: %m,%C%.%#,%Eline %l\, col %c\, %m,%E%f line %l\, col %c\, %m,%-G%.%#]], "jsonlint")
	},
	factory = helpers.generator_factory,
}

return M
