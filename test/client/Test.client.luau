local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Ev = require(ReplicatedStorage.Ev).client

local Damage = Ev.GetEvent("Damage", "number")

Damage:Listen(function(Amount)
	print("[CLIENT] Received damage:", Amount)
end)

task.wait(5)

print("[CLIENT] Sending damage to server")

Damage:FireServer(50)
task.wait(2)
print(Damage)
Damage:Destroy()
print(Damage)
