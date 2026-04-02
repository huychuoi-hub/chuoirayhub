local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- Dọn dẹp UI cũ
if CoreGui:FindFirstChild("hellocunSelectionUI") then
    CoreGui:FindFirstChild("hellocunSelectionUI"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "hellocunSelectionUI"
ScreenGui.Parent = CoreGui
ScreenGui.IgnoreGuiInset = true

-- Khung chính
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BackgroundTransparency = 1 -- Bắt đầu ẩn
MainFrame.Size = UDim2.new(0, 280, 0, 150)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.ClipsDescendants = true

local Corner = Instance.new("UICorner", MainFrame)
Corner.CornerRadius = UDim.new(0, 20)

local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Thickness = 3
Stroke.Color = Color3.fromRGB(255, 255, 255)
Stroke.Transparency = 1

local StrokeGradient = Instance.new("UIGradient", Stroke)
StrokeGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(170, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))
}

-- Tiêu đề
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 60)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBlack
Title.Text = "HELLOCUN SELECTOR"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.TextTransparency = 1
Title.Position = UDim2.new(0, 0, -0.2, 0) -- Bắt đầu từ phía trên

-- Hàm tạo nút với hiệu ứng nhấn (Spring)
local function CreateModernBtn(name, pos, text, color)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Name = name
    btn.Size = UDim2.new(0, 120, 0, 55)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.AutoButtonColor = false
    btn.BackgroundTransparency = 1
    btn.TextTransparency = 1
    
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)
    local bStroke = Instance.new("UIStroke", btn)
    bStroke.Thickness = 2
    bStroke.Color = color
    bStroke.Transparency = 1

    -- Hiệu ứng Hover & Press
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = color, Size = UDim2.new(0, 125, 0, 60)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(30, 30, 35), Size = UDim2.new(0, 120, 0, 55)}):Play()
    end)
    
    btn.MouseButton1Down:Connect(function()
        btn:TweenSize(UDim2.new(0, 110, 0, 50), "Out", "Quad", 0.1, true)
    end)
    
    return btn
end

local KaitunBtn = CreateModernBtn("KaitunBtn", UDim2.new(0, 15, 0.5, 5), "KAITUN", Color3.fromRGB(0, 160, 255))
local HomeBtn = CreateModernBtn("HomeBtn", UDim2.new(0, 145, 0.5, 5), "HOME", Color3.fromRGB(255, 60, 60))

--- SEQUENCE ANIMATION (HÀNH ĐỘNG CHÍNH) ---

-- 1. Khung xuất hiện với hiệu ứng Elastic
MainFrame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(MainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 280, 0, 150),
    BackgroundTransparency = 0.1
}):Play()

task.wait(0.1)
TweenService:Create(Stroke, TweenInfo.new(0.5), {Transparency = 0}):Play()

-- 2. Chữ rơi xuống (Staggered)
TweenService:Create(Title, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Position = UDim2.new(0, 0, 0, 0),
    TextTransparency = 0
}):Play()

-- 3. Nút bấm hiện ra đuổi nhau
task.wait(0.2)
for i, btn in pairs({KaitunBtn, HomeBtn}) do
    TweenService:Create(btn, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0,
        TextTransparency = 0
    }):Play()
    TweenService:Create(btn.UIStroke, TweenInfo.new(0.5), {Transparency = 0}):Play()
    task.wait(0.15) -- Khoảng trễ giữa 2 nút
end

-- 4. Vòng lặp viền RGB xoay
task.spawn(function()
    while MainFrame.Parent do
        StrokeGradient.Rotation += 3
        task.wait(0.02)
    end
end)

--- HÀM ĐÓNG UI KHI CHỌN ---
local function CloseAndLoad(callback)
    -- Hiệu ứng thu nhỏ nhanh
    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1
    }):Play()
    
    task.wait(0.4)
    ScreenGui:Destroy()
    callback()
end

KaitunBtn.MouseButton1Click:Connect(function()
    CloseAndLoad(function()
        loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/d26f5540308fedf1f069f5f48a4d1e8d426f399fbae4d1f6e882682d0c44e040/download"))()
    end)
end)

HomeBtn.MouseButton1Click:Connect(function()
    CloseAndLoad(function()
        loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/33902b2ab6354d9ec4bd3bc3fe3172ea6e68fa8ac1da0beac8ea22e2740d7973/download"))()
    end)
end)

MainFrame.Active = true
MainFrame.Draggable = true
