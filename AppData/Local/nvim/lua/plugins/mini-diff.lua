return {
  "nvim-mini/mini.diff",
  config = function()
    local diff = require("mini.diff")
    diff.setup({
      -- Disabled by default
      --source = diff.gen_source.none(),
      --source = diff.gen_source.save(), --对比上次保存
      source = diff.gen_source.git(),-- 用 Git index 当参考（这就是默认行为）
      view = {
        style = 'sign',
        signs = { add = '▎', change = '▎', delete = '' },
      },
    })
  end,
}