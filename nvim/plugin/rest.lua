--[[ local status_ok, rest = pcall(require, "rest-nvim") ]]
--[[ if not status_ok then ]]
--[[ 	return ]]
--[[ end ]]

local rest = require("rest-nvim")

rest.setup({
  -- Encode URL before making request
  encode_url = true,
  -- Highlight request on run
  highlight = {
    enable = true,
    timeout = 150,
  },
  result = {
    behavior = {
      show_info = {
        url = true,
        headers = true,
        http_info = true,
        curl_command = false,
      },
      -- executables or functions for formatting response body [optional]

      -- set them to false if you want to disable them
      formatters = {
        json = "jq",

        html = function(body)
          return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
        end
      },
    }
  },
  env_file = '.env',
  custom_dynamic_variables = {},
})
