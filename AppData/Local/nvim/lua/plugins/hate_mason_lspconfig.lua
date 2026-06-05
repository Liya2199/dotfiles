return {
  -- 1. 强行把这个不听话的插件彻底禁用（Disabled）
  {
    "mason-org/mason-lspconfig.nvim",
    enabled = false, -- 🌟 核心：就是这一行，直接让它原地蒸发，启动时连加载都不会加载！
  },

  -- 2. 拦截并接管 nvim-lspconfig，防止它因为找不到 mason-lspconfig 而报错
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- 告诉 LazyVim 的 LSP 管理器：老子不需要自动安装任何东西了
      setup = {
        -- 针对所有 LSP 服务，全部拦截，禁止触发 mason-lspconfig 的自动下载行为
        ["*"] = function()
          return false -- 返回 false 允许 lspconfig 正常设置，但阻断自动下载链
        end,
      },
      servers = {
        -- 再次双重保险：给 copilot 彻底拉黑
        copilot = { enabled = false },
      },
    },
  },
}
