-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- 检测是否在家目录启动，如果是，则禁用 Copilot
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local cwd = vim.fn.getcwd()
    local home = vim.fn.expand("$HOME")
    if cwd == home then
      -- 禁用 copilot.lua
      local ok, copilot = pcall(require, "copilot.command")
      if ok then
        copilot.disable()
        vim.notify("检测到在家目录启动，已自动禁用 Copilot 以节省内存。", vim.log.levels.WARN)
      end
    end
  end,
})

-- nvim-data/shada删掉这个里面的历史文件
-- 启动时自动清理冗余的 shada 临时文件
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local shada_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/shada/")
    local tmp_files = vim.fn.glob(shada_dir .. "*.tmp.*", false, true)
    if #tmp_files > 0 then
      for _, file in ipairs(tmp_files) do
        os.remove(file)
      end
      -- vim.notify("已自动清理 " .. #tmp_files .. " 个 Shada 残留文件", vim.log.levels.INFO)
    end
  end,
})
