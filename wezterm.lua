local wezterm = require 'wezterm'
local act = wezterm.action
local conf = wezterm.config_builder()

local function get_os()
    if wezterm.target_triple:find("windows") then
        return "win"
    elseif wezterm.target_triple:find("apple") then
        return "mac"
    else
        return "linux"
    end
end

local current_os = get_os()
if current_os == "win" then
    conf.default_prog = {'powershell.exe', '-NoLogo'}
end

conf.keys = {
    {key = 'P', mods = 'CTRL|SHIFT', action = act.ActivateCommandPalette},
    {
        key = "s",
        mods = 'CTRL|SHIFT',
        action = act.InputSelector {
            title = 'Connect SSH in Current Pane',
            choices = (function()
                local choices = {}
                for host, _ in pairs(wezterm.enumerate_ssh_hosts()) do
                    table.insert(choices, {id=host, label=host})
                end
                table.sort(choices, function(a,b) return a.label < b.label end)
                return choices
            end)(),
            action = wezterm.action_callback(function(window,pane,id,label)
                if id then
                    pane:send_text('ssh ' .. id .. '\n')
                end
            end),
        },
    },
}

return conf
