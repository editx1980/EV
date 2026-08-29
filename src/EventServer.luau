local SharedTypes = require(script.Parent.SharedTypes)
local Validator = require(script.Parent.Validator)

local EventServer = {}
EventServer.__index = EventServer

export type EventServer = typeof(setmetatable(
	{} :: {
		event: RemoteEvent,
		argumentType: SharedTypes.ArgumentType,
		connections: { RBXScriptConnection },
	},
	EventServer
))

function EventServer.new(RemoteEvent: RemoteEvent, ArgumentType: SharedTypes.ArgumentType)
	local self = setmetatable({
		event = RemoteEvent,
		argumentType = ArgumentType,
		connections = {},
	}, EventServer)

	return self
end

function EventServer.FireClient(self: EventServer, Player: Player, ...)
	local event: RemoteEvent = self.event

	return event:FireClient(Player, ...)
end

function EventServer.FireAllPlayers(self: EventServer, ...)
	local event: RemoteEvent = self.event

	return event:FireAllClients(...)
end

function EventServer.Destroy(self: EventServer)
	for _, connection in self.connections do
		connection:Disconnect()
	end

	table.clear(self.connections)

	local event: RemoteEvent = self.event
	event:Destroy()
end

function EventServer.GetName(self: EventServer)
	local event: RemoteEvent = self.event

	return event.Name
end

function EventServer.Listen(self: EventServer, callback: (...any) -> ())
	local event: RemoteEvent = self.event

	local connection = event.OnServerEvent:Connect(function(Player: Player, Argument: any)
		if self.argumentType == "none" then
			callback(Player)
			return
		end

		if not Validator.Check(Argument, self.argumentType) then
			warn(`[{event.Name}] Expected {self.argumentType}, got {typeof(Argument)}`)
			return
		end

		callback(Player, Argument)
	end)

	table.insert(self.connections, connection)

	return connection
end

return EventServer
