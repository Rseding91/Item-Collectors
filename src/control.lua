require "defines"

local loaded

function ticker()
	if glob.itemCollectors ~= nil then
		if glob.ticks == 0 or glob.ticks == nil then
			glob.ticks = 59
			processCollectors()
		else
			glob.ticks = glob.ticks - 1
		end
	else
		game.onevent(defines.events.ontick, nil)
	end
end

game.onload(function()
	if not loaded then
		loaded = true
		
		if glob.itemCollectors ~= nil then
			game.onevent(defines.events.ontick, ticker)
		end
	end
end)

game.oninit(function()
	loaded = true
	
	if glob.itemCollectors ~= nil then
		game.onevent(defines.events.ontick, ticker)
	end
end)

function builtEntity(event)
	local newCollector
	
	if event.createdentity.name == "item-collector-area" then
		newCollector = game.createentity({name = "item-collector", position = event.createdentity.position, force = game.forces.player})
		event.createdentity.destroy()
		
		if glob.itemCollectors == nil then
			glob.itemCollectors = {}
			game.onevent(defines.events.ontick, ticker)
		end
		
		table.insert(glob.itemCollectors, newCollector)
	end
end

game.onevent(defines.events.onbuiltentity, builtEntity)
game.onevent(defines.events.onrobotbuiltentity, builtEntity)

function processCollectors()
	local items
	local inventory
	local belt
	
	for k,collector in pairs(glob.itemCollectors) do
		if collector.valid then
			items = game.findentitiesfiltered({area = {{x = collector.position.x - 25, y = collector.position.y - 25}, {x = collector.position.x + 25, y = collector.position.y + 25}}, name = "item-on-ground"})
			
			if #items > 0 then
				inventory = collector.getinventory(1)
				for _,item in pairs(items) do
					belt = game.findentitiesfiltered({area = {{x = item.position.x - 0.4, y = item.position.y - 0.4}, {x = item.position.x + 0.4, y = item.position.y + 0.4}}, type = "transport-belt"})
					
					if #belt == 0 then
						belt = game.findentitiesfiltered({area = {{x = item.position.x - 0.4, y = item.position.y - 0.4}, {x = item.position.x + 0.4, y = item.position.y + 0.4}}, type = "transport-belt-to-ground"})
						if #belt == 0 then
							if inventory.caninsert(item.stack) then
								inventory.insert(item.stack)
								item.destroy()
								break
							end
						end
					end
				end
			end
		else
			table.remove(glob.itemCollectors, k)
			if #glob.itemCollectors == 0 then
				glob.itemCollectors = nil
			end
		end
	end
end