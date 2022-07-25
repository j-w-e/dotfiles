local present, lualine = pcall(require, "lualine")

if not present then
	return
end
--[[local colors = {
	black        = '#282828',
	white        = '#ebdbb2',
	red          = '#fb4934',
	green        = '#b8bb26',
	blue         = '#83a598',
	yellow       = '#fe8019',
	gray         = '#a89984',
	darkgray     = '#3c3836',
	lightgray    = '#504945',
	inactivegray = '#7c6f64',
}]]
lualine.setup({
	sections = {
		lualine_c = {
			{'filename',
				path = 1,
				shorting_target = 10
			}}
	},
	--[[options = {
		theme = {
			inactive = { 
				a = {bg = colors.darkgray, fg = colors.gray, gui = 'bold'},
				b = {bg = colors.darkgray, fg = colors.gray},
				c = {bg = colors.darkgray, fg = colors.gray},
			},
		},
	},]]
})
