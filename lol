local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")

-- Xóa UI cũ để tránh bị rác màn hình
if CoreGui:FindFirstChild("HellocunFix") then
    CoreGui:FindFirstChild("HellocunFix"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HellocunFix"
ScreenGui.Parent = CoreGui
ScreenGui.IgnoreGuiInset = true

-----------------------------------------------------------
-- [HỆ THỐNG INTRO - ĐÃ FIX LỖI THANH ĐEN]
-----------------------------------------------------------
local Blur = Instance.new("BlurEffect", Lighting)
Blur.Size = 0

local Overlay = Instance.new("Frame", ScreenGui)
Overlay.Size = UDim2.new(1, 0, 1, 0)
Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Overlay.BackgroundTransparency = 1
Overlay.ZIndex = 10 -- Lớp nền

local BlackBar = Instance.new("Frame", ScreenGui)
BlackBar.Size = UDim2.new(2, 0, 0.25, 0)
BlackBar.Position = UDim2.new(-2, 0, 0.4, 0) -- Xuất phát bên trái
BlackBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
BlackBar.BorderSizePixel = 0
BlackBar.Rotation = -5
BlackBar.ZIndex = 20 -- Nằm trên Overlay

local Circle = Instance.new("Frame", ScreenGui)
Circle.Size = UDim2.new(0, 70, 0, 70)
Circle.Position = UDim2.new(-0.2, 0, 0.8, 0) -- Xuất phát bên trái ngoài
Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Circle.ZIndex = 30 -- Nằm trên cùng
Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

-- [HÀM CHẠY INTRO]
task.spawn(function()
    -- 1. Màn hình xám lại và Blur
    TweenService:Create(Overlay, TweenInfo.new(1), {BackgroundTransparency = 0.5}):Play()
    TweenService:Create(Blur, TweenInfo.new(1), {Size = 15}):Play()
    
    -- 2. Thanh đen đi qua chậm (2 giây) và TỰ HỦY
    local barTween = TweenService:Create(BlackBar, TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {Position = UDim2.new(1.2, 0, 0.4, 0)})
    barTween:Play()
    barTween.Completed:Connect(function() BlackBar:Destroy() end) -- Xong là xóa luôn thanh đen
    
    -- 3. Hình tròn đi vào góc phải dưới
    task.wait(0.3)
    TweenService:Create(Circle, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0.85, 0, 0.8, 0)}):Play()
    
    -- 4. Đợi ở góc phải 1s
    task.wait(2.2) -- Đợi di chuyển xong
    task.wait(1)   -- Đợi thêm 1s theo yêu cầu
    
    -- 5. Hình tròn vào giữa và Nở ra (Explosion)
    local centerTween = TweenService:Create(Circle, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {Position = UDim2.new(0.5, -35, 0.5, -35)})
    centerTween:Play()
    centerTween.Completed:Wait()
    
    -- Nở ra biến mất
    TweenService:Create(Circle, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 1500, 0, 1500), Position = UDim2.new(0.5, -750, 0.5, -750), BackgroundTransparency = 1}):Play()
    TweenService:Create(Overlay, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(Blur, TweenInfo.new(0.5), {Size = 0}):Play()
    
    task.wait(0.2)
    ShowMainUI() -- Hiện Menu chính
    
    task.wait(1)
    Circle:Destroy()
    Overlay:Destroy()
    Blur:Destroy()
end)

-----------------------------------------------------------
-- [GIAO DIỆN CHÍNH - ĐÃ TỐI ƯU]
-----------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 17)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 380, 0, 240)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Visible = false

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 20)
local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Thickness = 2; Stroke.Color = Color3.fromRGB(255, 255, 255)
local Grad = Instance.new("UIGradient", Stroke)
Grad.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 0, 255))}

function ShowMainUI()
    MainFrame.Visible = true
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(MainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Back), {Size = UDim2.new(0, 380, 0, 240)}):Play()
end

-- [CÁC TRANG VÀ NÚT]
local function CreatePage(name, visible)
    local f = Instance.new("Frame", MainFrame)
    f.Name = name; f.Size = UDim2.new(1, 0, 1, 0); f.BackgroundTransparency = 1; f.Visible = visible
    return f
end

local MenuPage = CreatePage("Menu", true)
local KaitunPage = CreatePage("KaitunPage", false)
local BountyPage = CreatePage("BountyPage", false)
local HomePage = CreatePage("HomePage", false)

local function MakeBtn(parent, text, pos, color, size)
    local btn = Instance.new("TextButton", parent)
    btn.Size = size or UDim2.new(0, 110, 0, 50); btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 30); btn.Text = text
    btn.Font = Enum.Font.GothamBold; btn.TextColor3 = Color3.fromRGB(255, 255, 255); btn.TextSize = 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)
    local s = Instance.new("UIStroke", btn)
    s.Thickness = 1.2; s.Color = color; s.Transparency = 0.5
    
    btn.MouseEnter:Connect(function() TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = color}):Play() end)
    btn.MouseLeave:Connect(function() TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(25, 25, 30)}):Play() end)
    return btn
