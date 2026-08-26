local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Ev = require(ReplicatedStorage.Ev).server

local Damage = Ev.CreateEvent("Damage", { "number" })
local Daamage = Ev.CreateEvent("Damage", { "number" })
local New = Ev.CreateEvent("New", { "number" })

Damage:Listen(function(Player, Amount)
	print(`[SERVER] {Player.Name} sent damage:`, Amount)
end)

task.wait(3)

print("[SERVER] Firing Damage to all players")

Damage:FireAllPlayers(100)
