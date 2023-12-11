-- many plugins annoyingly require a call to a 'setup' function to be loaded,
-- even with default configs

require('nvim-surround').setup()

require('copilot').setup({})
require('copilot_cmp').setup()

require("leap").add_default_mappings()

require("lspsaga").setup({})
