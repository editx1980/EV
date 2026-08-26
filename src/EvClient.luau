local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EventClient = require(script.Parent.EventClient)
local SharedTypes = require(script.Parent.SharedTypes)

local EvClient = {}
export type EvClient = typeof(EvClient)

local Events: { [string]: EventClient.EventClient } = {}

local RemoteFolder = ReplicatedStorage:WaitForChild("Remotes")

function EvClient.GetEvent(Name: string, ArgumentType: SharedTypes.ArgumentType)
	local ExistingEvent = Events[Name]

	if ExistingEvent then
		return ExistingEvent
	end

	local RemoteEvent = RemoteFolder:FindFirstChild(Name)

	if not RemoteEvent then
		warn(`[{Name}] does not exist!`)
		return nil
	end

	local NewEvent = EventClient.new(RemoteEvent, ArgumentType)

	Events[Name] = NewEvent

	return NewEvent
end

return EvClient
