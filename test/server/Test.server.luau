local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Ev = require(ReplicatedStorage.Packages).server

local Clicked = Ev.CreateEvent("Clicked", "none")
local Damage = Ev.CreateEvent("Damage", "number")

Clicked:Listen(function(Player: Player)
	print(`[Server] {Player.Name} clicked!`)
end)

Damage:Listen(function(Player: Player, Amount: number)
	print(`[Server] {Player.Name} dealt {Amount} damage`)
end)

print("[Server] EV test loaded")
