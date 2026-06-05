return {
  {
    "olimorris/codecompanion.nvim",
    enable = false,
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      -- opts = {
      --   log_level = "TRACE",
      -- },

      -- adapters = {
      --   deepseek = function()
      --     return require("codecompanion.adapters").extend("openai_compatible", {
      --       name = "deepseek",
      --       url = "https://api.deepseek.com/chat/completions",
      --       env = {
      --         api_key = os.getenv("DEEPSEEK_API_KEY"),
      --       },
      --       scheme = {
      --         model = "schema.model.default",
      --       },
      --     })
      --   end,
      -- },
      -- strategies = {
      --   chat = { adapter = "deepseek" },
      --   inline = { adapter = "deepseek" },
      --   agent = { adapter = "deepseek" },
      -- },
      --
      -- 界面美化（依然配合你的 render-markdown）
      display = {
        chat = {
          render_distractions = false,
          --show_settings = true, -- 这样你能在窗口顶部看到 DeepSeek 已经在运行
        },
        action_palette = {
          width = 95,
          height = 10,
          prompt = "Prompt",
          provider = "default",
          opts = {
            show_preset_actions = true,
            show_preset_prompts = true,
            title = "CodeCompanion actions",
          },
        },
      },
    },
    keys = {
      { "<leader>at", "<cmd>CodeCompanionChat Toggle<cr>", desc = "AI Chat" },
      { "<leader>ay", "<cmd>CodeCompanion<cr>", desc = "AI Inline (Code)" },
      { "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add to AI Chat" },
    },
  },
}
