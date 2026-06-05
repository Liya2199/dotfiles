return {
  {
    "ibhagwan/fzf-lua",
    opts = function(_, opts)
      opts = opts or {}

      -- 1. 窗口布局配置 (保持你原来的设置)
      opts.winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.35,
        col = 0.50,
        preview = {
          -- layout = "flex" 会根据窗口宽度自动切换左右或上下布局
          layout = "flex",
          horizontal = "right:60%",
          vertical = "down:45%",
        },
      }

      -- 2. 【核心优化】预览器性能优化
      opts.previewers = {
        builtin = {
          syntax = true, -- 启用语法高亮
          syntax_limit_b = 1024 * 100, -- 超过 100KB 的文件不预览，防止卡顿
          -- 如果还是觉得上下移动光标卡，可以把下面这行注释去掉：
          -- treesitter      = { enable = true },
        },
      }

      -- 3. 搜索设置
      opts.oldfiles = {
        include_current_session = true,
      }

      -- 4. 注册 UI Select
      -- 在 opts 函数内执行，确保 fzf-lua 替代原生的选择框
      require("fzf-lua").register_ui_select()

      return opts
    end,
  },
}
