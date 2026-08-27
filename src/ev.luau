local EvClient = require(script.Parent.EvClient)
local EvServer = require(script.Parent.EvServer)

export type Server = EvServer.EvServer
export type Client = EvClient.EvClient

return {
	server = EvServer,
	client = EvClient,
}
