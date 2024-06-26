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
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
  ["z"] = { "<cmd>ZenMode<cr>", "ZenMode"},
  ["b"] = {
    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = true})<cr>",
    "Buffers",
  },
  -- ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" }, -- Nvim tree
  ["e"] = { "<cmd>lua require('oil').toggle_float()<cr>", "File explorer" },
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["A"] = { 
    name = "ChatGPT",
    c = { "<cmd>ChatGPT<CR>", "ChatGPT" },
    e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction", mode = { "n", "v" } },
    g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
    t = { "<cmd>ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
    k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
    d = { "<cmd>ChatGPTRun docstring<CR>", "Docstring", mode = { "n", "v" } },
    a = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests", mode = { "n", "v" } },
    o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
    s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
    f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
    x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
    r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit", mode = { "n", "v" } },
    l = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis", mode = { "n", "v" } },
  },
  ["f"] = {
    "<cmd>Telescope find_files<cr>",
    "Find files",
  },
  ["F"] = { "<cmd>lua require('telescope.builtin').live_grep { theme=ivy }<cr>", "Find Text" },
  ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
  d = {
    name = "Debug",
    c = { "<cmd>lua require('dap').continue()<CR>", "Continue" },
    s = {
      name = "Step",
      o = { "<cmd>lua require('dap').step_over()<CR>", "Step Over" },
      i = { "<cmd>lua require('dap').step_into()<CR>", "Step Into" },
      u = { "<cmd>lua require('dap').step_out()<CR>", "Step Out" },
    },
    u = { "<cmd>lua require('dapui').toggle()<CR>", "Toggle UI" },
    b = {
      name = "Breakpoint",
      t = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Toggle" },
      c = { "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", "Conditional" },
      m = { "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", "Log message" },
    },
    h = {
      name = "UI controls",
      h = { "<cmd>lua require('dap.ui.variables').hover()<CR>", "Hover variables" },
      v = { "<cmd>lua require('dap.ui.variables').visual_hover()<CR>", "Visual Hover" },
      s = { "<cmd>lua require('dap.ui.widgets').hover()<CR>", "Hover ?" },
      c = { "<cmd>lua require('dap.ui.variables').scopes()<CR>", "Scopes"},
      f = { "<cmd> lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>"},
    },
    r = {
      name = "REPL",
      o = { "<cmd>lua require('dap').repl.open()<CR>", "Open" },
      l = { "<cmd>lua require('dap').repl.run_last()<CR>", "Run Last" },
    }
  },
  -- map({ "n", "<Leader>dsc", ":lua require('dap').continue()<CR>" })
  -- map({ "n", "<Leader>dsv", ":lua require('dap').step_over()<CR>" })
  -- map({ "n", "<Leader>dsi", ":lua require('dap').step_into()<CR>" })
  -- map({ "n", "<Leader>dso", ":lua require('dap').step_out()<CR>" })
  -- 
  -- map({ "n", "<Leader>dhh", ":lua require('dap.ui.variables').hover()<CR>" })
  -- map({ "v", "<Leader>dhv", ":lua require('dap.ui.variables').visual_hover()<CR>" })
  -- 
  -- map({ "n", "<Leader>duh", ":lua require('dap.ui.widgets').hover()<CR>" })
  -- map({ "n", "<Leader>duf", ":lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>" })
  -- 
  -- map({ "n", "<Leader>dro", ":lua require('dap').repl.open()<CR>" })
  -- map({ "n", "<Leader>drl", ":lua require('dap').repl.run_last()<CR>" })
  -- 
  -- map({ "n", "<Leader>dbc", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>" })
  -- map({ "n", "<Leader>dbm", ":lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>" })
  -- map({ "n", "<Leader>dbt", ":lua require('dap').toggle_breakpoint()<CR>" })
  -- 
  -- map({ "n", "<Leader>dc", ":lua require('dap.ui.variables').scopes()<CR>" })
  -- map({ "n", "<Leader>di", ":lua require('dapui').toggle()<CR>" })
  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },

  l = {
    name = "LSP",
    a = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
    d = { "<cmd>Lspsaga peek_definition<cr>", "Preview Definition" },
    f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
    F = { "<cmd>Lspsaga finder ref+def+imp" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
      "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    R = { "<cmd>Lspsaga rename ++project<cr>", "Project rename" },
    s = {
        name = "+Show",
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = {
          "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
          "Workspace Symbols",
        },
        l = { "<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics" },
        d = {
          "<cmd>Lspsaga show_buf_diagnostics<cr>",
          "Document Diagnostics",
        },
    },
  },
  s = {
    name = "Search",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
  },
  r = {
    name = "Run",
    f = { "<cmd>SnipRun<cr>", "Snip Run" },
    h = { "<cmd>lua require('rest-nvim').run()<cr>", "Run request REST" },
    e = {
      name = "REST specific",
      l = { "<cmd>lua require('rest-nvim').last()<cr>", "Run last request REST" },
      p = { "<cmd>lua require('rest-nvim').run(true)<cr>", "Run last request REST" },
    },
  },
  t = {
    name = "Terminal",
    n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    d = { "<cmd>lua _LAZYDOCKER_TOGGLE()<cr>", "Lazy docker" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },
}

which_key.setup(setup)
which_key.register(mappings, opts)
