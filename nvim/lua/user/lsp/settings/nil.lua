local root_files = {
  'flake.nix',
  'default.nix',
  'shell.nix',
  '.git',
}

return {
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
}
