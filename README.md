# EV

A simple networking package for Roblox with runtime argument validation.

## Features

Server and client APIs
RemoteEvent management
Runtime argument validation
Server → client communication
Client → server communication
Event listeners
Built-in connection cleanup
Simple API

## How It Works

EV uses Roblox RemoteEvents underneath.

When you create an event on the server, EV creates and manages the corresponding RemoteEvent inside the Remotes folder.

The server and client interact with the event through EV's API instead of directly accessing the RemoteEvent.

EV also validates event arguments at runtime before passing them to the listener callback.

Connections created with Listen() are tracked and cleaned up when the event is destroyed.

## Installation

Install EV through Wally:

[dependencies]

ev = "editx1980/ev@0.1.1"
