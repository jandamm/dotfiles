local M = {}

local qf_severities = {e=1, w=2, i=3, n=4}

M.from_efm = function(efm, source)
	return function(params, done)
		local output = params.output
		if not output then
			return done()
		end

		local diagnostics = {}
		local lines = vim.split(output, "\n")

		local qflist = vim.fn.getqflist({ efm = efm, lines = lines })

		for _, item in pairs(qflist.items) do
			if item.valid == 1 then
				local col = item.col > 0 and item.col - 1 or 0
				table.insert(diagnostics, {
					row = item.lnum,
					col = col,
					source = source,
					message = item.text,
					severity = qf_severities[item.type],
				})
			end
		end
		return done(diagnostics)
	end
end

return M
