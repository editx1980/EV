local EvServer = require(script.EvServer)
local EvClient = require(script.EvClient)

export type Server = EvServer.EvServer
export type Client = EvClient.EvClient

return {
	server = EvServer,
	client = EvClient,
}
