local which_key = require("which-key")

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  show_help = true, -- show help message on the command line when the popup is visible
  -- triggers = {"auto"}, -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
}

local mappings = {
    { "<leader>A", "<cmd>CodeCompanionChat Toggle<CR>", desc = "Toggle Chat", nowait = true, remap = false },
    --[[ { "<leader>A", group = "ChatGPT", nowait = true, remap = false }, ]]
    --[[ { "<leader>Ac", "<cmd>ChatGPT<CR>", desc = "ChatGPT", nowait = true, remap = false }, ]]
    { "<leader>F", "<cmd>lua require('telescope.builtin').live_grep { theme=ivy }<cr>", desc = "Find Text", nowait = true, remap = false },
    { "<leader>P", "<cmd>lua require('telescope').extensions.projects.projects()<cr>", desc = "Projects", nowait = true, remap = false },
    { "<leader>a", "<cmd>Alpha<cr>", desc = "Alpha", nowait = true, remap = false },
    { "<leader>b", "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = true})<cr>", desc = "Buffers", nowait = true, remap = false },
    { "<leader>c", "<cmd>Bdelete!<CR>", desc = "Close Buffer", nowait = true, remap = false },
    { "<leader>d", group = "Debug", nowait = true, remap = false },
    { "<leader>db", group = "Breakpoint", nowait = true, remap = false },
    { "<leader>dbc", "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", desc = "Conditional", nowait = true, remap = false },
    { "<leader>dbm", "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", desc = "Log message", nowait = true, remap = false },
    { "<leader>dbt", "<cmd>lua require('dap').toggle_breakpoint()<CR>", desc = "Toggle", nowait = true, remap = false },
    { "<leader>dc", "<cmd>lua require('dap').continue()<CR>", desc = "Continue", nowait = true, remap = false },
    { "<leader>dh", group = "UI controls", nowait = true, remap = false },
    { "<leader>dhc", "<cmd>lua require('dap.ui.variables').scopes()<CR>", desc = "Scopes", nowait = true, remap = false },
    { "<leader>dhf", desc = "<cmd> lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>", nowait = true, remap = false },
    { "<leader>dhh", "<cmd>lua require('dap.ui.variables').hover()<CR>", desc = "Hover variables", nowait = true, remap = false },
    { "<leader>dhs", "<cmd>lua require('dap.ui.widgets').hover()<CR>", desc = "Hover ?", nowait = true, remap = false },
    { "<leader>dhv", "<cmd>lua require('dap.ui.variables').visual_hover()<CR>", desc = "Visual Hover", nowait = true, remap = false },
    { "<leader>dr", group = "REPL", nowait = true, remap = false },
    { "<leader>drl", "<cmd>lua require('dap').repl.run_last()<CR>", desc = "Run Last", nowait = true, remap = false },
    { "<leader>dro", "<cmd>lua require('dap').repl.open()<CR>", desc = "Open", nowait = true, remap = false },
    { "<leader>ds", group = "Step", nowait = true, remap = false },
    { "<leader>dsi", "<cmd>lua require('dap').step_into()<CR>", desc = "Step Into", nowait = true, remap = false },
    { "<leader>dso", "<cmd>lua require('dap').step_over()<CR>", desc = "Step Over", nowait = true, remap = false },
    { "<leader>dsu", "<cmd>lua require('dap').step_out()<CR>", desc = "Step Out", nowait = true, remap = false },
    { "<leader>du", "<cmd>lua require('dapui').toggle()<CR>", desc = "Toggle UI", nowait = true, remap = false },
    { "<leader>e", "<cmd>lua require('oil').toggle_float()<cr>", desc = "File explorer", nowait = true, remap = false },
    { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find files", nowait = true, remap = false },
    { "<leader>g", group = "Git", nowait = true, remap = false },
    { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer", nowait = true, remap = false },
    { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
    { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit", nowait = true, remap = false },
    { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Diff", nowait = true, remap = false },
    { "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", desc = "Lazygit", nowait = true, remap = false },
    { "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", desc = "Next Hunk", nowait = true, remap = false },
    { "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", desc = "Prev Hunk", nowait = true, remap = false },
    { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame", nowait = true, remap = false },
    { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file", nowait = true, remap = false },
    { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk", nowait = true, remap = false },
    { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk", nowait = true, remap = false },
    { "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage Hunk", nowait = true, remap = false },
    { "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage Hunk", nowait = true, remap = false },
    { "<leader>l", group = "LSP", nowait = true, remap = false },
    { "<leader>lF", desc = "<cmd>Lspsaga finder ref+def+imp", nowait = true, remap = false },
    { "<leader>lI", "<cmd>LspInstallInfo<cr>", desc = "Installer Info", nowait = true, remap = false },
    { "<leader>lR", "<cmd>Lspsaga rename ++project<cr>", desc = "Project rename", nowait = true, remap = false },
    { "<leader>la", "<cmd>Lspsaga code_action<cr>", desc = "Code Action", nowait = true, remap = false },
    { "<leader>ld", "<cmd>Lspsaga peek_definition<cr>", desc = "Preview Definition", nowait = true, remap = false },
    { "<leader>lf", "<cmd>lua vim.lsp.buf.format{async=true}<cr>", desc = "Format", nowait = true, remap = false },
    { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info", nowait = true, remap = false },
    { "<leader>lj", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", desc = "Next Diagnostic", nowait = true, remap = false },
    { "<leader>lk", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic", nowait = true, remap = false },
    { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action", nowait = true, remap = false },
    { "<leader>lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", desc = "Quickfix", nowait = true, remap = false },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename", nowait = true, remap = false },
    { "<leader>ls", group = "Show", nowait = true, remap = false },
    { "<leader>lsS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols", nowait = true, remap = false },
    { "<leader>lsd", "<cmd>Lspsaga show_buf_diagnostics<cr>", desc = "Document Diagnostics", nowait = true, remap = false },
    { "<leader>lsl", "<cmd>Lspsaga show_line_diagnostics<cr>", desc = "Line Diagnostics", nowait = true, remap = false },
    { "<leader>lss", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols", nowait = true, remap = false },
    { "<leader>q", "<cmd>q!<CR>", desc = "Quit", nowait = true, remap = false },
    { "<leader>r", group = "Run", nowait = true, remap = false },
    { "<leader>re", group = "REST specific", nowait = true, remap = false },
    { "<leader>rel", "<cmd>lua require('rest-nvim').last()<cr>", desc = "Run last request REST", nowait = true, remap = false },
    { "<leader>rep", "<cmd>lua require('rest-nvim').run(true)<cr>", desc = "Run last request REST", nowait = true, remap = false },
    { "<leader>rf", "<cmd>SnipRun<cr>", desc = "Snip Run", nowait = true, remap = false },
    { "<leader>rh", "<cmd>lua require('rest-nvim').run()<cr>", desc = "Run request REST", nowait = true, remap = false },
    { "<leader>s", group = "Search", nowait = true, remap = false },
    { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands", nowait = true, remap = false },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages", nowait = true, remap = false },
    { "<leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers", nowait = true, remap = false },
    { "<leader>sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
    { "<leader>sc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme", nowait = true, remap = false },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Find Help", nowait = true, remap = false },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps", nowait = true, remap = false },
    { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File", nowait = true, remap = false },
    { "<leader>t", group = "Terminal", nowait = true, remap = false },
    { "<leader>td", "<cmd>lua _LAZYDOCKER_TOGGLE()<cr>", desc = "Lazy docker", nowait = true, remap = false },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float", nowait = true, remap = false },
    { "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal", nowait = true, remap = false },
    { "<leader>tn", "<cmd>lua _NODE_TOGGLE()<cr>", desc = "Node", nowait = true, remap = false },
    { "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<cr>", desc = "Python", nowait = true, remap = false },
    { "<leader>tt", "<cmd>lua _HTOP_TOGGLE()<cr>", desc = "Htop", nowait = true, remap = false },
    { "<leader>tu", "<cmd>lua _NCDU_TOGGLE()<cr>", desc = "NCDU", nowait = true, remap = false },
    { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical", nowait = true, remap = false },
    { "<leader>w", "<cmd>w!<CR>", desc = "Save", nowait = true, remap = false },
    { "<leader>z", "<cmd>ZenMode<cr>", desc = "ZenMode", nowait = true, remap = false },
    --[[ { ]]
    --[[   mode = { "n", "v" }, ]]
    --[[   { "<leader>Aa", "<cmd>ChatGPTRun add_tests<CR>", desc = "Add Tests", nowait = true, remap = false }, ]]
    --[[   { "<leader>Ad", "<cmd>ChatGPTRun docstring<CR>", desc = "Docstring", nowait = true, remap = false }, ]]
    --[[   { "<leader>Ae", "<cmd>ChatGPTEditWithInstruction<CR>", desc = "Edit with instruction", nowait = true, remap = false }, ]]
    --[[   { "<leader>Af", "<cmd>ChatGPTRun fix_bugs<CR>", desc = "Fix Bugs", nowait = true, remap = false }, ]]
    --[[   { "<leader>Ag", "<cmd>ChatGPTRun grammar_correction<CR>", desc = "Grammar Correction", nowait = true, remap = false }, ]]
    --[[   { "<leader>Ak", "<cmd>ChatGPTRun keywords<CR>", desc = "Keywords", nowait = true, remap = false }, ]]
    --[[   { "<leader>Al", "<cmd>ChatGPTRun code_readability_analysis<CR>", desc = "Code Readability Analysis", nowait = true, remap = false }, ]]
    --[[   { "<leader>Ao", "<cmd>ChatGPTRun optimize_code<CR>", desc = "Optimize Code", nowait = true, remap = false }, ]]
    --[[   { "<leader>Ar", "<cmd>ChatGPTRun roxygen_edit<CR>", desc = "Roxygen Edit", nowait = true, remap = false }, ]]
    --[[   { "<leader>As", "<cmd>ChatGPTRun summarize<CR>", desc = "Summarize", nowait = true, remap = false }, ]]
    --[[   { "<leader>At", "<cmd>ChatGPTRun translate<CR>", desc = "Translate", nowait = true, remap = false }, ]]
    --[[   { "<leader>Ax", "<cmd>ChatGPTRun explain_code<CR>", desc = "Explain Code", nowait = true, remap = false }, ]]
    --[[ }, ]]
  }

which_key.setup(setup)
which_key.add(mappings)
