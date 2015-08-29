require "defines"

local loaded
local radius = 25
local chestInventoryIndex = defines.inventory.chest
local filters = {["small-alien-artifact"] = 1,
                 ["alien-artifact"] = 1,
                 ["small-corpse"] = 1,
                 ["medium-corpse"] = 1,
                 ["big-corpse"] = 1,
                 ["berserk-corpse"] = 1,
                 ["elder-corpse"] = 1,
                 ["king-corpse"] = 1,
                 ["queen-corpse"] = 1}

function ticker()
	if global.itemCollectors ~= nil then
		if global.ticks == 0 or global.ticks == nil then
			global.ticks = 59
			processCollectors()
		else
			global.ticks = global.ticks - 1
		end
	else
		game.on_event(defines.events.on_tick, nil)
	end
end

game.on_load(function()
	if not loaded then
		loaded = true
		
		if global.itemCollectors ~= nil then
			game.on_event(defines.events.on_tick, ticker)
		end
	end
end)

game.on_init(function()
	loaded = true
	
	if global.itemCollectors ~= nil then
		game.on_event(defines.events.on_tick, ticker)
	end
end)

function builtEntity(event)
	local newCollector
	
	if event.created_entity.name == "item-collector-area" then
    local surface = event.created_entity.surface
    local force = event.created_entity.force
		newCollector = surface.create_entity({name = "item-collector", position = event.created_entity.position, force = force})
		event.created_entity.destroy()
		
		if global.itemCollectors == nil then
			global.itemCollectors = {}
			game.on_event(defines.events.on_tick, ticker)
		end
		
		table.insert(global.itemCollectors, newCollector)
	end
end

game.on_event(defines.events.on_built_entity, builtEntity)
game.on_event(defines.events.on_robot_built_entity, builtEntity)

function processCollectors()
	local items
	local inventory
	local belt
	
	for k,collector in pairs(global.itemCollectors) do
		if collector.valid then
			items = collector.surface.find_entities_filtered({area = {{x = collector.position.x - radius, y = collector.position.y - radius}, {x = collector.position.x + radius, y = collector.position.y + radius}}, name = "item-on-ground"})
			
			if #items > 0 then
				inventory = collector.get_inventory(chestInventoryIndex)
				for _,item in pairs(items) do
          local stack = item.stack
          if filters[stack.name] == 1 and inventory.can_insert(stack) then
            inventory.insert(stack)
            item.destroy()
            break
          end
				end
			end
		else
			table.remove(global.itemCollectors, k)
			if #global.itemCollectors == 0 then
				global.itemCollectors = nil
			end
		end
	end
end