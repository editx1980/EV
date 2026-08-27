local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EventServer = require(script.Parent.EventServer)
local SharedTypes = require(script.Parent.SharedTypes)

local EvServer = {}
export type EvServer = typeof(EvServer)

local Events: { [string]: EventServer.EventServer } = {}

local RemoteFolder = ReplicatedStorage:FindFirstChild("Remotes")

if not RemoteFolder then
	RemoteFolder = Instance.new("Folder")
	RemoteFolder.Name = "Remotes"
	RemoteFolder.Parent = ReplicatedStorage
end

function EvServer.CreateEvent(Name: string, ArgumentType: SharedTypes.ArgumentType)
	if Events[Name] then
		warn(`[{Name}] already exists. Continuing.`)
		return Events[Name]
	end

	local Event = Instance.new("RemoteEvent")
	Event.Name = Name
	Event.Parent = RemoteFolder

	local NewRemote = EventServer.new(Event, ArgumentType)
	Events[Name] = NewRemote

	return NewRemote
end

function EvServer.GetEvent(Name: string)
	if not Events[Name] then
		warn(`[{Name}] does not exist!`)
		return nil
	end

	return Events[Name]
end

function EvServer.DestroyEvent(Name: string)
	if not Events[Name] then
		warn(`[{Name}] does not exist!`)
		return nil
	end

	Events[Name]:Destroy()
	Events[Name] = nil
	return
end

return EvServer
