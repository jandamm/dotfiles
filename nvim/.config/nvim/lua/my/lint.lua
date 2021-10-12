local M = {}

local null_ls = require 'null-ls'
local helpers = require 'null-ls.helpers'

M.jsonlint = helpers.make_builtin {
	method = null_ls.methods.DIAGNOSTICS,
	filetypes = { 'json' },
	generator_opts = {
		command = 'jsonlint',
		args = { '--compact' },
		to_stdin = true,
		from_stderr = true,
		on_output = require('my.null-ls').from_efm(
			[[%ELine %l:%c,%Z\s%#Reason: %m,%C%.%#,%Eline %l\, col %c\, %m,%E%f line %l\, col %c\, %m,%-G%.%#]],
			'jsonlint'
		),
	},
	factory = helpers.generator_factory,
}

M.kin = helpers.make_builtin {
	method = null_ls.methods.DIAGNOSTICS,
	filetypes = { 'pbxproj' },
	generator_opts = {
		command = 'kin',
		args = { '$FILENAME' },
		to_temp_file = true,
		from_stderr = true,
		on_output = require('my.null-ls').from_efm '%EERROR: line %l:%c %m',
	},
	factory = helpers.generator_factory,
}

M.swiftlint = helpers.make_builtin {
	method = null_ls.methods.DIAGNOSTICS,
	filetypes = { 'swift', 'ios', 'ios.swift' },
	generator_opts = {
		command = 'neovim',
		args = { 'swiftlint', '--use-stdin', '--no-fail', '$FILENAME' }, -- filename is used to find .swiftlint.yml
		to_stdin = true,
		from_stderr = false,
		on_output = require('my.null-ls').from_efm(
			'%f:%l:%c: %trror: %m,%f:%l:%c: %tarning: %m,%f:%l: %trror: %m,%f:%l: %tarning: %m',
			'swiftlint'
		),
	},
	factory = helpers.generator_factory,
}

M.yamllint = helpers.make_builtin {
	method = null_ls.methods.DIAGNOSTICS,
	filetypes = { 'yaml' },
	generator_opts = {
		command = 'yamllint',
		args = { '-f', 'parsable', '-' },
		to_stdin = true,
		from_stderr = true,
		on_output = require('my.null-ls').from_efm('%E%f:%l:%c: [error] %m,%W%f:%l:%c: [warning] %m', 'yamllint'),
	},
	factory = helpers.generator_factory,
}

M.zsh = helpers.make_builtin {
	method = null_ls.methods.DIAGNOSTICS,
	filetypes = { 'zsh' },
	generator_opts = {
		command = '/usr/bin/env',
		args = { 'zsh', '-n', '$FILENAME' },
		to_temp_file = true,
		from_stderr = true,
		on_output = require('my.null-ls').from_efm('%E%f: line %l: %m,%E%f: %l: %m,%E%f:%l: %m', 'zsh'),
	},
	factory = helpers.generator_factory,
}

return M
