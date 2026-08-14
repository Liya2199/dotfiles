-- ~/.config/nvim/lua/plugins/completion.lua

local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

-- 定义 blink 专用的高亮适配
-- local function apply_blink_highlights()
--   -- 基础窗口
--   vim.api.nvim_set_hl(0, "BlinkCmpMenu", { link = "NormalFloat" })
--   vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#89b4fa" })
--   vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = "#a6e3a1" })
--   vim.api.nvim_set_hl(0, "BlinkCmpSelection", { bg = "#313244", bold = true })
--
--   -- 匹配文字高亮
--   vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = "#89b4fa", bold = true })
--
--   -- 种类高亮 (对应你原有的颜色)
--   vim.api.nvim_set_hl(0, "BlinkCmpKindSnippet", { fg = "#cba6f7" })
--   vim.api.nvim_set_hl(0, "BlinkCmpKindKeyword", { fg = "#f38ba8" })
--   vim.api.nvim_set_hl(0, "BlinkCmpKindFunction", { fg = "#89b4fa" })
--   vim.api.nvim_set_hl(0, "BlinkCmpKindVariable", { fg = "#cdd6f4" })
-- end
local function apply_blink_highlights()
  -- 基础窗口
  vim.api.nvim_set_hl(0, "BlinkCmpMenu", { link = "NormalFloat" })
  vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#89b4fa" })
  vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = "#a6e3a1" })
  vim.api.nvim_set_hl(0, "BlinkCmpSelection", { bg = "#313244", bold = true })
  vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = "#89b4fa", bold = true })

  -- 核心：直接复刻你原版的颜色映射
  vim.api.nvim_set_hl(0, "BlinkCmpKindSnippet", { fg = "#cba6f7", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindKeyword", { fg = "#f38ba8", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindText", { fg = "#cdd6f4", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindFunction", { fg = "#89b4fa", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindMethod", { fg = "#89b4fa", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindConstructor", { fg = "#89b4fa", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindVariable", { fg = "#cdd6f4", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindField", { fg = "#cdd6f4", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindClass", { fg = "#fab387", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindInterface", { fg = "#fab387", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindStruct", { fg = "#fab387", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindModule", { fg = "#a6e3a1", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindProperty", { fg = "#cdd6f4", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindEnum", { fg = "#fab387", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindEnumMember", { fg = "#f9e2af", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindConstant", { fg = "#f9e2af", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindValue", { fg = "#f9e2af", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindOperator", { fg = "#cdd6f4", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindTypeParameter", { fg = "#89dceb", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindReference", { fg = "#f38ba8", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindEvent", { fg = "#f38ba8", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindColor", { fg = "#f5c2e7", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindFile", { fg = "#a6e3a1", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindFolder", { fg = "#a6e3a1", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindUnit", { fg = "#f9e2af", bg = "NONE" })
  -- 对应原版的 CmpItemMenu
  vim.api.nvim_set_hl(0, "BlinkCmpKindMenu", { fg = "#6c7086", italic = true })
end
return {
  -- 禁用原来的 nvim-cmp 防止冲突
  { "hrsh7th/nvim-cmp", enabled = false },

  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "*",

    opts_extend = { "sources.default" }, -- 确保 sources 不会被意外合并,防止compat字样报错
    opts = {
      -- 键盘映射：使用 'default' 即可，或者自定义
      -- keymap = { preset = "default" },
      keymap = {
        preset = "none", -- 禁用预设，手动定义以获得最高控制权
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<C-y>"] = { "select_and_accept" },

        -- 重点：复刻你习惯的切换方式
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-g>"] = { "show_documentation", "hide_documentation", "fallback" },

        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
        kind_icons = kind_icons,
      },

      completion = {
        -- 菜单配置
        menu = {
          border = "rounded",
          winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpSelection,Search:None",
          draw = {
            -- 这里保持你的列布局
            columns = { { "kind_icon", "label", gap = 1 }, { "kind", "source_name" } },
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  return ctx.kind_icon .. ctx.icon_gap
                end,
                highlight = function(ctx)
                  -- 强制指向我们下面定义的 BlinkCmpKind + 类型名
                  return "BlinkCmpKind" .. ctx.kind
                end,
              },
              kind = {
                text = function(ctx)
                  -- 这里的 ctx.kind 是原始文本（如 "Snippet"）
                  return ctx.kind
                end,
                highlight = function(ctx)
                  return "BlinkCmpKind" .. ctx.kind
                end,
              },
              source_name = {
                text = function(ctx)
                  local labels = { lsp = "LSP", snippets = "Snip", buffer = "Buf", path = "Path", cmdline = "Cmd" }
                  return " <" .. (labels[ctx.source_name] or ctx.source_name) .. ">"
                end,
                highlight = "BlinkCmpMenu", -- 链接到基础窗口颜色，通常没有背景色
              },
            },
          },
        }, -- 文档配置
        documentation = {
          auto_show = true,
          window = { border = "rounded", winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder" },
        },
        -- 幽灵文本
        ghost_text = { enabled = true },
      },

      -- 签名帮助
      signature = { enabled = true, window = { border = "rounded" } },

      -- 来源配置
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
    config = function(_, opts)
      -- 清除 LazyVim coding.blink extra 合并进来的旧字段：blink 1.10+ 已移除 sources.compat，
      -- 残留会导致启动时弹 "sources → compat Unexpected field" 通知
      if opts.sources then
        opts.sources.compat = nil
        -- 去重 sources.default（LazyVim extra 与本地配置合并后可能翻倍）
        if vim.islist(opts.sources.default) then
          local seen, dedup = {}, {}
          for _, s in ipairs(opts.sources.default) do
            if not seen[s] then
              seen[s] = true
              dedup[#dedup + 1] = s
            end
          end
          opts.sources.default = dedup
        end
      end
      apply_blink_highlights()
      require("blink.cmp").setup(opts)
    end,
  },
}
