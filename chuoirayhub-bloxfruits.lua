local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- Dọn dẹp UI cũ
if CoreGui:FindFirstChild("hellocunUltraPremiumUI") then
    CoreGui:FindFirstChild("hellocunUltraPremiumUI"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "hellocunUltraPremiumUI"
ScreenGui.Parent = CoreGui
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Shadow/Glow Effect (Tạo hiệu ứng phát sáng Neon)
local ShadowHolder = Instance.new("ImageLabel")
ShadowHolder.Name = "ShadowHolder"
ShadowHolder.Parent = ScreenGui
ShadowHolder.AnchorPoint = Vector2.new(0.5, 0.5)
ShadowHolder.BackgroundTransparency = 1
ShadowHolder.Position = UDim2.new(0.5, 0, 0.5, 0)
ShadowHolder.Size = UDim2.new(0, 0, 0, 0) -- Bắt đầu từ 0
ShadowHolder.Image = "rbxassetid://1316045217" -- Hình ảnh bóng đổ bo góc
ShadowHolder.ImageColor3 = Color3.fromRGB(0, 0, 0)
ShadowHolder.ImageTransparency = 1 -- Bắt đầu ẩn
ShadowHolder.ScaleType = Enum.ScaleType.Slice
ShadowHolder.SliceCenter = Rect.new(10, 10, 118, 118)

-- Khung chính (Main Frame)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ShadowHolder -- Đặt trong Shadow để cùng scale
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 12) -- Tối hơn để nổi bật viền
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(1, -20, 1, -20) -- Nhỏ hơn shadow một chút
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true

local Corner = Instance.new("UICorner", MainFrame)
Corner.CornerRadius = UDim.new(0, 16)

local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Thickness = 2
Stroke.Color = Color3.fromRGB(255, 255, 255)
Stroke.Transparency = 1 -- Bắt đầu ẩn

local StrokeGradient = Instance.new("UIGradient", Stroke)
StrokeGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)), -- Cyan
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(170, 0, 255)), -- Purple
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))
}

-- Tiêu đề (Title)
local Title = Instance.new("TextLabel", MainFrame)
Title.Name = "Title"
Title.AnchorPoint = Vector2.new(0.5, 0)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.5, 0, 0, 15) -- Vị trí cuối cùng
Title.Size = UDim2.new(1, -30, 0, 40)
Title.Font = Enum.Font.GothamSSmBold
Title.Text = "HELLOCUN SELECTOR"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.TextTransparency = 1 -- Bắt đầu ẩn
Title.ZIndex = 2

-- Hàm tạo nút bấm Ultra Premium
local function CreateUltraBtn(name, pos, text, color, delay)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Name = name
    btn.AnchorPoint = Vector2.new(0.5, 0.5)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    btn.Position = pos:Lerp(UDim2.new(pos.X.Scale, pos.X.Offset, pos.Y.Scale, pos.Y.Offset + 30), 1) -- Bắt đầu thấp hơn
    btn.Size = UDim2.new(0, 120, 0, 50)
    btn.Font = Enum.Font.GothamSSmMedium
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 15
    btn.AutoButtonColor = false
    btn.BackgroundTransparency = 1 -- Bắt đầu ẩn
    btn.TextTransparency = 1 -- Bắt đầu ẩn
    btn.ZIndex = 2

    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0, 12)

    local btnStroke = Instance.new("UIStroke", btn)
    btnStroke.Thickness = 1.5
    btnStroke.Color = color
    btnStroke.Transparency = 1 -- Bắt đầu ẩn

    -- Glow hiệu ứng cho nút khi hover
    local btnGlow = Instance.new("ImageLabel", btn)
    btnGlow.Name = "Glow"
    btnGlow.AnchorPoint = Vector2.new(0.5, 0.5)
    btnGlow.BackgroundTransparency = 1
    btnGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
    btnGlow.Size = UDim2.new(1, 20, 1, 20)
    btnGlow.Image = "rbxassetid://1316045217"
    btnGlow.ImageColor3 = color
    btnGlow.ImageTransparency = 1
    btnGlow.ScaleType = Enum.ScaleType.Slice
    btnGlow.SliceCenter = Rect.new(10, 10, 118, 118)
    btnGlow.ZIndex = 1

    -- Animations cho nút
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = UDim2.new(0, 130, 0, 55)}):Play()
        TweenService:Create(btnGlow, TweenInfo.new(0.3), {ImageTransparency = 0.7}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 120, 0, 50)}):Play()
        TweenService:Create(btnGlow, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
    end)
    btn.MouseButton1Down:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 110, 0, 45)}):Play()
    end)
    
    return btn
end

local KaitunBtn = CreateUltraBtn("KaitunBtn", UDim2.new(0.3, 0, 0.7, 0), "KAITUN", Color3.fromRGB(0, 200, 255))
local HomeBtn = CreateUltraBtn("HomeBtn", UDim2.new(0.7, 0, 0.7, 0), "HOME", Color3.fromRGB(255, 50, 100))

-----------------------------------------------------------
-- SIÊU ANIMATION KHI MỞ UI (ULTRA SEQUENCE)
-----------------------------------------------------------
local openInfo = TweenInfo.new(0.8, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)

-- 1. Shadow/Khung chính bung ra
ShadowHolder.Size = UDim2.new(0, 0, 0, 0) -- Bắt đầu từ 0
TweenService:Create(ShadowHolder, openInfo, {
    Size = UDim2.new(0, 300, 0, 160), -- Kích thước shadow cuối cùng
    ImageTransparency = 0.5 -- Hiện bóng đổ
}):Play()

task.wait(0.1)
TweenService:Create(Stroke, TweenInfo.new(0.6), {Transparency = 0}):Play() -- Hiện viền RGB

-- 2. Title trượt xuống và hiện ra
Title.Position = UDim2.new(0.5, 0, -0.2, 0) -- Bắt đầu từ phía trên
TweenService:Create(Title, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.5, 0, 0, 15),
    TextTransparency = 0
}):Play()

-- 3. Nút bấm trượt lên và hiện ra đuổi nhau (Staggered Slide-in)
local btnOpenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

task.wait(0.2) -- Trễ sau khi title hiện
for i, btn in pairs({KaitunBtn, HomeBtn}) do
    local targetPos = (i == 1 and UDim2.new(0.3, 0, 0.7, 0)) or UDim2.new(0.7, 0, 0.7, 0)
    
    TweenService:Create(btn, btnOpenInfo, {
        Position = targetPos,
        BackgroundTransparency = 0,
        TextTransparency = 0
    }):Play()
    TweenService:Create(btn.UIStroke, btnOpenInfo, {Transparency = 0}):Play()
    
    task.wait(0.15) -- Khoảng trễ cực nhỏ giữa 2 nút
end

-- Vòng lặp viền RGB xoay mượt
task.spawn(function()
    while ShadowHolder.Parent do
        StrokeGradient.Rotation += 2
        task.wait(0.01)
    end
end)

--- HÀM ĐÓNG UI CỰC MƯỢT ---
local function CloseAndLoad(callback)
    local closeInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In)
    
    -- Thu nhỏ ShadowHolder (kéo theo MainFrame)
    TweenService:Create(ShadowHolder, closeInfo, {
        Size = UDim2.new(0, 0, 0, 0),
        ImageTransparency = 1
    }):Play()
    
    task.wait(0.5)
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

-- Cho phép kéo UI (Phải kéo vào MainFrame)
MainFrame.Active = true
MainFrame.Draggable = true
