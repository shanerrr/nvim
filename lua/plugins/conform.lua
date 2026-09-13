-- oxfmt first (it is Prettier-compatible); prettier stays as the fallback
-- for projects that have not switched.
local web = { "oxfmt", "prettierd", "prettier", stop_after_first = true }

return {
	{
		"stevearc/conform.nvim",
		-- Without these, `keys` is the only load trigger: if the mapping never
		-- reaches nvim, the plugin stays unloaded and formatting silently no-ops.
		cmd = { "ConformInfo" },
		event = { "BufWritePre" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format", "ruff_organize_imports" },
				rust = { "rustfmt", lsp_format = "fallback" },
				javascript = web,
				javascriptreact = web,
				typescript = web,
				typescriptreact = web,
				css = web,
				json = web,
				jsonc = web,
				markdown = web,
			},
		},
		keys = {
			{
				"<S-M-f>",
				function()
					require("conform").format({ lsp_format = "fallback" })
				end,
				desc = "Format",
				mode = { "n", "i" },
			},
		},
	},
}
