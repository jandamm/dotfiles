local actions = require 'telescope.actions'

local displayer = require('telescope.pickers.entry_display').create {
	separator = '',
	items = { {}, { remaining = true } },
}

local make_display = function(entry)
	return displayer {
		{ entry.path .. '/', 'Normal' },
		{ entry.name, 'Operator' },
	}
end

return require('telescope').register_extension {
	exports = {
		sessions = function(opts)
			opts = opts or {}

			local results = {}
			for _, value in ipairs(vim.fn['my#sessions#list']()) do
				table.insert(results, {
					session = value,
					name = vim.fn.fnamemodify(value, ':t'),
					path = vim.fn.fnamemodify(value, ':h'),
				})
			end

			require('telescope.pickers').new(opts, {
				prompt_title = 'Sessions',
				finder = require('telescope.finders').new_table {
					results = results,
					entry_maker = function(entry)
						return {
							value = entry.session,
							name = entry.name,
							path = entry.path,
							display = make_display,
							ordinal = entry.path .. '/' .. entry.name,
						}
					end,
				},
				sorter = require('telescope.config').values.generic_sorter(opts),
				attach_mappings = function(prompt_bufnr)
					actions.select_default:replace(function()
						local selection = require('telescope.actions.state').get_selected_entry(prompt_bufnr)
						actions.close(prompt_bufnr)
						vim.fn['my#sessions#load'](0, selection.value)
					end)

					return true
				end,
			}):find()
		end,
	},
}