end

-- Header
local Title = Instance.new("TextLabel", MenuPage)
Title.Size = UDim2.new(1, 0, 0, 70); Title.BackgroundTransparency = 1; Title.Text = "HELLOCUN SELECTOR"
Title.Font = Enum.Font.GothamBlack; Title.TextColor3 = Color3.fromRGB(255, 255, 255); Title.TextSize = 22

-- Nút Menu chính
local GoK = MakeBtn(MenuPage, "KAITUN", UDim2.new(0, 15, 0, 100), Color3.fromRGB(0, 170, 255))
local GoB = MakeBtn(MenuPage, "BOUNTY", UDim2.new(0, 135, 0, 100), Color3.fromRGB(0, 255, 150))
local GoH = MakeBtn(MenuPage, "HOME", UDim2.new(0, 255, 0, 100), Color3.fromRGB(255, 60, 100))

-- Detail Page Logic
local function SetupDetail(page, title, info, color, url)
    local T = Instance.new("TextLabel", page)
    T.Size = UDim2.new(1, 0, 0, 60); T.Text = title; T.Font = Enum.Font.GothamBold; T.TextColor3 = color; T.TextSize = 20; T.BackgroundTransparency = 1
    local I = Instance.new("TextLabel", page)
    I.Size = UDim2.new(1, 0, 0, 40); I.Position = UDim2.new(0, 0, 0.4, 0); I.Text = info; I.Font = Enum.Font.Gotham; I.TextColor3 = Color3.fromRGB(200, 200, 200); I.BackgroundTransparency = 1
    local B = MakeBtn(page, "QUAY LẠI", UDim2.new(0.1, 0, 0.7, 0), Color3.fromRGB(100, 100, 100), UDim2.new(0, 120, 0, 45))
    local R = MakeBtn(page, "CHẠY NGAY", UDim2.new(0.55, 0, 0.7, 0), Color3.fromRGB(0, 255, 130), UDim2.new(0, 120, 0, 45))
    B.MouseButton1Click:Connect(function() page.Visible = false; MenuPage.Visible = true end)
    R.MouseButton1Click:Connect(function() 
        local cl = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0,0,0,0), BackgroundTransparency = 1})
        cl:Play()
        cl.Completed:Connect(function() ScreenGui:Destroy(); loadstring(game:HttpGet(url))() end)
    end)
    return I
end

local KTInfo = SetupDetail(KaitunPage, "KAITUN MODE", "...", Color3.fromRGB(0, 170, 255), "https://api.jnkie.com/api/v1/luascripts/public/d26f5540308fedf1f069f5f48a4d1e8d426f399fbae4d1f6e882682d0c44e040/download")
local BTInfo = SetupDetail(BountyPage, "BOUNTY MODE", "Ready!", Color3.fromRGB(0, 255, 150), "https://api.jnkie.com/api/v1/luascripts/public/071eeda09ab172b9bc206a29ad0bbe0ee3d92502c654ab54aa97eec8423edddd/download")
local HMInfo = SetupDetail(HomePage, "HOME MODE", "Waiting...", Color3.fromRGB(255, 60, 100), "https://api.jnkie.com/api/v1/luascripts/public/33902b2ab6354d9ec4bd3bc3fe3172ea6e68fa8ac1da0beac8ea22e2740d7973/download")

GoK.MouseButton1Click:Connect(function() 
    MenuPage.Visible = false; KaitunPage.Visible = true 
    local st = os.time()
    task.spawn(function()
        while KaitunPage.Visible do
            local d = os.time() - st
            KTInfo.Text = string.format("Time running: %02d:%02d", math.floor(d/60), d%60)
            task.wait(1)
        end
    end)
end)
GoB.MouseButton1Click:Connect(function() MenuPage.Visible = false; BountyPage.Visible = true end)
GoH.MouseButton1Click:Connect(function() 
    MenuPage.Visible = false; HomePage.Visible = true; task.wait(0.5)
    HMInfo.Text = "⚠️ Lỗi: Farm Bone thất bại!"; HMInfo.TextColor3 = Color3.fromRGB(255, 80, 80)
end)

-- RGB Cycle
task.spawn(function() while MainFrame.Parent do Grad.Rotation += 1.5; task.wait(0.02) end end)

-- Kéo UI
local dgg, dSt, sPs
MainFrame.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dgg = true; dSt = i.Position; sPs = MainFrame.Position end end)
UserInputService.InputChanged:Connect(function(i) if dgg and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then local d = i.Position - dSt; MainFrame.Position = UDim2.new(sPs.X.Scale, sPs.X.Offset + d.X, sPs.Y.Scale, sPs.Y.Offset + d.Y) end end)
UserInputService.InputEnded:Connect(function() dgg = false end)
