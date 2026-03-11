-- GARAPALINO MAIN LOADER
-- Flow: Key System → Loading Screen → Main Menu

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
local guiParent = pcall(function() return gethui() end) and gethui() or game:GetService("CoreGui")

-- ============================================
-- I-EDIT MO ITO:
local WEBHOOK_URL = "https://discord.com/api/webhooks/1454399922727288948/aHS4swfROrV0teDiyNmk-IcRF7O1S-hCNxY2461Js5ZZ_-d9E6jdr8gcNGxq8D23alMb"
local MAIN_SCRIPT_URL = "https://raw.githubusercontent.com/secret663/secret/refs/heads/main/MAISAN_MENU.lua"

local ValidKeys = {
    ["GARAPALINO-XXXX-XXXX-XXXX"] = true,
    ["GARAPALINO-YYYY-YYYY-YYYY"] = true,
    -- Dagdag ka pa ng keys dito
}
-- ============================================

-- SEND LOG
local function sendLog(status, key)
    local emoji = status == "VALID" and "✅" or "❌"
    local message = emoji .. " **Key " .. status .. "**\n" ..
                   "**Player:** " .. player.Name .. "\n" ..
                   "**Key Used:** `" .. key .. "`"
    local data = HttpService:JSONEncode({ content = message })
    pcall(function()
        if syn and syn.request then
            syn.request({ Url = WEBHOOK_URL, Method = "POST", Headers = { ["Content-Type"] = "application/json" }, Body = data })
        elseif http and http.request then
            http.request({ Url = WEBHOOK_URL, Method = "POST", Headers = { ["Content-Type"] = "application/json" }, Body = data })
        elseif request then
            request({ Url = WEBHOOK_URL, Method = "POST", Headers = { ["Content-Type"] = "application/json" }, Body = data })
        end
    end)
end

-- ============================================
-- LOADING SCREEN FUNCTION
-- ============================================
local function showLoadingScreen()
    if guiParent:FindFirstChild("GARAPALINO_LOADING") then
        guiParent["GARAPALINO_LOADING"]:Destroy()
    end

    local gui = Instance.new("ScreenGui")
    gui.Name = "GARAPALINO_LOADING"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = guiParent

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1,0,1,0)
    bg.BackgroundColor3 = Color3.new(0,0,0)
    bg.BorderSizePixel = 0
    bg.Parent = gui

    -- Falling Particles
    task.spawn(function()
        while gui.Parent do
            local particle = Instance.new("Frame")
            particle.Size = UDim2.new(0, math.random(2,5), 0, math.random(2,5))
            particle.Position = UDim2.new(math.random(), 0, -0.05, 0)
            particle.BackgroundColor3 = Color3.new(1,1,1)
            particle.BorderSizePixel = 0
            particle.BackgroundTransparency = math.random(0,3)/10
            particle.Parent = bg
            local fall = TweenService:Create(particle, TweenInfo.new(math.random(4,7), Enum.EasingStyle.Linear), {
                Position = UDim2.new(particle.Position.X.Scale, 0, 1.1, 0),
                BackgroundTransparency = 1
            })
            fall:Play()
            game:GetService("Debris"):AddItem(particle, 7)
            task.wait(0.1)
        end
    end)

    -- Title
    local title = Instance.new("TextLabel")
    title.AnchorPoint = Vector2.new(0.5,0)
    title.Position = UDim2.new(0.5,0,0.05,0)
    title.Size = UDim2.new(0,600,0,40)
    title.BackgroundTransparency = 1
    title.Text = "GARAPALINO MENU"
    title.TextColor3 = Color3.fromRGB(255,204,0)
    title.Font = Enum.Font.GothamBold
    title.TextScaled = true
    title.Parent = bg

    -- Logo
    local logo = Instance.new("ImageLabel")
    logo.AnchorPoint = Vector2.new(0.5,0.5)
    logo.Position = UDim2.new(0.5,0,0.40,0)
    logo.Size = UDim2.new(0,600,0,300)
    logo.BackgroundTransparency = 1
    logo.Image = "rbxassetid://98746235175965"
    logo.ScaleType = Enum.ScaleType.Fit
    local logoCorner = Instance.new("UICorner")
    logoCorner.CornerRadius = UDim.new(0.05,0)
    logoCorner.Parent = logo
    logo.Parent = bg

    -- Button Frame
    local btnFrame = Instance.new("Frame")
    btnFrame.AnchorPoint = Vector2.new(0.5,0)
    btnFrame.Position = UDim2.new(0.5,0,0.65,0)
    btnFrame.Size = UDim2.new(0,300,0,40)
    btnFrame.BackgroundTransparency = 1
    btnFrame.Parent = bg

    -- Button
    local nameBtn = Instance.new("TextButton")
    nameBtn.Size = UDim2.new(0,120,0,40)
    nameBtn.Position = UDim2.new(0,0,0,0)
    nameBtn.Text = "GARAPALINO"
    nameBtn.TextColor3 = Color3.fromRGB(255,204,0)
    nameBtn.Font = Enum.Font.GothamBold
    nameBtn.TextSize = 16
    nameBtn.BackgroundColor3 = Color3.new(0,0,0)
    nameBtn.BorderSizePixel = 0
    nameBtn.Parent = btnFrame
    local btnCorner2 = Instance.new("UICorner")
    btnCorner2.CornerRadius = UDim.new(0.2,0)
    btnCorner2.Parent = nameBtn
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Color3.fromRGB(255,204,0)
    btnStroke.Thickness = 2
    btnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    btnStroke.Parent = nameBtn

    -- Timer
    local timerLabel = Instance.new("TextLabel")
    timerLabel.Size = UDim2.new(0,120,0,40)
    timerLabel.Position = UDim2.new(0,140,0,0)
    timerLabel.BackgroundTransparency = 1
    timerLabel.TextColor3 = Color3.fromRGB(255,204,0)
    timerLabel.Font = Enum.Font.Code
    timerLabel.TextSize = 16
    timerLabel.Text = "00 : 00 : 00"
    timerLabel.Parent = btnFrame

    -- Line
    local line = Instance.new("Frame")
    line.AnchorPoint = Vector2.new(0.5,0)
    line.Position = UDim2.new(0.5,0,0.78,0)
    line.Size = UDim2.new(0.9,0,0,2)
    line.BackgroundColor3 = Color3.fromRGB(255,204,0)
    line.BorderSizePixel = 0
    line.Parent = bg

    -- Info
    local info = Instance.new("TextLabel")
    info.AnchorPoint = Vector2.new(0.5,0)
    info.Position = UDim2.new(0.5,0,0.78,5)
    info.Size = UDim2.new(0.95,0,0,200)
    info.BackgroundTransparency = 1
    info.TextColor3 = Color3.fromRGB(255,204,0)
    info.Font = Enum.Font.Code
    info.TextSize = 18
    info.TextXAlignment = Enum.TextXAlignment.Center
    info.TextYAlignment = Enum.TextYAlignment.Top
    info.TextWrapped = true
    info.Text = "Welcome, " .. player.Name .. "!"
    info.Parent = bg

    -- Sound
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://120022678700380"
    sound.Volume = 1
    sound.Looped = true
    sound.Parent = bg
    sound:Play()

    -- Countdown then load main script
    local sec = 0
    local totalTime = 30
    task.spawn(function()
        while gui.Parent and sec <= totalTime do
            task.wait(1)
            sec += 1
            local mins = math.floor(sec / 60)
            local s = sec % 60
            timerLabel.Text = string.format("00 : %02d : %02d", mins, s)
        end
        if gui and gui.Parent then
            gui:Destroy()
        end
        -- Load main script after loading screen
        pcall(function()
            loadstring(game:HttpGet(MAIN_SCRIPT_URL))()
        end)
    end)
