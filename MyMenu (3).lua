-- MY MENU V2.0
-- Key System -> Loading Screen -> GUI
-- Touch + Mouse draggable

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("MyMenu") then
    PlayerGui.MyMenu:Destroy()
end

-- =====================
--   ILAGAY MO DITO
--   YUNG TAMANG KEY
-- =====================
local CORRECT_KEY = "MYKEY-2024"
local LOADING_IMAGE_ID = "rbxassetid://112389474191810"

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MyMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 10
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = PlayerGui

-- =====================
--      KEY BOX
-- =====================

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(1, 0, 1, 0)
KeyFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
KeyFrame.BorderSizePixel = 0
KeyFrame.ZIndex = 30
KeyFrame.Parent = ScreenGui

-- Falling dots sa key screen
local keyDots = {}
for i = 1, 40 do
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, math.random(2, 5), 0, math.random(2, 5))
    dot.BackgroundColor3 = Color3.new(1, 1, 1)
    dot.BackgroundTransparency = math.random(30, 70) / 100
    dot.BorderSizePixel = 0
    dot.ZIndex = 31
    dot.Active = false
    dot.Selectable = false
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
    dot.Parent = KeyFrame
    keyDots[i] = {
        frame = dot,
        speedY = math.random(40, 100) / 100,
        speedX = math.random(-15, 15) / 100,
        posX = math.random(),
        posY = math.random(),
    }
end

-- Key window box
local KeyBox = Instance.new("Frame")
KeyBox.Size = UDim2.new(0, 280, 0, 168)
KeyBox.Position = UDim2.new(0.5, -140, 0.5, -84)
KeyBox.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
KeyBox.BorderSizePixel = 0
KeyBox.ZIndex = 32
KeyBox.Parent = KeyFrame
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 8)
local kbs = Instance.new("UIStroke", KeyBox)
kbs.Color = Color3.fromRGB(68, 68, 68)
kbs.Thickness = 1.5

-- Key box title bar
local KeyTitleBar = Instance.new("Frame")
KeyTitleBar.Size = UDim2.new(1, 0, 0, 36)
KeyTitleBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
KeyTitleBar.BorderSizePixel = 0
KeyTitleBar.ZIndex = 33
KeyTitleBar.Parent = KeyBox
Instance.new("UICorner", KeyTitleBar).CornerRadius = UDim.new(0, 8)
local kTitleFix = Instance.new("Frame")
kTitleFix.Size = UDim2.new(1, 0, 0.5, 0)
kTitleFix.Position = UDim2.new(0, 0, 0.5, 0)
kTitleFix.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
kTitleFix.BorderSizePixel = 0
kTitleFix.ZIndex = 33
kTitleFix.Parent = KeyTitleBar
local kts = Instance.new("UIStroke", KeyTitleBar)
kts.Color = Color3.fromRGB(68, 68, 68)
kts.Thickness = 1.5

local KeyTitleLabel = Instance.new("TextLabel")
KeyTitleLabel.Text = "ENTER KEY"
KeyTitleLabel.Size = UDim2.new(1, -50, 1, 0)
KeyTitleLabel.Position = UDim2.new(0, 38, 0, 0)
KeyTitleLabel.BackgroundTransparency = 1
KeyTitleLabel.TextColor3 = Color3.new(1, 1, 1)
KeyTitleLabel.TextSize = 13
KeyTitleLabel.Font = Enum.Font.GothamBold
KeyTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
KeyTitleLabel.ZIndex = 34
KeyTitleLabel.Parent = KeyTitleBar

-- =====================
--   LOGO (palitan mo yung asset ID mo)
-- =====================
local LogoImage = Instance.new("ImageLabel")
LogoImage.Size = UDim2.new(0, 26, 0, 26)
LogoImage.Position = UDim2.new(0, 5, 0.5, -13)
LogoImage.BackgroundTransparency = 1
LogoImage.Image = "rbxassetid://0" -- << PALITAN MO NG SARILI MONG LOGO ASSET ID
LogoImage.ScaleType = Enum.ScaleType.Fit
LogoImage.ZIndex = 35
LogoImage.Parent = KeyTitleBar
Instance.new("UICorner", LogoImage).CornerRadius = UDim.new(0, 4)

