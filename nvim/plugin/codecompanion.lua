local status_ok, companion = pcall(require, 'codecompanion')
if not status_ok then
  print('‼ This plugin requires `codecompanion`')
  return
end

vim.env['CODECOMPANION_TOKEN_PATH'] = vim.fn.expand('~/.config')

companion.setup {
  strategies = {
    --NOTE: Change the adapter as required
    chat = { adapter = 'copilot' },
    inline = {
      adapter = 'copilot',
      keymaps = {
        accept_change = {
          modes = { n = 'ga' },
          description = 'Accept the suggested change',
        },
        reject_change = {
          modes = { n = 'gr' },
          description = 'Reject the suggested change',
        },
      },
    },
  },
  display = {
    action_palette = {
      width = 95,
      height = 10,
      prompt = "Prompt ", -- Prompt used for interactive LLM calls
      provider = "telescope", -- default|telescope|mini_pick
      opts = {
        show_default_actions = true, -- Show the default actions in the action palette?
        show_default_prompt_library = true, -- Show the default prompt library in the action palette?
      },
    },
    diff = {
      enable = true,
      provider = 'mini_diff',
    }
  },
}

vim.cmd [[cab cc CodeCompanion]]
