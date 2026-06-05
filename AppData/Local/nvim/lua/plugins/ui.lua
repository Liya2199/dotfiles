return {
  {
    "karb94/neoscroll.nvim",
    -- enabled = not vim.g.neovide, -- 同样，Neovide 环境下禁用
    enabled = false,
    config = function()
      require("neoscroll").setup({
        -- 动画持续时间（毫秒），越长越“肉”，越短越“干脆”
        -- Neovide 的感觉大约在 120-150ms 之间
        duration_multiplier = 1.0,
        easing_function = "quadratic", -- 缓动函数：quadratic 是经典的丝滑感
        hide_cursor = true, -- 滚动时隐藏真实光标，避免重影
      })
    end,
  },
}