-- Instruction label
local InstructLabel = Instance.new("TextLabel")
InstructLabel.Text = "Enter your key to continue"
InstructLabel.Size = UDim2.new(1, -20, 0, 18)
InstructLabel.Position = UDim2.new(0, 10, 0, 44)
InstructLabel.BackgroundTransparency = 1
InstructLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
InstructLabel.TextSize = 11
InstructLabel.Font = Enum.Font.Gotham
InstructLabel.ZIndex = 33
InstructLabel.Parent = KeyBox

-- Key input box
local InputBG = Instance.new("Frame")
InputBG.Size = UDim2.new(1, -30, 0, 34)
InputBG.Position = UDim2.new(0, 15, 0, 68)
InputBG.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
InputBG.BorderSizePixel = 0
InputBG.ZIndex = 33
InputBG.Parent = KeyBox
Instance.new("UICorner", InputBG).CornerRadius = UDim.new(0, 6)
local ibs = Instance.new("UIStroke", InputBG)
ibs.Color = Color3.fromRGB(85, 85, 85)
ibs.Thickness = 1

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(1, -16, 1, 0)
KeyInput.Position = UDim2.new(0, 8, 0, 0)
KeyInput.BackgroundTransparency = 1
KeyInput.TextColor3 = Color3.new(1, 1, 1)
KeyInput.PlaceholderText = "Enter key here..."
KeyInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
KeyInput.TextSize = 13
KeyInput.Font = Enum.Font.GothamSemibold
KeyInput.TextXAlignment = Enum.TextXAlignment.Left
KeyInput.ClearTextOnFocus = false
KeyInput.ZIndex = 34
KeyInput.Parent = InputBG

-- Submit button
local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Text = "SUBMIT"
SubmitBtn.Size = UDim2.new(1, -30, 0, 30)
SubmitBtn.Position = UDim2.new(0, 15, 0, 110)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
SubmitBtn.TextColor3 = Color3.fromRGB(204, 204, 204)
SubmitBtn.TextSize = 13
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.BorderSizePixel = 0
SubmitBtn.ZIndex = 33
SubmitBtn.Parent = KeyBox
Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 6)
local sbs = Instance.new("UIStroke", SubmitBtn)
sbs.Color = Color3.fromRGB(85, 85, 85)
sbs.Thickness = 1

-- Error/Status label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Text = ""
StatusLabel.Size = UDim2.new(1, -20, 0, 16)
StatusLabel.Position = UDim2.new(0, 10, 1, -20)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
StatusLabel.TextSize = 11
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.ZIndex = 33
StatusLabel.Parent = KeyBox

-- =====================
--    LOADING SCREEN
-- =====================

local LoadFrame = Instance.new("Frame")
LoadFrame.Size = UDim2.new(1, 0, 1, 0)
LoadFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
LoadFrame.BorderSizePixel = 0
LoadFrame.ZIndex = 20
LoadFrame.Visible = false
LoadFrame.Parent = ScreenGui

local BgImage = Instance.new("ImageLabel")
BgImage.Size = UDim2.new(1, 0, 1, 0)
BgImage.BackgroundTransparency = 1
BgImage.Image = LOADING_IMAGE_ID
BgImage.ScaleType = Enum.ScaleType.Crop
BgImage.ZIndex = 21
BgImage.Parent = LoadFrame

local Overlay = Instance.new("Frame")
Overlay.Size = UDim2.new(1, 0, 1, 0)
Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Overlay.BackgroundTransparency = 0.45
Overlay.BorderSizePixel = 0
Overlay.ZIndex = 22
Overlay.Parent = LoadFrame

local loadDots = {}
for i = 1, 50 do
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, math.random(2, 5), 0, math.random(2, 5))
    dot.BackgroundColor3 = Color3.new(1, 1, 1)
    dot.BackgroundTransparency = math.random(30, 70) / 100
    dot.BorderSizePixel = 0
    dot.ZIndex = 23
    dot.Active = false
    dot.Selectable = false
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
    dot.Parent = LoadFrame
    loadDots[i] = {
        frame = dot,
        speedY = math.random(40, 100) / 100,
        speedX = math.random(-15, 15) / 100,
        posX = math.random(),
        posY = math.random(),
    }
end

local function makeLine(yPos, thickness, alpha)
    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, 0, 0, thickness or 1)
    line.Position = UDim2.new(0, 0, yPos, 0)
    line.BackgroundColor3 = Color3.new(1, 1, 1)
    line.BackgroundTransparency = alpha or 0.6
    line.BorderSizePixel = 0
    line.ZIndex = 23
    line.Parent = LoadFrame
