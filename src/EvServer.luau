local EventServer = require(script.Parent.EventServer)
local SharedTypes = require(script.Parent.SharedTypes)

local EvServer = {}

export type EvServer = {
	CreateEvent: (Name: string, ArgumentType: SharedTypes.ArgumentType) -> EventServer.EventServer,
	GetEvent: (Name: string) -> EventServer.EventServer?,
	DestroyEvent: (Name: string) -> (),
}

local Events: { [string]: EventServer.EventServer } = {}

local RemoteFolder: Folder?

local function GetRemoteFolder(): Folder
	if RemoteFolder then
		return RemoteFolder
	end

	local ExistingFolder = script.Parent:FindFirstChild("Remotes")

	if ExistingFolder then
		RemoteFolder = ExistingFolder :: Folder
	else
		RemoteFolder = Instance.new("Folder")
		RemoteFolder.Name = "Remotes"
		RemoteFolder.Parent = script.Parent
	end

	return RemoteFolder
end

function EvServer.CreateEvent(Name: string, ArgumentType: SharedTypes.ArgumentType)
	local ExistingEvent = Events[Name]

	if ExistingEvent then
		return ExistingEvent
	end

	local RemoteEvent = Instance.new("RemoteEvent")
	RemoteEvent.Name = Name
	RemoteEvent.Parent = GetRemoteFolder()

	local Event = EventServer.new(RemoteEvent, ArgumentType)

	Events[Name] = Event

	return Event
end

function EvServer.GetEvent(Name: string)
	return Events[Name]
end

function EvServer.DestroyEvent(Name: string)
	local Event = Events[Name]

	if not Event then
		warn(`[{Name}] does not exist!`)
		return
	end

	Event:Destroy()
	Events[Name] = nil
end

return EvServer
