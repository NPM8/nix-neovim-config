local servers = { "gopls","hls", "jsonls", "lua_ls", "pylsp", "tsserver", "yamlls", "astro", "svelte", "ocamllsp", "rnix" }

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = servers,
})
