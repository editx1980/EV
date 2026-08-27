local EvClient = require(script.EvClient)
local EvServer = require(script.EvServer)

export type Server = EvServer.EvServer
export type Client = EvClient.EvClient

return {
	server = EvServer,
	client = EvClient,
}