end

-- ============================================
-- KEY SYSTEM GUI
-- ============================================
if guiParent:FindFirstChild("GARAPALINO_KEY") then
    guiParent["GARAPALINO_KEY"]:Destroy()
end

local keyGui = Instance.new("ScreenGui")
keyGui.Name = "GARAPALINO_KEY"
keyGui.IgnoreGuiInset = true
keyGui.ResetOnSpawn = false
keyGui.Parent = guiParent

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 380, 0, 220)
frame.Position = UDim2.new(0.5, -190, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.BorderSizePixel = 0
frame.Active = true
frame.Parent = keyGui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local frameStroke = Instance.new("UIStroke")
frameStroke.Color = Color3.fromRGB(255, 204, 0)
frameStroke.Thickness = 1.5
frameStroke.Parent = frame

-- Draggable
local dragging, dragInput, dragStart, startPos
frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
end)
UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Title
local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 50)
keyTitle.Position = UDim2.new(0, 0, 0, 10)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "🔐 GARAPALINO KEY SYSTEM"
keyTitle.TextColor3 = Color3.fromRGB(255, 204, 0)
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextSize = 18
keyTitle.Parent = frame

-- Key Input
local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0.85, 0, 0, 42)
keyBox.Position = UDim2.new(0.075, 0, 0, 70)
keyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
keyBox.BorderSizePixel = 0
keyBox.PlaceholderText = "Enter key here..."
keyBox.Text = ""
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 14
keyBox.ClearTextOnFocus = false
keyBox.Parent = frame
Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 8)
local inputStroke = Instance.new("UIStroke")
inputStroke.Color = Color3.fromRGB(255, 204, 0)
inputStroke.Thickness = 1.5
inputStroke.Parent = keyBox

-- Status
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 25)
statusLabel.Position = UDim2.new(0, 0, 0, 120)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = ""
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 13
statusLabel.Parent = frame

-- Verify Button
local verifyBtn = Instance.new("TextButton")
verifyBtn.Size = UDim2.new(0.85, 0, 0, 42)
verifyBtn.Position = UDim2.new(0.075, 0, 0, 155)
verifyBtn.BackgroundColor3 = Color3.fromRGB(255, 204, 0)
verifyBtn.BorderSizePixel = 0
verifyBtn.Text = "VERIFY KEY"
verifyBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
verifyBtn.Font = Enum.Font.GothamBold
verifyBtn.TextSize = 16
verifyBtn.Parent = frame
Instance.new("UICorner", verifyBtn).CornerRadius = UDim.new(0, 8)

-- Verify Logic
verifyBtn.MouseButton1Click:Connect(function()
    local key = keyBox.Text

    if key == "" then
        statusLabel.Text = "⚠️ Ilagay mo muna ang key!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
        return
    end

    verifyBtn.Text = "CHECKING..."
    statusLabel.Text = ""
    task.wait(1)

    if ValidKeys[key] then
        statusLabel.Text = "✅ Valid Key! Loading..."
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
        verifyBtn.Text = "SUCCESS!"
        verifyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)

        sendLog("VALID", key)

        task.wait(1.5)
        keyGui:Destroy()

        -- Show loading screen
        showLoadingScreen()

    else
        statusLabel.Text = "❌ Invalid Key!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
        verifyBtn.Text = "VERIFY KEY"
        verifyBtn.BackgroundColor3 = Color3.fromRGB(255, 204, 0)

        sendLog("INVALID", key)

        task.wait(2)
        statusLabel.Text = ""
    end
end)
