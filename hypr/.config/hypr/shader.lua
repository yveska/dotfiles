local home = "/home/adam"
local shader_dir = home .. "/.config/hypr/shaders/"

local M = {}

M.current_shader = nil
M.active_mode = nil

M.defaults = {
	rounding = 0,
	gaps_in = 0,
	gaps_out = 0,
	border_size = 1,
	active_border = "rgba(05070a66)",
	inactive_border = "rgb(2a2a2d)",
	animations = true,
	shadow = false,
	blur = true,
}

local function restore_defaults()
	hl.config({
		general = {
			gaps_in = M.defaults.gaps_in,
			gaps_out = M.defaults.gaps_out,
			border_size = M.defaults.border_size,
			["col.active_border"] = M.defaults.active_border,
			["col.inactive_border"] = M.defaults.inactive_border,
		},
		decoration = {
			rounding = M.defaults.rounding,
			shadow = { enabled = M.defaults.shadow },
			blur = { enabled = M.defaults.blur },
		},
		animations = { enabled = M.defaults.animations },
	})

	hl.config({ decoration = { screen_shader = "" } })
end

-- SHADER CONFIGURATION

local simple_shaders = {
	["Main"] = "main.glsl",
	["Night Light"] = "night.glsl",
	["Amano"] = "amano.glsl",
}

local complex_modes = {
	["Reading Mode"] = {
		shader = "reading_mode.glsl",
		activate = function(shader_path)
			hl.config({
				general = {
					gaps_in = 0,
					gaps_out = 0,
					border_size = 1,
					["col.active_border"] = "rgba(000000ff)",
					["col.inactive_border"] = "rgba(000000ff)",
				},
				decoration = {
					rounding = 0,
					shadow = { enabled = false },
					blur = { enabled = false },
				},
				animations = { enabled = false },
			})
			hl.config({ decoration = { screen_shader = shader_path } })
		end,
	},
}

-- CORE ENGINE (Auto-handles global execution mapping)
M.modes = {}

-- Dynamically generate the standard behaviors for all simple shaders
for name, filename in pairs(simple_shaders) do
	M.modes[name] = {
		shader = filename,
		activate = function(shader_path)
			-- Apply the screen shader path
			hl.config({ decoration = { screen_shader = shader_path } })

			-- Pipeline Workaround: Modifying an optimization toggle in the same frame loop
			-- forces Hyprland to drop cached frame coordinates and evaluate the layout tree globally.
			hl.config({ animations = { enabled = not M.defaults.animations } })
			hl.config({ animations = { enabled = M.defaults.animations } })
		end,
	}
end

-- Inject the complex modes into the master modes table
for name, config in pairs(complex_modes) do
	M.modes[name] = config
end

-- Public API
function M.turn_off_all()
	restore_defaults()
	M.active_mode = nil
	M.current_shader = nil
end

function M.toggle(name)
	if name == "Turn Off All" or M.current_shader == name then
		M.turn_off_all()
		return
	end

	-- Clean up running shader contexts before starting a new state
	if M.active_mode then
		restore_defaults()
	end

	-- Execute target mode and force tracker mapping
	if M.modes[name] then
		M.active_mode = name
		M.current_shader = name
		M.modes[name].activate(shader_dir .. M.modes[name].shader)
	end
end

-------------------------------------------------------------------------------
-- KEYBINDINGS
-------------------------------------------------------------------------------
local mod = "SUPER"
local alt = "ALT"

hl.bind(alt .. " + M", function()
	M.toggle("Main")
end, { description = "Toggle Main Shader" })

hl.bind(alt .. " + R", function()
	M.toggle("Reading Mode")
end, { description = "Toggle Reading Mode" })

hl.bind(alt .. " + N", function()
	M.toggle("Night Light")
end, { description = "Toggle Night Light" })

hl.bind(alt .. " + A", function()
	M.toggle("Amano")
end, { description = "Toggle Amano Artstyle" })

hl.bind(alt .. " + S", function()
	M.turn_off_all()
end, { description = "Turn off all shaders" })

return M
