-- 使用 lazy.nvim 安装
return {
  {
    -- "echasnovski/mini.icons",
    "nvim-mini/mini.icons",
    version = false,
    config = function()
      require("mini.icons").setup()
      require("mini.icons").mock_nvim_web_devicons() -- 兼容旧插件
    end,
  },
}
