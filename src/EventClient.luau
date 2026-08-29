local SharedTypes = require(script.Parent.SharedTypes)
local Validator = require(script.Parent.Validator)

local EventClient = {}
EventClient.__index = EventClient

export type EventClient = typeof(setmetatable(
	{} :: {
		event: RemoteEvent,
		argumentType: SharedTypes.ArgumentType,
		connections: { RBXScriptConnection },
	},
	EventClient
))

function EventClient.new(RemoteEvent: RemoteEvent, ArgumentType: SharedTypes.ArgumentType)
	local self = setmetatable({
		event = RemoteEvent,
		argumentType = ArgumentType,
		connections = {},
	}, EventClient)

	return self
end

function EventClient.FireServer(self: EventClient, Argument: any)
	local event: RemoteEvent = self.event

	if not Validator.Check(Argument, self.argumentType) then
		warn(`[{event.Name}] Expected {self.argumentType}, got {typeof(Argument)}`)
		return
	end

	return event:FireServer(Argument)
end

function EventClient.Listen(self: EventClient, callback: (...any) -> ())
	local event: RemoteEvent = self.event

	if self.argumentType == "none" then
		callback()
		return
	end

	local connection = event.OnClientEvent:Connect(function(Argument: any)
		if not Validator.Check(Argument, self.argumentType) then
			warn(`[{event.Name}] Expected {self.argumentType}, got {typeof(Argument)}`)
			return
		end

		callback(Argument)
	end)

	table.insert(self.connections, connection)

	return connection
end

function EventClient.GetName(self: EventClient)
	return self.event.Name
end

function EventClient.Destroy(self: EventClient)
	for _, connection in self.connections do
		connection:Disconnect()
	end

	table.clear(self.connections)

	local event: RemoteEvent = self.event
	event:Destroy()
end

return EventClient
