-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- My plugins
require("plugins.render-markdown")
require("plugins.codecompanion")
require("plugins.mini-diff")
-- require("plugins.fzf-lua")
--require("sidekick").setup({ ... })
if not vim.g.vscode then
  require("sidekick").setup({})
end
--neovide
