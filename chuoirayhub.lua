local currentId = game.PlaceId

if currentId == 9503696692 then 
    print("Đang chạy script Blox Fruits...")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/huychuoi-hub/SILENT-ASSASSIN/refs/heads/main/chuoirayhub.lua"))()
    
elseif currentId == 994732206 then 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/huychuoi-hub/kaitun-beta/refs/heads/main/chuoirayhub.lua"))()

else
    print("Game này chưa được hỗ trợ ID: " .. currentId)
end