end
makeLine(0.68, 1, 0.5)
makeLine(0.70, 2, 0.3)

local MenuLabel = Instance.new("TextLabel")
MenuLabel.Text = "MY MENU V2.0"
MenuLabel.Size = UDim2.new(1, 0, 0, 30)
MenuLabel.Position = UDim2.new(0, 0, 0.08, 0)
MenuLabel.BackgroundTransparency = 1
MenuLabel.TextColor3 = Color3.new(1, 1, 1)
MenuLabel.TextSize = 18
MenuLabel.Font = Enum.Font.GothamBold
MenuLabel.TextTransparency = 1
MenuLabel.ZIndex = 24
MenuLabel.Parent = LoadFrame

local BarBG = Instance.new("Frame")
BarBG.Size = UDim2.new(0.6, 0, 0, 5)
BarBG.Position = UDim2.new(0.2, 0, 0.76, 0)
BarBG.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
BarBG.BorderSizePixel = 0
BarBG.ZIndex = 24
BarBG.Parent = LoadFrame
Instance.new("UICorner", BarBG).CornerRadius = UDim.new(1, 0)

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.new(1, 1, 1)
BarFill.BorderSizePixel = 0
BarFill.ZIndex = 25
BarFill.Parent = BarBG
Instance.new("UICorner", BarFill).CornerRadius = UDim.new(1, 0)

local PctLabel = Instance.new("TextLabel")
PctLabel.Text = "0%"
PctLabel.Size = UDim2.new(0.6, 0, 0, 20)
PctLabel.Position = UDim2.new(0.2, 0, 0.80, 0)
PctLabel.BackgroundTransparency = 1
PctLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
PctLabel.TextSize = 13
PctLabel.Font = Enum.Font.Gotham
PctLabel.TextTransparency = 1
PctLabel.ZIndex = 24
PctLabel.Parent = LoadFrame

local LoadingLabel = Instance.new("TextLabel")
LoadingLabel.Text = "Loading..."
LoadingLabel.Size = UDim2.new(0.6, 0, 0, 20)
LoadingLabel.Position = UDim2.new(0.2, 0, 0.72, 0)
LoadingLabel.BackgroundTransparency = 1
LoadingLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
LoadingLabel.TextSize = 12
LoadingLabel.Font = Enum.Font.Gotham
LoadingLabel.TextTransparency = 1
LoadingLabel.ZIndex = 24
LoadingLabel.Parent = LoadFrame

-- =====================
--      MAIN GUI
-- =====================

local Window = Instance.new("Frame")
Window.Name = "Window"
Window.Size = UDim2.new(0, 500, 0, 360)
Window.Position = UDim2.new(0, 100, 0, 100)
Window.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
Window.BorderSizePixel = 0
Window.ZIndex = 2
Window.Visible = false
Window.Parent = ScreenGui
Instance.new("UICorner", Window).CornerRadius = UDim.new(0, 6)
local ws = Instance.new("UIStroke", Window)
ws.Color = Color3.fromRGB(68, 68, 68)
ws.Thickness = 1.5

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 34)
TitleBar.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 3
TitleBar.Parent = Window
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 6)
local TitleFix = Instance.new("Frame")
TitleFix.Size = UDim2.new(1, 0, 0.5, 0)
TitleFix.Position = UDim2.new(0, 0, 0.5, 0)
TitleFix.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
TitleFix.BorderSizePixel = 0
TitleFix.ZIndex = 3
TitleFix.Parent = TitleBar
local ts2 = Instance.new("UIStroke", TitleBar)
ts2.Color = Color3.fromRGB(68, 68, 68)
ts2.Thickness = 1.5

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Text = "MY MENU V2.0"
TitleLabel.Size = UDim2.new(1, -40, 1, 0)
TitleLabel.Position = UDim2.new(0, 12, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.TextSize = 13
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 4
TitleLabel.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 30, 0, 24)
CloseBtn.Position = UDim2.new(1, -36, 0.5, -12)
CloseBtn.BackgroundTransparency = 1
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.ZIndex = 5
CloseBtn.Parent = TitleBar
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local Body = Instance.new("Frame")
Body.Size = UDim2.new(1, -20, 1, -44)
Body.Position = UDim2.new(0, 10, 0, 38)
Body.BackgroundTransparency = 1
Body.ZIndex = 3
Body.Parent = Window

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 90, 1, 0)
Sidebar.BackgroundTransparency = 1
Sidebar.ZIndex = 3
Sidebar.Parent = Body

