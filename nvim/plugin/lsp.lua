local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end
-- imp

local servers = { "gopls","hls", "jsonls", "lua_ls", "pylsp", "tsserver", "yamlls", "astro", "svelte", "rnix" }

require("mason").setup()
local masonLsp = require("mason-lspconfig")
masonLsp.setup({
  ensure_installed = servers,
})

masonLsp.setup_handlers({
  function (server_name) 
    require('lspconfig')[server_name].setup {}
  end
})

require("user.lsp.handlers").setup()
require("lspsaga").setup()
local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua,
    -- diagnostics.flake8
	},
})


