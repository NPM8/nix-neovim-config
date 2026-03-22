require("neodev").setup({})

-- Global LSP config (applies to all servers)
vim.lsp.config('*', {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

-- Server list
local servers = {
  "gopls", "jsonls", "lua_ls", "pylsp", "ts_ls", "yamlls",
  "astro", "svelte", "nil_ls", "tailwindcss", "intelephense",
}

-- Load per-server settings
for _, server_name in ipairs(servers) do
  local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server_name)
  if has_custom_opts then
    vim.lsp.config(server_name, server_custom_opts)
  end
end

-- Mason for auto-installing servers
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_enable = true,
})

-- Enable servers (idempotent with mason-lspconfig's automatic_enable)
vim.lsp.enable(servers)

-- Diagnostics and UI setup
require("user.lsp.handlers").setup()

-- LspAttach autocmd (replaces per-server on_attach)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user.lsp.attach', {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufnr = ev.buf
    local opts = { buffer = bufnr, silent = true }

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
    vim.keymap.set("n", "gi", "<cmd>Lspsaga lsp_finder<CR>", opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
    vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
    vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts)
    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format{async=true}' ]])

    local illuminate_ok, illuminate = pcall(require, "illuminate")
    if illuminate_ok and client then
      illuminate.on_attach(client)
    end
  end,
})

require("lspsaga").setup()

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting

null_ls.setup({
  debug = false,
  sources = {
    formatting.prettier.with({ extra_args = {} }),
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.stylua,
  },
})