local MainTab = Instance.new("TextButton")
MainTab.Text = "Main"
MainTab.Size = UDim2.new(1, 0, 0, 30)
MainTab.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainTab.TextColor3 = Color3.fromRGB(204, 204, 204)
MainTab.TextSize = 12
MainTab.Font = Enum.Font.Gotham
MainTab.BorderSizePixel = 0
MainTab.ZIndex = 4
MainTab.Parent = Sidebar
Instance.new("UICorner", MainTab).CornerRadius = UDim.new(0, 5)
local mts = Instance.new("UIStroke", MainTab)
mts.Color = Color3.fromRGB(85, 85, 85)
mts.Thickness = 1

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -100, 1, 0)
ScrollFrame.Position = UDim2.new(0, 100, 0, 0)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 5
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(68, 68, 68)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.ZIndex = 3
ScrollFrame.Parent = Body

local ListLayout = Instance.new("UIListLayout")
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim.new(0, 6)
ListLayout.Parent = ScrollFrame

local scripts = {
    {name = "Script One"},
    {name = "Script Two"},
    {name = "Script Three"},
    {name = "Script Four"},
    {name = "Script Five"},
    {name = "Script Six"},
    {name = "Script Seven"},
    {name = "Script Eight"},
    {name = "Script Nine"},
    {name = "Script Ten"},
}

for i, s in ipairs(scripts) do
    local Btn = Instance.new("TextButton")
    Btn.Text = s.name
    Btn.Size = UDim2.new(1, -4, 0, 32)
    Btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Btn.TextColor3 = Color3.fromRGB(204, 204, 204)
    Btn.TextSize = 12
    Btn.Font = Enum.Font.GothamSemibold
    Btn.BorderSizePixel = 0
    Btn.LayoutOrder = i
    Btn.ZIndex = 4
    Btn.Parent = ScrollFrame
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 5)
    local bs = Instance.new("UIStroke", Btn)
    bs.Color = Color3.fromRGB(85, 85, 85)
    bs.Thickness = 1
    Btn.MouseButton1Click:Connect(function()
        -- loadstring(game:HttpGet("YOUR_URL_HERE"))()
    end)
    Btn.MouseEnter:Connect(function() Btn.TextColor3 = Color3.new(1,1,1) end)
    Btn.MouseLeave:Connect(function() Btn.TextColor3 = Color3.fromRGB(204,204,204) end)
end

-- Main GUI dots (nasa harap)
local Canvas = Instance.new("Frame")
Canvas.Size = UDim2.new(1, 0, 1, 0)
Canvas.BackgroundTransparency = 1
Canvas.ZIndex = 10
Canvas.Visible = false
Canvas.Parent = ScreenGui

local dots = {}
for i = 1, 40 do
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, math.random(2, 4), 0, math.random(2, 4))
    dot.BackgroundColor3 = Color3.new(1, 1, 1)
    dot.BackgroundTransparency = math.random(40, 75) / 100
    dot.BorderSizePixel = 0
    dot.ZIndex = 10
    dot.Active = false
    dot.Selectable = false
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
    dot.Parent = Canvas
    dots[i] = {
        frame = dot,
        speedY = math.random(30, 80) / 100,
        speedX = math.random(-10, 10) / 100,
        posX = math.random(),
        posY = math.random(),
    }
end

-- =====================
--   HEARTBEAT LOOP
-- =====================
local keyActive = true
local loadingActive = false

RunService.Heartbeat:Connect(function(dt)
    -- Key screen dots
    if keyActive then
        for _, d in ipairs(keyDots) do
            d.posY += d.speedY * dt
            d.posX += d.speedX * dt
            if d.posY > 1 then d.posY = -0.02 d.posX = math.random() end
            if d.posX < 0 then d.posX = 1 end
            if d.posX > 1 then d.posX = 0 end
            d.frame.Position = UDim2.new(d.posX, 0, d.posY, 0)
        end
    end
    -- Loading screen dots
    if loadingActive then
        for _, d in ipairs(loadDots) do
            d.posY += d.speedY * dt
            d.posX += d.speedX * dt
            if d.posY > 1 then d.posY = -0.02 d.posX = math.random() end
            if d.posX < 0 then d.posX = 1 end
            if d.posX > 1 then d.posX = 0 end
            d.frame.Position = UDim2.new(d.posX, 0, d.posY, 0)
        end
    end
    -- Main GUI dots
    for _, d in ipairs(dots) do
        d.posY += d.speedY * dt
        d.posX += d.speedX * dt
        if d.posY > 1 then d.posY = -0.02 d.posX = math.random() end
        if d.posX < 0 then d.posX = 1 end
        if d.posX > 1 then d.posX = 0 end
        d.frame.Position = UDim2.new(d.posX, 0, d.posY, 0)
    end
end)

