-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function python_run()
  vim.cmd("silent! write")
  local filename = vim.fn.expand("%")
  -- 在下方打开新窗口运行（高度占 30%）
  vim.cmd("botright split | resize 30 | terminal python " .. filename)
  -- 进入终端插入模式（可选）
  vim.cmd("startinsert")
end

-- 绑定 <leader>rp 快捷键
vim.keymap.set("n", "<leader>rp", python_run, { desc = "Run Python file" })

local function cpp_run()
  vim.cmd("silent! write")
  local filename = '"' .. vim.fn.expand("%:r") .. '"'
  vim.cmd("botright split | resize 30 | terminal g++ % -o " .. filename .. ".exe && .\\" .. filename .. ".exe")
  vim.cmd("startinsert")
end

vim.keymap.set("n", "<leader>rc", cpp_run, { desc = "Run C++ file" })

local function rust_run()
  vim.cmd("silent! write")
  local filename = '"' .. vim.fn.expand("%:r") .. '"'
  vim.cmd("botright split | resize 30")
  vim.cmd("terminal cargo run")
  vim.cmd("startinsert")
end

vim.keymap.set("n", "<leader>rr", rust_run, { desc = "Run Rust file" })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- 使用Alt l 将注释移动到下一行末尾
-- 将当前行的注释移动到下一行的行尾
vim.keymap.set("n", "<A-l>", function()
  local current_line = vim.api.nvim_get_current_line()

  -- 简单的正则判断：如果当前行以注释符号开始（支持 lua, js, python 等常用符号）
  if current_line:match("^%s*--") or current_line:match("^%s*//") or current_line:match("^%s*#") then
    -- 1. 删除当前行
    vim.cmd("normal! dd")
    -- 2. 去到当前行（即原来的下一行）末尾，添加空格并粘贴
    -- g_ 是移动到行尾非空字符，p 是粘贴
    vim.cmd("normal! A " .. current_line:gsub("^%s+", ""))
    -- 3. 清理一下可能多出来的换行符（由于 dd 带有换行）
    vim.cmd("silent! s/\\n//g")
  else
    print("当前行似乎不是注释")
  end
end, { desc = "Move comment to end of next line" })

-- 如果你的默认 picker 是 fzf，那么可以手动给 telescope 留个后门
-- vim.keymap.set("n", "<leader>tf", "<cmd>Telescope find_files<cr>", { desc = "Telescope Find Files" })
-- vim.keymap.set("n", "<leader>tg", "<cmd>Telescope live_grep<cr>", { desc = "Telescope Live Grep" })
-- vim.keymap.set("n", "<leader>tb", "<cmd>Telescope buffers<cr>", { desc = "Telescope Buffers" })
