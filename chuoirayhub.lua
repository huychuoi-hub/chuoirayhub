local UniverseID = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://apis.roblox.com/universes/v1/places/"..game.PlaceId.."/universe")).universeId

local MyScripts = {
    [994732206] = "https://raw.githubusercontent.com/huychuoi-hub/kaitun-beta/refs/heads/main/chuoirayhub.lua"
    [9503696692] = "https://raw.githubusercontent.com/huychuoi-hub/SILENT-ASSASSIN/refs/heads/main/chuoirayhub.lua"
}

local CurrentScript = MyScripts[game.PlaceId] or MyScripts[UniverseID]

if CurrentScript then
    print("Chuoi Ray Hub: Game Detected!")
    loadstring(game:HttpGet(CurrentScript))()
else
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Chuoi Ray Hub",
        Text = "Game chưa hỗ trợ! ID: " .. game.PlaceId,
        Duration = 10
    })
end
