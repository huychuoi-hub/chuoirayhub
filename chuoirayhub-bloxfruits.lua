local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local KaitunBtn = Instance.new("TextButton")
local HomeBtn = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "hellocunSelectionUI"

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -60)
MainFrame.Size = UDim2.new(0, 250, 0, 130)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Có thể kéo di chuyển

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

UIStroke.Color = Color3.fromRGB(0, 162, 255) -- Màu xanh nước biển
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "HELLOCUN SELECTOR"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

KaitunBtn.Name = "KaitunBtn"
KaitunBtn.Parent = MainFrame
KaitunBtn.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
KaitunBtn.Position = UDim2.new(0, 15, 0, 50)
KaitunBtn.Size = UDim2.new(0, 100, 0, 50)
KaitunBtn.Font = Enum.Font.GothamBold
KaitunBtn.Text = "KAITUN"
KaitunBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
KaitunBtn.TextSize = 14

local CornerK = Instance.new("UICorner")
CornerK.CornerRadius = UDim.new(0, 8)
CornerK.Parent = KaitunBtn

HomeBtn.Name = "HomeBtn"
HomeBtn.Parent = MainFrame
HomeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
HomeBtn.Position = UDim2.new(0, 135, 0, 50)
HomeBtn.Size = UDim2.new(0, 100, 0, 50)
HomeBtn.Font = Enum.Font.GothamBold
HomeBtn.Text = "HOME"
HomeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HomeBtn.TextSize = 14

local CornerH = Instance.new("UICorner")
CornerH.CornerRadius = UDim.new(0, 8)
CornerH.Parent = HomeBtn

KaitunBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy() 
    loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/d26f5540308fedf1f069f5f48a4d1e8d426f399fbae4d1f6e882682d0c44e040/download"))()
end)

HomeBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy() 
    loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/33902b2ab6354d9ec4bd3bc3fe3172ea6e68fa8ac1da0beac8ea22e2740d7973/download"))()
end)
