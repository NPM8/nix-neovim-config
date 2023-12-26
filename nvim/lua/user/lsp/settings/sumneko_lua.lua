require("neodev").setup({
  library = { plugins = "nvim-dap-ui", types = true, runtime = true, vimruntime = true },
})

return {
	settings = {
    before_init = require('neodev.lsp').before_init,
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
}
