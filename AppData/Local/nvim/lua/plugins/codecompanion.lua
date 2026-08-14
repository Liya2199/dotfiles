return {
  {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        http = {
          -- ModelScope 适配器（白嫖：免费额度走 api-inference，环境变量 MODELSCOPE_API_KEY）
          modelscope = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              name = "_modelscope",
              formatted_name = "ModelScope",
              env = {
                api_key = "MODELSCOPE_API_KEY",
                url = "https://api-inference.modelscope.cn",
                chat_url = "/v1/chat/completions",
                models_endpoint = "/v1/models",
              },
              handlers = {
                -- 提取 reasoning_content（旧格式名 parse_message_meta，与内置 deepseek/kimi 同款）
                parse_message_meta = require("codecompanion.adapters.http.deepseek").handlers.response.parse_meta,
                -- 解析 modelscope 响应头配额（discussion #2395：必须保持旧格式，扁平挂在 handlers 下）
                on_exit = function(self, data)
                  require("codecompanion.adapters.http.openai").handlers.on_exit(self, data)
                  local headers = data and data.headers
                  if not headers then
                    return
                  end
                  local mappings = {
                    ["Modelscope-Ratelimit-Requests-Limit"] = "user_daily_limit",
                    ["Modelscope-Ratelimit-Requests-Remaining"] = "user_daily_remaining",
                    ["Modelscope-Ratelimit-Model-Requests-Limit"] = "model_daily_limit",
                    ["Modelscope-Ratelimit-Model-Requests-Remaining"] = "model_daily_remaining",
                  }
                  local parsed = {}
                  for _, hs in ipairs(headers) do
                    local key, value = string.match(hs, "([^:]+):%s*(.+)")
                    if key and value then
                      parsed[key] = value
                    end
                  end
                  local quota = {}
                  for header_name, quota_key in pairs(mappings) do
                    if parsed[header_name] then
                      quota[quota_key] = parsed[header_name]
                    end
                  end
                  if next(quota) then
                    vim.notify(
                      string.format(
                        "ModelScope 额度 → 今日请求: %s/%s, 本模型: %s/%s",
                        quota.user_daily_remaining or "?",
                        quota.user_daily_limit or "?",
                        quota.model_daily_remaining or "?",
                        quota.model_daily_limit or "?"
                      )
                    )
                  end
                end,
              },
              schema = {
                model = {
                  default = "Qwen/Qwen3-Coder-30B-A3B-Instruct",
                  choices = {
                    ["Qwen/Qwen3-Coder-30B-A3B-Instruct"] = {
                      formatted_name = "Qwen3 Coder 30B A3B",
                      meta = { context_window = 131072 },
                      opts = { can_reason = true, can_use_tools = true },
                    },
                    ["Qwen/Qwen3-Next-80B-A3B-Instruct"] = {
                      formatted_name = "Qwen3 Next 80B A3B (新 Coder)",
                      meta = { context_window = 131072 },
                      opts = { can_reason = true, can_use_tools = true },
                    },
                    ["Qwen/Qwen3.5-35B-A3B"] = {
                      formatted_name = "Qwen3.5 35B A3B",
                      meta = { context_window = 131072 },
                      opts = { can_reason = true, can_use_tools = true },
                    },
                    ["stepfun-ai/Step-3.7-Flash"] = {
                      formatted_name = "Step 3.7 Flash",
                      meta = { context_window = 131072 },
                      opts = { can_reason = true, can_use_tools = true },
                    },
                  },
                },
              },
            })
          end,
        },
      },
      interactions = {
        chat = { adapter = "modelscope" },
        inline = { adapter = "modelscope" },
      },

      -- 界面美化（依然配合你的 render-markdown）
      display = {
        chat = {
          render_distractions = false,
          --show_settings = true, -- 这样你能在窗口顶部看到当前适配器
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
      -- visual 模式按 `:` 会自动预填 '\<,'>，RHS 不要再写 range，否则会变成双重范围报错；mode "v" 自动覆盖 v/V/^V 三种 visual
      { "<leader>ay", ":CodeCompanion<CR>", mode = "v", desc = "AI Inline (Selection)" },
      { "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add to AI Chat" },
      { "<leader>ak", "<cmd>CodeCompanionActions<cr>", desc = "AI Actions" },
      { "<leader>ar", "<cmd>CodeCompanionCodeReview<cr>", desc = "AI Code Review" },
    },
  },
}
