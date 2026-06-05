local wezterm = require("wezterm")
local platform = require("utils.platform")

local font = "Agave Nerd Font"

local font_size = platform().is_mac and 15 or 15

return {
  --font = wezterm.font(font),
  font = wezterm.font_with_fallback({
	font, --Agave Nerd Font
	"Noto Sans Symbols 2", -- 2. 补 U+1FB75 这批遗留符号
    "Symbols Nerd Font Mono", -- 3. Nerd Fonts v3 的符号兜底
}),
  font_size = font_size,

  --ref: https://wezfurlong.org/wezterm/config/lua/config/freetype_pcf_long_family_names.html#why-doesnt-wezterm-use-the-distro-freetype-or-match-its-configuration
  freetype_load_target = "Normal", ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
  freetype_render_target = "Normal", ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
}
