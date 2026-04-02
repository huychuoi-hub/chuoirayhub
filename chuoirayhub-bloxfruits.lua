local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("hellocunSelectionUI") then
    CoreGui:FindFirstChild("hellocunSelectionUI"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "hellocunSelectionUI"
ScreenGui.Parent = CoreGui
ScreenGui.IgnoreGuiInset = true

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BackgroundTransparency = 1 -- Bắt đầu bằng việc ẩn đi
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0) -- Bắt đầu ở giữa
MainFrame.Size = UDim2.new(0, 0, 0, 0) -- Bắt đầu với kích thước 0
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.ClipsDescendants = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)
local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Thickness = 3
Stroke.Transparency = 1
Stroke.Color = Color3.fromRGB(0, 255, 255)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBlack
Title.Text = "HELLOCUN SELECTOR"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.TextTransparency = 1

local function CreateBtn(name, pos, text, color)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Name = name
    btn.Size = UDim2.new(0, 110, 0, 50)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.AutoButtonColor = false
    btn.TextTransparency = 1
    btn.BackgroundTransparency = 1
    
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    local bStroke = Instance.new("UIStroke", btn)
    bStroke.Thickness = 1.5
    bStroke.Color = color
    bStroke.Transparency = 1

    -- Hover Animation
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = color}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(35, 35, 40)}):Play()
    end)
    
    return btn
end

local KaitunBtn = CreateBtn("KaitunBtn", UDim2.new(0, 15, 0, 70), "KAITUN", Color3.fromRGB(0, 162, 255))
local HomeBtn = CreateBtn("HomeBtn", UDim2.new(0, 135, 0, 70), "HOME", Color3.fromRGB(255, 50, 50))

-----------------------------------------------------------
-- ANIMATION (START)
-----------------------------------------------------------
local introInfo = TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

TweenService:Create(MainFrame, introInfo, {
    Size = UDim2.new(0, 260, 0, 140),
    BackgroundTransparency = 0.1
}):Play()

TweenService:Create(Stroke, TweenInfo.new(1), {Transparency = 0.1}):Play()

task.wait(0.3)
local fadeInInfo = TweenInfo.new(0.5)
TweenService:Create(Title, fadeInInfo, {TextTransparency = 0}):Play()
TweenService:Create(KaitunBtn, fadeInInfo, {TextTransparency = 0, BackgroundTransparency = 0}):Play()
TweenService:Create(KaitunBtn.UIStroke, fadeInInfo, {Transparency = 0}):Play()
TweenService:Create(HomeBtn, fadeInInfo, {TextTransparency = 0, BackgroundTransparency = 0}):Play()
TweenService:Create(HomeBtn.UIStroke, fadeInInfo, {Transparency = 0}):Play()

-----------------------------------------------------------
-- ANIMATION (EXIT)
-----------------------------------------------------------
local function ExitUI(callback)
    local outroInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In)
    TweenService:Create(MainFrame, outroInfo, {
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1
    }):Play()
    
    task.wait(0.5)
    ScreenGui:Destroy()
    callback()
end


KaitunBtn.MouseButton1Click:Connect(function()
    ExitUI(function()
        loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/d26f5540308fedf1f069f5f48a4d1e8d426f399fbae4d1f6e882682d0c44e040/download"))()
    end)
end)

HomeBtn.MouseButton1Click:Connect(function()
    ExitUI(function()
        loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/33902b2ab6354d9ec4bd3bc3fe3172ea6e68fa8ac1da0beac8ea22e2740d7973/download"))()
    end)
end)

MainFrame.Active = true
MainFrame.Draggable = true
