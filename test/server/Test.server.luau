local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Ev = require(ReplicatedStorage.Packages).server

local Damage = Ev.CreateEvent("Damage", "number")
local Message = Ev.CreateEvent("Message", "string")
local Toggle = Ev.CreateEvent("Toggle", "boolean")

Damage:Listen(function(Player, Amount)
	print(`[Server] {Player.Name} dealt {Amount} damage`)
	Damage:FireClient(Player, Amount)
end)

Message:Listen(function(Player, Text)
	print(`[Server] {Player.Name} sent: {Text}`)
	Message:FireClient(Player, `Server received: {Text}`)
end)

Toggle:Listen(function(Player, Enabled)
	print(`[Server] {Player.Name} toggled to {Enabled}`)
	Toggle:FireClient(Player, not Enabled)
end)

print("[Server] EV test loaded")
