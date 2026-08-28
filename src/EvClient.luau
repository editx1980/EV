local EventClient = require(script.Parent.EventClient)
local SharedTypes = require(script.Parent.SharedTypes)

local EvClient = {}

export type EvClient = {
	GetEvent: (Name: string, ArgumentType: SharedTypes.ArgumentType) -> EventClient.EventClient?,
}

local Events: { [string]: EventClient.EventClient } = {}

function EvClient.GetEvent(Name: string, ArgumentType: SharedTypes.ArgumentType)
	local ExistingEvent = Events[Name]

	if ExistingEvent then
		return ExistingEvent
	end

	local RemoteFolder = script.Parent:WaitForChild("Remotes")
	local RemoteEvent = RemoteFolder:FindFirstChild(Name)
	if not RemoteEvent then
		warn(`[{Name}] does not exist!`)
		return nil
	end

	local Event = EventClient.new(RemoteEvent, ArgumentType)

	Events[Name] = Event

	return Event
end

return EvClient
