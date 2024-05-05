{ inputs }: final: prev:
with final.pkgs.lib; let
  pkgs = final;

  # Use this to create a plugin from an input
  mkNvimPlugin = src: pname:
    pkgs.vimUtils.buildVimPlugin {
      inherit pname src;
      version = src.lastModifiedDate;
    };

  mkNeovim = pkgs.callPackage ./mkNeovim.nix { };

  all-plugins = with pkgs.vimPlugins; [
    # plugins from nixpkgs go in here.
    # https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=vimPlugins
    nvim-treesitter.withAllGrammars
    luasnip # snippets | https://github.com/l3mon4d3/luasnip/
    friendly-snippets
    sniprun
    # LSP
    nvim-lspconfig # enable LSP
    mason-nvim
    mason-lspconfig-nvim
    null-ls-nvim # for formatters and linters
    lspsaga-nvim
    # ^ LSP
    # Dadbod
    vim-dadbod
    vim-dadbod-ui
    vim-dadbod-completion
    # ^ Dadbod
    # Copilot
    copilot-lua # https://github.com/zbirenbaum/copilot.lua
    # ^ Copilot
    # nvim-cmp (autocompletion) and extensions
    nvim-cmp # https://github.com/hrsh7th/nvim-cmp
    cmp_luasnip # snippets autocompletion extension for nvim-cmp | https://github.com/saadparwaiz1/cmp_luasnip/
    lspkind-nvim # vscode-like LSP pictograms | https://github.com/onsails/lspkind.nvim/
    cmp-nvim-lsp # LSP as completion source | https://github.com/hrsh7th/cmp-nvim-lsp/
    cmp-nvim-lsp-signature-help # https://github.com/hrsh7th/cmp-nvim-lsp-signature-help/
    cmp-buffer # current buffer as completion source | https://github.com/hrsh7th/cmp-buffer/
    cmp-path # file paths as completion source | https://github.com/hrsh7th/cmp-path/
    cmp-nvim-lua # neovim lua API as completion source | https://github.com/hrsh7th/cmp-nvim-lua/
    cmp-cmdline # cmp command line suggestions
    cmp-cmdline-history # cmp command line history suggestions
    copilot-cmp
    # ^ nvim-cmp extensions
    # git integration plugins
    diffview-nvim # https://github.com/sindrets/diffview.nvim/
    gitsigns-nvim # https://github.com/lewis6991/gitsigns.nvim/
    # ^ git integration plugins
    # telescope and extensions
    telescope-nvim # https://github.com/nvim-telescope/telescope.nvim/
    telescope-fzy-native-nvim # https://github.com/nvim-telescope/telescope-fzy-native.nvim
    # telescope-smart-history-nvim # https://github.com/nvim-telescope/telescope-smart-history.nvim
    # ^ telescope and extensions
    # UI
    lualine-nvim # Status line | https://github.com/nvim-lualine/lualine.nvim/
    nvim-navic # Add LSP location to lualine | https://github.com/SmiteshP/nvim-navic
    statuscol-nvim # Status column | https://github.com/luukvbaal/statuscol.nvim/
    nvim-treesitter-context # nvim-treesitter-context
    nvim-tree-lua # file tree writen in lua
    # Buffer
    bufferline-nvim
    nvim-web-devicons
    vim-bbye # https://github.com/moll/vim-bbye/
    # ^ Buffer
    toggleterm-nvim

    project-nvim
    impatient-nvim
    indent-blankline-nvim
    # Screen
    alpha-nvim
    # ^ Screen
    # Color schemes
    sonokai
    nord-nvim
    tokyonight-nvim
    # ^ Color schemes
    # ^ UI
    # language support
    neodev-nvim # adds support for Neovim's Lua API to lua-language-server | https://github.com/folke/neodev.nvim/
    # ^ language support
    # navigation/editing enhancement plugins
    vim-unimpaired # predefined ] and [ navigation keymaps | https://github.com/tpope/vim-unimpaired/
    eyeliner-nvim # Highlights unique characters for f/F and t/T motions | https://github.com/jinh0/eyeliner.nvim
    nvim-surround # https://github.com/kylechui/nvim-surround/
    nvim-treesitter-textobjects # https://github.com/nvim-treesitter/nvim-treesitter-textobjects/
    nvim-ts-context-commentstring # https://github.com/joosepalviste/nvim-ts-context-commentstring/
    comment-nvim # https://github.com/numtostr/comment.nvim/
    nvim-autopairs # automatic pairs | https://github.com/windwp/nvim-autopairs/
    # ^ navigation/editing enhancement plugins
    # Useful utilities
    nvim-unception # Prevent nested neovim sessions | nvim-unception
    which-key-nvim
    # ^ Useful utilities
    # libraries that other plugins depend on
    sqlite-lua
    plenary-nvim
    nvim-web-devicons
    vim-repeat
    # ^ libraries that other plugins depend on
    # bleeding-edge plugins from flake inputs
    (mkNvimPlugin inputs.leap-nvim "leap.nvim")
    # (mkNvimPlugin inputs.wf-nvim "wf.nvim") # (example) keymap hints | https://github.com/Cassin01/wf.nvim
    # ^ bleeding-edge plugins from flake inputs
    rest-nvim

    # yarn utilities
    (pkgs.vimUtils.buildVimPlugin {
      pname = "rzip.vim";
      src = pkgs.fetchFromGitHub {
        owner = "lbrayner";
        repo = "vim-rzip";
        rev = "f65400fed27b27c7cff7ef8d428c4e5ff749bf28";
        hash = "sha256-xy7rNqDVqlGapKClrP5BhfOORlMzHOQ8oIc8FdZT/AE=";
      };
      version = "2023-01-06";
      meta.homepage = "https://www.vim.org/scripts/script.php?script_id=5760";
    })
    # ^ yarn utilities
    /* ChatGPT-nvim  */
  ];

  resolvedExtraLuaPackages = with pkgs.lua52Packages; [
    lua-curl
    nvim-nio
    mimetypes
    xml2lua
  ];

  extraPackages = with pkgs; [
    # language servers, etc.
    lua-language-server
    nil # nix LSP
    ripgrep
    fzf
    curl
    lazygit
    lazydocker
    opam
    stdenv.cc.cc.lib
    pam
    nodePackages.prettier
  ];
  extraPython3Packages = with pkgs.python311Packages; [
    python-lsp-server
    black
  ];
in
{
  # This is the neovim derivation
  # returned by the overlay
  nvim-pkg = mkNeovim {
    plugins = all-plugins;
    withNodeJs = true;

    inherit extraPackages resolvedExtraLuaPackages;
  };

  # You can add as many derivations as you like.
}
