Config = {}
Config.DebugPrint = true -- if enabled this will print updates on the timer remaining in the f8 console for testing purposes
Config.UseQBCORECreateUsableItem = false -- set this to true if you rely on the qbcore create useable item on the server side

Config.DevCommand = true -- this allows you to use a command to make the closest vehicle dirty 
Config.DirtyVehicleCommand = "setvehicledirty" -- modify this for the command to make the closest vehicle dirty if Config.DevCommand is false the command wont work

Config.DistanceCloseToVehicle = 3.0  -- distance on how close you can interact with the vehicle
Config.TimeInMinutesWaxLasts = 1 -- minutes

Config.Notify = "ox_lib"  -- "ox_lib" or "qbcore"
Config.Progress = "ox-circle"  -- "ox-circle" or "ox-bar"