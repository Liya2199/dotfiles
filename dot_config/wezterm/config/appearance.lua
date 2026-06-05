local wezterm = require("wezterm")

return {
  --use_ime = false, -- 禁用输入法支持，终端将只接收 ASCII 字符，完全不触发中文输入法
  default_prog = { 'pwsh.exe' },--使用pwsh7吧
  -- 基础性能设置
  term = "xterm-256color",
  front_end = "WebGpu", -- 保持 WebGpu 性能最优
  webgpu_power_preference = "HighPerformance",
  -- 【关键优化点 1】Windows 系统级美化
  -- Mica 效果比 Acrylic 流畅得多，且非常有高级感（类似 macOS 的磨砂感）
  win32_system_backdrop = "Mica",
  window_background_opacity = 0.8, -- 配合 Mica，透明度建议在 0.8 左右

  -- 主题选择
  color_scheme = "Gruvbox dark, medium (base16)",

  -- 【关键优化点 2】清理冗余背景
  -- 删除了复杂的 background 数组和 gradient，它们是导致渲染卡顿的主因
  -- 如果想要一点点区分，只保留一个基础底色
  colors = {
    scrollbar_thumb = "#34354D",
    -- 可以在这里微调背景色，使其与主题更贴合
    background = "#1D2021",
  },

  -- 滚动条
  enable_scroll_bar = true,
  min_scroll_bar_height = "3cell",

  -- 标签栏美化（Fancy 模式在现代 UI 下很好看）
  enable_tab_bar = true,
  use_fancy_tab_bar = true,
  hide_tab_bar_if_only_one_tab = false,
  tab_max_width = 25,
  show_tab_index_in_tab_bar = true,

  -- 窗口装饰：保留集成标题栏，但去掉多余的边框感
  window_decorations = "INTEGRATED_BUTTONS|RESIZE",
  window_padding = {
    left = 8,
    right = 8,
    top = 10,
    bottom = 5,
  },

  -- 光标设置
  default_cursor_style = "BlinkingBlock",
  cursor_blink_rate = 500,

  -- 窗口行为
  adjust_window_size_when_changing_font_size = false,
  window_close_confirmation = "AlwaysPrompt",

  -- 活跃/不活跃窗格微调（让当前操作的窗口更突出）
  inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.7,
  },
}

