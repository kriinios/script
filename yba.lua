getgenv().PityFarm = true
getgenv().WantedPity = 3
--[[
3 = 3%,
2.4 = 2.4%, etc.

10 Arrows = 1.4%
20 Arrows = 1.8%
]]--

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

local Pity = function()
    return (Player.PlayerStats.PityCount.Value * 0.04) + 1
end

local CheckStand = function()
    return Character.SummonedStand.Value
end

local UseArrow = function()
    local args = {[1] = "EndDialogue", [2] = { ["NPC"] = "Mysterious Arrow", ["Option"] = "Option1", ["Dialogue"] = "Dialogue2" }}
    game:GetService("Players").LocalPlayer.Character.RemoteEvent:FireServer(unpack(args))
end

while PityFarm do
    if CheckStand() then
        Player.Character.RemoteFunction:InvokeServer("ToggleStand", "Toggle")
    end
    
    if Pity() >= WantedPity then
        Player:Kick("You have:", Pity(), "Pity")
    end
    
    UseArrow()
    
    task.delay(2, function()
        repeat task.wait() until CheckStand()
        print(Pity())
    end)
end