-- =====================
--   LOADING SEQUENCE
-- =====================
local function startLoading()
    loadingActive = true
    LoadFrame.Visible = true

    task.wait(0.3)
    TweenService:Create(MenuLabel, TweenInfo.new(0.7), {TextTransparency = 0}):Play()
    TweenService:Create(LoadingLabel, TweenInfo.new(0.7), {TextTransparency = 0}):Play()
    TweenService:Create(PctLabel, TweenInfo.new(0.7), {TextTransparency = 0}):Play()
    task.wait(0.8)

    for i = 1, 100 do
        BarFill.Size = UDim2.new(i / 100, 0, 1, 0)
        PctLabel.Text = i .. "%"
        task.wait(0.025)
    end

    task.wait(0.4)

    TweenService:Create(MenuLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(LoadingLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(PctLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(BgImage, TweenInfo.new(0.6), {ImageTransparency = 1}):Play()
    TweenService:Create(Overlay, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    TweenService:Create(LoadFrame, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    for _, d in ipairs(loadDots) do
        TweenService:Create(d.frame, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
    end

    task.wait(0.7)
    loadingActive = false
    LoadFrame:Destroy()

    Window.Visible = true
    Canvas.Visible = true
    Window.BackgroundTransparency = 1
    TweenService:Create(Window, TweenInfo.new(0.4), {BackgroundTransparency = 0}):Play()
end

-- =====================
--   KEY SUBMIT LOGIC
-- =====================
local function checkKey()
    local entered = KeyInput.Text
    if entered == CORRECT_KEY then
        -- Correct! fade out key screen then start loading
        StatusLabel.Text = "✓ Key accepted!"
        StatusLabel.TextColor3 = Color3.fromRGB(80, 255, 120)
        task.wait(0.6)
        keyActive = false
        TweenService:Create(KeyFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        for _, d in ipairs(keyDots) do
            TweenService:Create(d.frame, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
        end
        TweenService:Create(KeyBox, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
        task.wait(0.6)
        KeyFrame:Destroy()
        task.spawn(startLoading)
    else
        -- Wrong key
        StatusLabel.Text = "✗ Invalid key. Try again."
        StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        -- Shake effect
        local origPos = KeyBox.Position
        for _ = 1, 4 do
            TweenService:Create(KeyBox, TweenInfo.new(0.05), {Position = UDim2.new(0.5, -158, 0.5, -110)}):Play()
            task.wait(0.05)
            TweenService:Create(KeyBox, TweenInfo.new(0.05), {Position = UDim2.new(0.5, -182, 0.5, -110)}):Play()
            task.wait(0.05)
        end
        TweenService:Create(KeyBox, TweenInfo.new(0.05), {Position = origPos}):Play()
    end
end

SubmitBtn.MouseButton1Click:Connect(function()
    task.spawn(checkKey)
end)

-- Also submit on Enter key
KeyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        task.spawn(checkKey)
    end
end)

-- Hover effect on submit
SubmitBtn.MouseEnter:Connect(function()
    SubmitBtn.TextColor3 = Color3.new(1, 1, 1)
end)
SubmitBtn.MouseLeave:Connect(function()
    SubmitBtn.TextColor3 = Color3.fromRGB(204, 204, 204)
end)

-- =====================
--   DRAG HELPER (MONSY-style)
-- =====================
local function makeDraggable(handle, target)
    local dragToggle = false
    local dragInput, dragStart, startPos

    local function updateDrag(input)
        local delta = input.Position - dragStart
        -- Pinopreserve ang Scale (gaya ng MONSY) para hindi mag-jump
        -- kahit may 0.5 scale sa starting position (e.g. KeyBox)
        target.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragToggle = true
            dragStart = input.Position
            startPos = target.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                end
            end)
        end
    end)

    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragToggle then
            updateDrag(input)
        end
    end)
end

-- Apply drag to KeyBox and main Window
makeDraggable(KeyTitleBar, KeyBox)
makeDraggable(TitleBar, Window)
