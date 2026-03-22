local status_ok, _ = pcall(require, "leap")
if not status_ok then
	return
end

-- Sneak-style (directional forward/backward)
vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap-forward)')
vim.keymap.set({'n', 'x', 'o'}, 'S',  '<Plug>(leap-backward)')
vim.keymap.set('n',             'gs', '<Plug>(leap-from-window)')
