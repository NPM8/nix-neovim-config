local ok_status, mini_diff = pcall(require, 'mini-diff')

if not ok_status then
  return
end

mini_diff.setup()
