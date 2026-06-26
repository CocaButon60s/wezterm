local wezterm = require 'wezterm'
local conf = wezterm.config_builder()

conf.default_prog = {'powershell.exe', '-NoLogo'}

return conf
