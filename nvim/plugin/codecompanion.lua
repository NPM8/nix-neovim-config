local status_ok, companion = pcall(require, 'codecompanion')
if not status_ok then
  return
end

vim.env["CODECOMPANION_TOKEN_PATH"] = vim.fn.expand("~/.config")

companion.setup {
  strategies = {
    --NOTE: Change the adapter as required
    chat = { adapter = 'copilot' },
    inline = { adapter = 'copilot' },
  },
  opts = {
    log_level = 'DEBUG',
  },
}
