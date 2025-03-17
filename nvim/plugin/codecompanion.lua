local status_ok, companion = pcall(require, 'codecompanion')
if not status_ok then
  print('‼ This plugin requires `codecompanion`')
  return
end

vim.env['CODECOMPANION_TOKEN_PATH'] = vim.fn.expand('~/.config')

companion.setup {
  strategies = {
    --NOTE: Change the adapter as required
    chat = {
      adapter = 'copilot',
      slash_commands = {
        ["file"] = {
          callback = "strategies.chat.slash_commands.file",
          description = "Select a file using Telescope",
          opts = {
            provider = "telescope",
            contains_code = true
          }
        },
        ["buffer"] = {
          callback = "strategies.chat.slash_commands.buffer",
          description = "Select a buffer using Telescope",
          opts = {
            provider = "telescope",
          }
        }
      },
    },
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
      opts = {
        -- Customize colors to match Tokyo Night theme
        added = { fg = '#9ece6a', bg = '#1a1b26' },
        modified = { fg = '#e0af68', bg = '#1a1b26' },
        removed = { fg = '#f7768e', bg = '#1a1b26' },
      },
    }
  },
}

vim.cmd [[cab cc CodeCompanion]]
