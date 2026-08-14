return {
  {
    "ibhagwan/fzf-lua",
    -- 【性能优化】历史卡顿根因之一：这个 spec 之前没有任何懒加载，启动时就被加载。
    -- event = "VeryLazy"：拖到启动完成后再加载，不占启动时间，保留插件随时可用。
    event = "VeryLazy",
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
      -- 【性能优化】只在 fzf 真的是当前 picker 时才接管 vim.ui.select，
      -- 否则 fzf-lua 会把 LazyVim 所有选择框（snacks/which-key 等）从 telescope 劫持走，互相打架
      -- （这是历史“莫名卡顿”的第二个根因：启动即无条件劫持）。
      -- 注：真正切到 fzf 的方式是取消注释 lazy.lua 里的 fzf extra 导入；
      -- options.lua 里直接设 vim.g.lazyvim_picker 会被 LazyVim 覆盖回 auto，无效。
      if LazyVim and LazyVim.pick and LazyVim.pick.picker and LazyVim.pick.picker.name == "fzf" then
        require("fzf-lua").register_ui_select()
      end

      return opts
    end,
  },
}
