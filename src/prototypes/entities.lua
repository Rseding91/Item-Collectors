data:extend(
	{
		{
			type = "container",
			name = "item-collector",
			icon = "__Item Collectors__/graphics/icons/smart-chest.png",
			flags = {"placeable-neutral", "player-creation"},
			open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume=0.65 },
			close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.7 },
			minable = {mining_time = 0.5, result = "item-collector-area"},
			max_health = 150,
			corpse = "small-remnants",
			resistances = 
			{
				{
					type = "fire",
					percent = 70
				}
			},
			collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
			selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
			order = "i[items]-i[item-collector]",
			subgroup = "storage",
			fast_replaceable_group = "container",
			inventory_size = 48,
			picture =
			{
				filename = "__Item Collectors__/graphics/smart-chest.png",
				priority = "extra-high",
				width = 62,
				height = 41,
				shift = {0.4, -0.13}
			}
		},
		{
			type = "container",
			name = "item-collector-area",
			icon = "__Item Collectors__/graphics/icons/smart-chest.png",
			flags = {"placeable-neutral", "player-creation"},
			open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume=0.65 },
			close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.7 },
			minable = {mining_time = 0.5, result = "item-collector-area"},
			max_health = 150,
			corpse = "small-remnants",
			resistances = 
			{
				{
					type = "fire",
					percent = 70
				}
			},
			collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
			selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
			order = "i[items]-i[item-collector]",
			subgroup = "storage",
			fast_replaceable_group = "container",
			inventory_size = 48,
			picture =
			{
				filename = "__Item Collectors__/graphics/smart-chest-area.png",
				priority = "extra-high",
				width = 1600,
				height = 1600,
				shift = {0.4, -0.13}
			}
		}
	}
)