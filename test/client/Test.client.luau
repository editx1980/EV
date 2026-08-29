local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Ev = require(ReplicatedStorage.Packages).client

local Clicked = Ev.GetEvent("Clicked", "none")
local Damage = Ev.GetEvent("Damage", "number")

Clicked:FireServer()

Damage:FireServer(25)

print("[Client] EV test loaded")
