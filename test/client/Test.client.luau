local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Ev = require(ReplicatedStorage.Packages).client

local Damage = Ev.GetEvent("Damage", "number")
local Message = Ev.GetEvent("Message", "string")
local Toggle = Ev.GetEvent("Toggle", "boolean")

Damage:Listen(function(Amount)
	print(`[Client] Damage response: {Amount}`)
end)

Message:Listen(function(Text)
	print(`[Client] Message response: {Text}`)
end)

Toggle:Listen(function(Enabled)
	print(`[Client] Toggle response: {Enabled}`)
end)

task.wait(2)

Damage:FireServer(25)
Message:FireServer("Hello from the client!")
Toggle:FireServer(true)
