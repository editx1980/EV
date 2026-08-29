local SharedTypes = require(script.Parent.SharedTypes)
local Validator = {}

function Validator.Check(Value, ExpectedType: SharedTypes.ArgumentType)
	if ExpectedType == "none" then
		return Value == nil
	end

	local ValueType = typeof(Value)
	if ValueType == ExpectedType then
		return true
	end

	return false
end

return Validator
