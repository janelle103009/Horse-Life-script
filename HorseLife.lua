-- Toggles
getgenv().autoFarm = false
getgenv().autoSell = false
getgenv().autoTrain = false

local plr = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local ws = game:GetService("Workspace")

-- Remotes
local farmRemote = rs:WaitForChild("RemoteEvents"):WaitForChild("CollectItem")
local sellRemote = rs:WaitForChild("RemoteEvents"):WaitForChild("SellHorse")
local trainRemote = rs:WaitForChild("RemoteEvents"):WaitForChild("TrainHorse")

-- Auto Farm Loop
spawn(function()
    while true do
        if getgenv().autoFarm then
            for _, item in pairs(ws:GetChildren()) do
                if item.Name == "Resource" then
                    farmRemote:FireServer(item)
                end
            end
        end
        wait(2)
    end
end)

-- Auto Sell Loop
spawn(function()
    while true do
        if getgenv().autoSell then
            for _, horse in pairs(plr:WaitForChild("Horses"):GetChildren()) do
                sellRemote:FireServer(horse.Name)
                wait(0.3)
            end
        end
        wait(6)
    end
end)

-- Auto Train Loop
spawn(function()
    while true do
        if getgenv().autoTrain then
            for _, horse in pairs(plr:WaitForChild("Horses"):GetChildren()) do
                trainRemote:FireServer(horse.Name, "Speed")
                wait(1)
            end
        end
        wait(5)
    end
end)

-- Chat Commands to Toggle Features
plr.Chatted:Connect(function(msg)
    local command = msg:lower()
    if command == "/farm" then
        getgenv().autoFarm = not getgenv().autoFarm
        print("Auto Farm: " .. tostring(getgenv().autoFarm))
    elseif command == "/sell" then
        getgenv().autoSell = not getgenv().autoSell
        print("Auto Sell: " .. tostring(getgenv().autoSell))
    elseif command == "/train" then
        getgenv().autoTrain = not getgenv().autoTrain
        print("Auto Train: " .. tostring(getgenv().autoTrain))
    end
end)

print("Use /farm, /sell, /train in chat to toggle features.")
