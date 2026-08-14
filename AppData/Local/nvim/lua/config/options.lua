-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- My config
vim.g.root_spec = { "cwd" }
-- vim.g.lazyvim_picker = "fzf" --妈的，为啥fzf卡顿
-- 【注】这行其实无效：LazyVim 加载时会把它无条件覆盖回 "auto"（见 lazyvim/config/options.lua）。
-- 真正切换到 fzf 的方式：取消注释 lazy.lua 里的 { import = "lazyvim.plugins.extras.editor.fzf" }。
-- 若真切换，fzf-lua.lua 里已做好懒加载 + ui.select 接管判断，不会再复现历史卡顿。
-- vim.g.lazy_did_setup = "telescope"
-- vim.g.lazyvim_picker = "telescope"
-- 这会让所有由 Neovim 启动的 Node 进程（包括所有 LSP）都遵循这个内存限制
vim.env.NODE_OPTIONS = "--max-old-space-size=1024" -- 防止Copilot language server占用过多内存
-- 保持独立剪贴板，否则会有进程遗留，导致:qa无法完全关闭nvim进程
vim.opt.clipboard = "" -- Lua不同步系统剪贴板，保持Neovim独立
if vim.g.neovide or vim.g.nvy then
  vim.opt.clipboard = "unnamedplus" -- 在Neovide中启用系统剪贴板
end
-- 防止出现使用Windows (CRLF) 的换行格式，而 Neovim 却以 Unix (LF) 格式在解析它。
-- 在 Windows 里，换行是 \r\n，而在 Unix/Linux 里只有 \n。
-- 当 Neovim 识别不出这是 Windows 格式时，就会把多出来的 \r 显示成 ^M。
--  :set fileformats? 查看
vim.opt.fileformats = "unix,dos,mac"

-- 软换行使用<leader> u w 开启，以下优化
vim.opt.linebreak = true -- 在单词边界换行
vim.opt.breakindent = true -- 换行后保持缩进
-- 使用pwsh7而非cmd
if vim.fn.has("win32") == 1 then
  -- 确保sidekick能够正确打开，:term codex能够正常打开
  vim.opt.shellcmdflag =
    "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.opt.shellredir = "2>&1 | Out-File -Encoding UTF8 %s"
  vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
  -- pwsh 7+ 支持,使用ps而非cmd
  if vim.fn.executable("pwsh") == 1 then
    vim.o.shell = "pwsh -NoProfile -NoLogo" -- 使用 PowerShell Core (7+)
  else
    vim.o.shell = "powershell -NoProfile -NoLogo" -- 使用 Windows 自带 PowerShell (5.1)
  end
end

if vim.g.nvy then
  vim.o.guifont = "JetBrainsMono Nerd Font Mono:h14"
  -- 如果图标还是缺，再加一个符号回退字体
  -- vim.o.guifont = "JetBrainsMono Nerd Font Mono:h14:Symbols Nerd Font Mono:h14"
end

if vim.g.neovide then
  -- 核心：设置支持 Nerd Font 的字体，图标才会正常显示
  -- 语法：字体名:h字号 (#e-渲染选项)
  vim.opt.guifont = "JetBrainsMono_Nerd_Font:h14"

  -- 如果还是觉得图标小或模糊，可以微调以下参数（Neovide 特有）
  vim.g.neovide_text_gamma = 0.8
  vim.g.neovide_text_contrast = 0.1
end
