local status_ok, zenmode = pcall(require, 'zen-mode')
if not status_ok then
  print('‼ This plugin requires `zen-mode`. Please install dependencies.‼')
  return
end

zenmode.setup {
  window = {
    backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    width = 0.74,
    height = 1,
  },
  plugins = {
    options = { enabled = true, ruler = false, showcmd = false, laststatus = 3 },
    gitsigns = { enabled = false }, -- disables git signs
    tmux = { enabled = false }, -- disables the tmux statusline
    twilight = { enabled = false }, -- enable the twilight plugin
  },
}
