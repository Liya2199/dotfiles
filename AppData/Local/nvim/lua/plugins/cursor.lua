return {
  {
    "sphamba/smear-cursor.nvim", -- 关闭插件命令:SmearCursorToggle
    -- 核心配置：如果 vim.g.neovide 为 true，则不加载此插件
    -- enabled = not vim.g.neovide,
    event = "VeryLazy",
    -- 如果是neovide或者nvy都不需要启用
    cond = function()
      return not (vim.g.neovide or vim.g.nvy)
    end,
    opts = {
      -- 触发条件
      smear_between_buffers = true, -- 切 buffer 时也拖影
      smear_between_neighbor_lines = true, -- 上下左右移动都触发
      scroll_buffer_space = true, -- 滚动时在 buffer 坐标系绘制，更跟手
      smear_insert_mode = true, -- 插入模式也生效

      -- 外观手感
      legacy_computing_symbols_support = true, -- 用 Cascadia Code / JetBrainsMono Nerd 等支持“方块符号”的字体会更细腻
      cursor_color = "#89b4fa", -- 跟你的主题 Cursor 颜色保持一致，不填就自动取
      stiffness = 0.8, -- 刚度，控制捕捉速度
      trailing_stiffness = 0.4, -- 拖尾的物理感
      stiffness_insert_mode = 0.7, -- 插入模式也生效
      trailing_stiffness_insert_mode = 0.6,
      gamma = 1.0, --亮色

      distance_stop_animating = 0.5, -- 停止动画的阈值,多近就停，越小越平滑
      hide_target_hack = true, -- 隐藏原始光标，让动画看起来更连贯
      damping = 0.92, -- 阻尼，接近 1 就不回弹，Neovide 感
      damping_insert_mode = 0.92,
    },
  },
}
