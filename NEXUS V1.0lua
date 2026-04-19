local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("Nexus") then
    PlayerGui.Nexus:Destroy()
end

-- Helper function used throughout the script
local function new(className, props)
    local inst = Instance.new(className)
    if props then
        for k, v in pairs(props) do
            if k ~= "Parent" then
                inst[k] = v
            end
        end
        if props.Parent then
            inst.Parent = props.Parent
        end
    end
    return inst
end

local LOADING_IMAGE_ID = "rbxassetid://131479970593569"

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Nexus"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 10
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = PlayerGui

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
MenuLabel.Text = "NEXUS V1.0"
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
TitleLabel.Text = "NEXUS V1.0"
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


-- =====================
--   BUTTON HELPER (MONSY-style)
-- =====================
local function addBtn(text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Text = text
    Btn.Size = UDim2.new(1, -4, 0, 32)
    Btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Btn.TextColor3 = Color3.fromRGB(204, 204, 204)
    Btn.TextSize = 12
    Btn.Font = Enum.Font.GothamSemibold
    Btn.BorderSizePixel = 0
    Btn.ZIndex = 4
    Btn.Parent = ScrollFrame
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 5)
    local bs = Instance.new("UIStroke", Btn)
    bs.Color = Color3.fromRGB(85, 85, 85)
    bs.Thickness = 1
    Btn.MouseButton1Click:Connect(function()
        if callback then task.spawn(callback) end
    end)
    Btn.MouseEnter:Connect(function() Btn.TextColor3 = Color3.new(1,1,1) end)
    Btn.MouseLeave:Connect(function() Btn.TextColor3 = Color3.fromRGB(204,204,204) end)
end

addBtn("INFINITE YIELD (MONSY)", function()

	loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()

end) 



addBtn("MUSIC EXPLOITS (MONSY)", function()

	-- NEXUS CMD - Minimal FE Audio Player (White Font Update)

local CoreGui = game:GetService("CoreGui")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Workspace = game:GetService("Workspace")

local InjectTo = game:GetService("TestService")



-- Find RemoteEvent

local function findRemote()

	for _, v in ipairs(ReplicatedStorage:GetDescendants()) do

		if v:IsA("RemoteEvent") and v.Name == "AC6_FE_Sounds" then

			return v

		end

	end

	for _, v in ipairs(Workspace:GetDescendants()) do

		if v:IsA("RemoteEvent") and v.Name == "AC6_FE_Sounds" then

			return v

		end

	end

	return nil

end



local remote = findRemote()



-- GUI

local gui = Instance.new("ScreenGui", CoreGui)

gui.Name = "NEXUS_CMD_GUI"

gui.ResetOnSpawn = false



local main = Instance.new("Frame", gui)

main.Size = UDim2.new(0, 300, 0, 120)

main.Position = UDim2.new(0.5, -150, 0.5, -60)

main.BackgroundColor3 = Color3.fromRGB(255,255,255)

main.BorderSizePixel = 0

main.Active = true

main.Draggable = true

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)



local title = Instance.new("TextLabel", main)

title.Size = UDim2.new(1, 0, 0.25, 0)

title.Position = UDim2.new(0, 0, 0, 0)

title.Text = "NEXUS MUSIC EXPLOITS"

title.TextColor3 = Color3.fromRGB(0,0,0) -- White

title.BackgroundTransparency = 1

title.Font = Enum.Font.SourceSansBold

title.TextSize = 22



local inputBox = Instance.new("TextBox", main)

inputBox.Size = UDim2.new(0.9, 0, 0.25, 0)

inputBox.Position = UDim2.new(0.05, 0, 0.35, 0)

inputBox.PlaceholderText = "Enter Music ID [NEXUS]"

inputBox.Text = ""

inputBox.TextColor3 = Color3.fromRGB(0,0,0)

inputBox.BackgroundColor3 = Color3.fromRGB(255,255,255)

inputBox.Font = Enum.Font.SourceSansBold

inputBox.TextSize = 18

inputBox.ClearTextOnFocus = false



local toggleButton = Instance.new("TextButton", main)

toggleButton.Size = UDim2.new(0.5, 0, 0.2, 0)

toggleButton.Position = UDim2.new(0.25, 0, 0.7, 0)

toggleButton.Text = "OFF"

toggleButton.TextColor3 = Color3.fromRGB(0,0,0) -- White

toggleButton.BackgroundTransparency = 1

toggleButton.Font = Enum.Font.SourceSansBold

toggleButton.TextSize = 24



local isOn = false

local soundName = "TG_SOUND_" .. tostring(math.random(1000,9999))



toggleButton.MouseButton1Click:Connect(function()

	isOn = not isOn

	if isOn then

		toggleButton.Text = "ON"



		local id = inputBox.Text

		if id == "" then

			warn("No music ID entered")

			return

		end



		if remote then

			pcall(function()

				remote:FireServer("newSound", soundName, InjectTo, "rbxassetid://" .. id, 1, 1, true, 0)

				remote:FireServer("playSound", soundName)

			end)

		else

			warn("AC6 RemoteEvent not found")

		end

	else

		toggleButton.Text = "OFF"



		if remote then

			pcall(function()

				remote:FireServer("stopSound", soundName)

			end)

		end

	end

end)

end)



addBtn("ESP PLAYER (MONSY)", function()

	--// Services

local Players = game:GetService("Players")

local RunService = game:GetService("RunService")

local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer



--// GUI Setup

local gui = Instance.new("ScreenGui")

gui.Name = "ESP_Toggle_GUI"

gui.ResetOnSpawn = false

gui.Parent = LocalPlayer:WaitForChild("PlayerGui")



local toggleButton = Instance.new("TextButton")

toggleButton.Size = UDim2.new(0, 100, 0, 35)

toggleButton.Position = UDim2.new(0, 20, 0, 120)

toggleButton.BackgroundColor3 = Color3.fromRGB(255,255,255)

toggleButton.TextColor3 = Color3.fromRGB(0,0,0)

toggleButton.Text = "ESP: ON"

toggleButton.Font = Enum.Font.GothamBold

toggleButton.TextSize = 14

toggleButton.Parent = gui



local corner = Instance.new("UICorner", toggleButton)

corner.CornerRadius = UDim.new(0, 6)



--// Toggle State

local ESP_ENABLED = true

local ESPObjects = {}



--// Drawing Helpers

local function newLine()

	local line = Drawing.new("Line")

	line.Thickness = 2

	line.Color = Color3.fromRGB(255, 255, 255) -- Changed to white

	line.Visible = true

	return line

end



local function newText()

	local text = Drawing.new("Text")

	text.Size = 14

	text.Color = Color3.fromRGB(255, 255, 255)

	text.Center = true

	text.Outline = true

	text.Visible = true

	return text

end



local function clearESP(player)

	if ESPObjects[player] then

		for _, obj in pairs(ESPObjects[player]) do

			if obj.Remove then obj:Remove() end

		end

		ESPObjects[player] = nil

	end

end



--// Get 2D screen position of 3D part

local function getPartPos(part)

	if not part then return nil, false end

	local pos, visible = Camera:WorldToViewportPoint(part.Position)

	return Vector2.new(pos.X, pos.Y), visible

end



--// ESP Rendering

RunService.RenderStepped:Connect(function()

	if not ESP_ENABLED then

		for _, v in pairs(ESPObjects) do

			for _, obj in pairs(v) do

				obj.Visible = false

			end

		end

		return

	end



	for _, player in ipairs(Players:GetPlayers()) do

		if player ~= LocalPlayer and player.Character then

			local char = player.Character

			local esp = ESPObjects[player]



			if not esp then

				esp = {

					HeadToTorso = newLine(),

					TorsoToLeftArm = newLine(),

					TorsoToRightArm = newLine(),

					TorsoToLeftLeg = newLine(),

					TorsoToRightLeg = newLine(),

					Name = newText(),

				}

				ESPObjects[player] = esp

			end



			local headPos, headVis = getPartPos(char:FindFirstChild("Head"))

			local torsoPos, torsoVis = getPartPos(char:FindFirstChild("HumanoidRootPart"))

			local laPos, laVis = getPartPos(char:FindFirstChild("LeftUpperArm") or char:FindFirstChild("Left Arm"))

			local raPos, raVis = getPartPos(char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm"))

			local llPos, llVis = getPartPos(char:FindFirstChild("LeftUpperLeg") or char:FindFirstChild("Left Leg"))

			local rlPos, rlVis = getPartPos(char:FindFirstChild("RightUpperLeg") or char:FindFirstChild("Right Leg"))



			if headVis and torsoVis then

				esp.HeadToTorso.From = headPos

				esp.HeadToTorso.To = torsoPos

				esp.HeadToTorso.Visible = true

			else

				esp.HeadToTorso.Visible = false

			end



			if torsoVis and laVis then

				esp.TorsoToLeftArm.From = torsoPos

				esp.TorsoToLeftArm.To = laPos

				esp.TorsoToLeftArm.Visible = true

			else

				esp.TorsoToLeftArm.Visible = false

			end



			if torsoVis and raVis then

				esp.TorsoToRightArm.From = torsoPos

				esp.TorsoToRightArm.To = raPos

				esp.TorsoToRightArm.Visible = true

			else

				esp.TorsoToRightArm.Visible = false

			end



			if torsoVis and llVis then

				esp.TorsoToLeftLeg.From = torsoPos

				esp.TorsoToLeftLeg.To = llPos

				esp.TorsoToLeftLeg.Visible = true

			else

				esp.TorsoToLeftLeg.Visible = false

			end



			if torsoVis and rlVis then

				esp.TorsoToRightLeg.From = torsoPos

				esp.TorsoToRightLeg.To = rlPos

				esp.TorsoToRightLeg.Visible = true

			else

				esp.TorsoToRightLeg.Visible = false

			end



			if headVis then

				esp.Name.Position = Vector2.new(headPos.X, headPos.Y - 20)

				esp.Name.Text = player.Name

				esp.Name.Visible = true

			else

				esp.Name.Visible = false

			end

		end

	end

end)



--// Player leave cleanup

Players.PlayerRemoving:Connect(function(player)

	clearESP(player)

end)



--// Toggle Button

toggleButton.MouseButton1Click:Connect(function()

	ESP_ENABLED = not ESP_ENABLED

	toggleButton.Text = ESP_ENABLED and "ESP: ON" or "ESP: OFF"

end)

end)



addBtn("BIG HEAD PLAYER (MONSY)", function()

	_G.HeadSize = 6 _G.Disabled = true game:GetService('RunService').RenderStepped:connect(function() if _G.Disabled then for i,v in next, game:GetService('Players'):GetPlayers() do if v.Name ~= game:GetService('Players').LocalPlayer.Name then pcall(function() v.Character.Head.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize) v.Character.Head.Transparency = 0.4 v.Character.Head.BrickColor = BrickColor.new("Red") v.Character.Head.Material = "Neon" v.Character.Head.CanCollide = false v.Character.Head.Massless = true end) end end end end)

end)



--// 8 Buttons in Main Menu

addBtn("KEYBIND Q TO FREECAM (MONSY)", function()

	-- Services

local Players = game:GetService("Players")

local UserInputService = game:GetService("UserInputService")

local RunService = game:GetService("RunService")



local player = Players.LocalPlayer

local cam = workspace.CurrentCamera



-- Settings

local MOVE_SPEED = 60

local SPRINT_MULTIPLIER = 2

local MOUSE_SENSITIVITY = 0.15

local MAX_PITCH = 89



-- State

local enabled = false

local yaw = 0

local pitch = 0

local moveDir = Vector3.new()

local sprint = false

local originalCameraType

local originalMouseBehavior

local originalMouseIconEnabled

local humanoid

local savedWalkSpeed

local savedJumpPower

local justToggled = false -- NEW: para pigilan extra input sa frame ng toggle



-- Helpers for movement direction

local function addKeyDirection(key)

	if key == Enum.KeyCode.W then moveDir += Vector3.new(0,0,1) end  -- forward

	if key == Enum.KeyCode.S then moveDir += Vector3.new(0,0,-1) end -- backward

	if key == Enum.KeyCode.A then moveDir += Vector3.new(-1,0,0) end

	if key == Enum.KeyCode.D then moveDir += Vector3.new(1,0,0) end

	if key == Enum.KeyCode.Space then moveDir += Vector3.new(0,1,0) end

	if key == Enum.KeyCode.LeftControl or key == Enum.KeyCode.C then moveDir += Vector3.new(0,-1,0) end

end



local function removeKeyDirection(key)

	if key == Enum.KeyCode.W then moveDir -= Vector3.new(0,0,1) end

	if key == Enum.KeyCode.S then moveDir -= Vector3.new(0,0,-1) end

	if key == Enum.KeyCode.A then moveDir -= Vector3.new(-1,0,0) end

	if key == Enum.KeyCode.D then moveDir -= Vector3.new(1,0,0) end

	if key == Enum.KeyCode.Space then moveDir -= Vector3.new(0,1,0) end

	if key == Enum.KeyCode.LeftControl or key == Enum.KeyCode.C then moveDir -= Vector3.new(0,-1,0) end

end



-- Toggle freecam

local function toggleFreecam()

	enabled = not enabled

	moveDir = Vector3.new() -- NEW: reset movement dir agad

	sprint = false

	justToggled = true



	if enabled then

		-- Save original states

		originalCameraType = cam.CameraType

		originalMouseBehavior = UserInputService.MouseBehavior

		originalMouseIconEnabled = UserInputService.MouseIconEnabled



		-- Freeze character

		if player.Character then

			humanoid = player.Character:FindFirstChildOfClass("Humanoid")

			if humanoid then

				savedWalkSpeed = humanoid.WalkSpeed

				savedJumpPower = humanoid.JumpPower

				humanoid.WalkSpeed = 0

				humanoid.JumpPower = 0

			end

		end



		-- Set yaw/pitch

		local x, y, z = cam.CFrame:ToEulerAnglesYXZ()

		pitch = math.deg(x)

		yaw = math.deg(y)



		cam.CameraType = Enum.CameraType.Scriptable

		UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter

		UserInputService.MouseIconEnabled = false

	else

		-- Restore character movement

		if humanoid then

			humanoid.WalkSpeed = savedWalkSpeed or 16

			humanoid.JumpPower = savedJumpPower or 50

		end

		cam.CameraType = originalCameraType or Enum.CameraType.Custom

		UserInputService.MouseBehavior = originalMouseBehavior or Enum.MouseBehavior.Default

		UserInputService.MouseIconEnabled = originalMouseIconEnabled

	end

end



-- Keybinds

UserInputService.InputBegan:Connect(function(input, gpe)

	if gpe then return end



	if input.KeyCode == Enum.KeyCode.Q then

		toggleFreecam()

		return

	end



	if justToggled then return end -- NEW: block key presses sa toggle frame



	if enabled and input.UserInputType == Enum.UserInputType.Keyboard then

		if input.KeyCode == Enum.KeyCode.LeftShift then

			sprint = true

		else

			addKeyDirection(input.KeyCode)

		end

	end

end)



UserInputService.InputEnded:Connect(function(input, gpe)

	if gpe or not enabled then return end

	if justToggled then return end -- NEW: block releases sa toggle frame



	if input.KeyCode == Enum.KeyCode.LeftShift then

		sprint = false

	else

		removeKeyDirection(input.KeyCode)

	end

end)



-- Mouse look

UserInputService.InputChanged:Connect(function(input, gpe)

	if not enabled then return end

	if input.UserInputType == Enum.UserInputType.MouseMovement then

		yaw -= input.Delta.X * MOUSE_SENSITIVITY

		pitch = math.clamp(pitch - input.Delta.Y * MOUSE_SENSITIVITY, -MAX_PITCH, MAX_PITCH)

	end

end)



-- Camera movement

RunService.RenderStepped:Connect(function(dt)

	if justToggled then

		justToggled = false -- reset block flag after 1 frame

	end

	if not enabled then return end



	local rot = CFrame.Angles(0, math.rad(yaw), 0) * CFrame.Angles(math.rad(pitch), 0, 0)

	local localMove = (rot.RightVector * moveDir.X + rot.UpVector * moveDir.Y + rot.LookVector * moveDir.Z)

	local speed = MOVE_SPEED * (sprint and SPRINT_MULTIPLIER or 1)

	local newPos = cam.CFrame.Position + localMove * speed * dt

	cam.CFrame = CFrame.new(newPos) * rot

end)

end)



addBtn("AIMBOT ADJUSTABLE (MONSY)", function()

	--// CONFIG

getgenv().Environment = {

    FOVSettings = {

        Amount = 150,

        Visible = true,

        Color = Color3.fromRGB(255, 255, 255) -- White FOV

    },

    Aimbot = {

        Enabled = true,

        AimPart = "Head"

    }

}



--// SERVICES

local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local Mouse = LocalPlayer:GetMouse()

local UIS = game:GetService("UserInputService")

local RunService = game:GetService("RunService")



--// CREATE FOV CIRCLE

local Circle = Drawing.new("Circle")

Circle.Radius = Environment.FOVSettings.Amount

Circle.Thickness = 2

Circle.Transparency = 1

Circle.Filled = false

Circle.Color = Environment.FOVSettings.Color



--// UPDATE FOV CIRCLE POSITION

RunService.RenderStepped:Connect(function()

    Circle.Position = UIS:GetMouseLocation()

    Circle.Visible = Environment.FOVSettings.Visible

    Circle.Radius = Environment.FOVSettings.Amount

end)



--// AIMBOT FUNCTION

local function GetClosestPlayer()

    local closest, dist = nil, Environment.FOVSettings.Amount

    for _, player in pairs(Players:GetPlayers()) do

        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild(Environment.Aimbot.AimPart) then

            local headPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(player.Character[Environment.Aimbot.AimPart].Position)

            if onScreen then

                local mag = (Vector2.new(headPos.X, headPos.Y) - UIS:GetMouseLocation()).Magnitude

                if mag < dist then

                    closest = player

                    dist = mag

                end

            end

        end

    end

    return closest

end



RunService.RenderStepped:Connect(function()

    if Environment.Aimbot.Enabled and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then

        local target = GetClosestPlayer()

        if target then

            workspace.CurrentCamera.CFrame = CFrame.new(

                workspace.CurrentCamera.CFrame.Position,

                target.Character[Environment.Aimbot.AimPart].Position

            )

        end

    end

end)



--// GUI SETUP

local ScreenGui = Instance.new("ScreenGui")

local Frame = Instance.new("Frame")

local Title = Instance.new("TextLabel")

local SliderBack = Instance.new("Frame")

local SliderFill = Instance.new("Frame")

local SliderButton = Instance.new("TextButton")

local FOVLabel = Instance.new("TextLabel")

local ToggleButton = Instance.new("TextButton")



ScreenGui.Parent = game.CoreGui



-- Frame

Frame.Size = UDim2.new(0, 220, 0, 140)

Frame.Position = UDim2.new(0, 50, 0, 50)

Frame.BackgroundColor3 = Color3.fromRGB(255,255,255) -- All black

Frame.BorderSizePixel = 0

Frame.Active = true

Frame.Draggable = true

Frame.Parent = ScreenGui



-- Title

Title.Size = UDim2.new(1, 0, 0, 30)

Title.BackgroundTransparency = 1

Title.Text = "NEXUS AIMBOT" -- Custom Title

Title.TextColor3 = Color3.fromRGB(0,0,0)

Title.TextSize = 16

Title.Font = Enum.Font.SourceSansBold

Title.Parent = Frame



-- Slider background

SliderBack.Size = UDim2.new(0.8, 0, 0, 6)

SliderBack.Position = UDim2.new(0.1, 0, 0.35, 0)

SliderBack.BackgroundColor3 = Color3.fromRGB(255,255,255) -- All black

SliderBack.BorderSizePixel = 0

SliderBack.Parent = Frame



-- Slider fill

SliderFill.Size = UDim2.new(0.5, 0, 1, 0)

SliderFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- White fill

SliderFill.BorderSizePixel = 0

SliderFill.Parent = SliderBack



-- Slider button

SliderButton.Size = UDim2.new(0, 20, 0, 20)

SliderButton.Position = UDim2.new(0.5, -10, 0.5, -10)

SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- White button

SliderButton.Text = ""

SliderButton.BorderSizePixel = 0

SliderButton.Parent = Frame



-- FOV text display

FOVLabel.Size = UDim2.new(1, 0, 0, 20)

FOVLabel.Position = UDim2.new(0, 0, 0.45, 0)

FOVLabel.BackgroundTransparency = 1

FOVLabel.TextColor3 = Color3.fromRGB(0,0,0)

FOVLabel.TextSize = 14

FOVLabel.Font = Enum.Font.SourceSans

FOVLabel.Text = "FOV: " .. Environment.FOVSettings.Amount

FOVLabel.Parent = Frame



-- Toggle button for Show/Hide

ToggleButton.Size = UDim2.new(0.8, 0, 0, 30)

ToggleButton.Position = UDim2.new(0.1, 0, 0.7, 0)

ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)

ToggleButton.TextColor3 = Color3.fromRGB(0,0,0)

ToggleButton.TextSize = 14

ToggleButton.Font = Enum.Font.SourceSansBold

ToggleButton.Text = "FOV: Visible"

ToggleButton.Parent = Frame



-- FOV slider logic

local dragging = false



local function updateFOV(percent)

    percent = math.clamp(percent, 0, 1)

    SliderFill.Size = UDim2.new(percent, 0, 1, 0)

    SliderButton.Position = UDim2.new(percent, -10, 0.5, -10)

    local newFOV = math.floor(50 + percent * 400)

    Environment.FOVSettings.Amount = newFOV

    FOVLabel.Text = "FOV: " .. newFOV

end



SliderButton.MouseButton1Down:Connect(function()

    dragging = true

end)



UIS.InputEnded:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1 then

        dragging = false

    end

end)



UIS.InputChanged:Connect(function(input)

    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then

        local percent = (UIS:GetMouseLocation().X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X

        updateFOV(percent)

    end

end)



-- Toggle FOV visibility

ToggleButton.MouseButton1Click:Connect(function()

    Environment.FOVSettings.Visible = not Environment.FOVSettings.Visible

    if Environment.FOVSettings.Visible then

        ToggleButton.Text = "FOV: Visible"

        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)

    else

        ToggleButton.Text = "FOV: Hidden"

        ToggleButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)

    end

end)



-- Initial setup

updateFOV((Environment.FOVSettings.Amount - 50) / 400)

end)



addBtn("FADED GUI UNIVERSAL (MONSY)", function()

	loadstring(game:HttpGet("https://raw.githubusercontent.com/NighterEpic/Faded-Grid/main/YesEpic", true))()

end)



addBtn("LOOP BRING ALL [NEXUS]", function()

	--// Services

local Players = game:GetService("Players")

local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer



--// Variables

local loopEnabled = false

local originalPositions = {}



--// GUI

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)



local Frame = Instance.new("Frame", ScreenGui)

Frame.Size = UDim2.new(0, 300, 0, 100)

Frame.Position = UDim2.new(0.5, -150, 0, 50)

Frame.BackgroundColor3 = Color3.fromRGB(255,255,255) -- all black

Frame.BorderSizePixel = 0

Frame.Active = true

Frame.Draggable = true



local UICorner = Instance.new("UICorner", Frame)

UICorner.CornerRadius = UDim.new(0, 6)



local Title = Instance.new("TextLabel", Frame)

Title.Size = UDim2.new(1, 0, 0.4, 0)

Title.BackgroundTransparency = 1

Title.Font = Enum.Font.SourceSansBold

Title.TextSize = 18

Title.Text = "NEXUS LOOP BRING ALL"

Title.TextColor3 = Color3.fromRGB(0,0,0) -- white



local StatusButton = Instance.new("TextButton", Frame)

StatusButton.Size = UDim2.new(1, 0, 0.6, 0)

StatusButton.Position = UDim2.new(0, 0, 0.4, 0)

StatusButton.Font = Enum.Font.SourceSansBold

StatusButton.TextSize = 20

StatusButton.Text = "OFF"

StatusButton.BackgroundColor3 = Color3.fromRGB(255,255,255) -- black

StatusButton.TextColor3 = Color3.fromRGB(0,0,0) -- white text



--// Toggle Function

StatusButton.MouseButton1Click:Connect(function()

    loopEnabled = not loopEnabled



    if loopEnabled then

        -- Save original positions

        originalPositions = {}

        for _, plr in ipairs(Players:GetPlayers()) do

            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then

                originalPositions[plr.Name] = plr.Character.HumanoidRootPart.CFrame

            end

        end



        StatusButton.Text = "ON"

        StatusButton.TextColor3 = Color3.fromRGB(0,0,0) -- green text

    else

        -- Return players to original positions

        for _, plr in ipairs(Players:GetPlayers()) do

            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then

                local savedPos = originalPositions[plr.Name]

                if savedPos then

                    plr.Character.HumanoidRootPart.CFrame = savedPos

                end

            end

        end



        StatusButton.Text = "OFF"

        StatusButton.TextColor3 = Color3.fromRGB(0,0,0) -- back to white text

    end

end)



--// Loop Bring All in Front

RunService.RenderStepped:Connect(function()

    if loopEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then

        local hrp = LocalPlayer.Character.HumanoidRootPart

        local targetPos = hrp.Position + (hrp.CFrame.LookVector * 5)



        for _, plr in ipairs(Players:GetPlayers()) do

            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then

                -- Remove tools

                plr.Backpack:ClearAllChildren()

                for _, tool in pairs(plr.Character:GetChildren()) do

                    if tool:IsA("Tool") then

                        tool:Destroy()

                    end

                end



                -- Bring to front

                plr.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos)

            end

        end

    end

end)

end)



--// 8 Buttons in Main Menu

addBtn("PLAYER SCANNER (MONSY)", function()

	--// NEXUS PLAYER SCANNER

-- Solid black GUI + Modern font + Hover effects + Click animations + Working VIEW/UNVIEW/TELEPORT



local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local UIS = game:GetService("UserInputService")



-- Main ScreenGui

local ScreenGui = Instance.new("ScreenGui")

ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

ScreenGui.ResetOnSpawn = false



-- Main Frame

local MainFrame = Instance.new("Frame")

MainFrame.Size = UDim2.new(0, 350, 0, 400)

MainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)

MainFrame.BackgroundColor3 = Color3.fromRGB(255,255,255)

MainFrame.BorderSizePixel = 0

MainFrame.Visible = true

MainFrame.Active = true

MainFrame.Draggable = true

MainFrame.Parent = ScreenGui



-- UI Corner

local MainCorner = Instance.new("UICorner")

MainCorner.CornerRadius = UDim.new(0, 8)

MainCorner.Parent = MainFrame



-- Title

local Title = Instance.new("TextLabel")

Title.Size = UDim2.new(1, 0, 0, 40)

Title.BackgroundTransparency = 1

Title.Text = "NEXUS PLAYER SCANNER"

Title.TextColor3 = Color3.fromRGB(0,0,0)

Title.Font = Enum.Font.GothamBold

Title.TextSize = 20

Title.Parent = MainFrame



-- Scan Button

local ScanButton = Instance.new("TextButton")

ScanButton.Size = UDim2.new(0.9, 0, 0, 35)

ScanButton.Position = UDim2.new(0.05, 0, 0, 50)

ScanButton.BackgroundColor3 = Color3.fromRGB(255,255,255)

ScanButton.TextColor3 = Color3.fromRGB(0,0,0)

ScanButton.Font = Enum.Font.GothamBold

ScanButton.TextSize = 18

ScanButton.Text = "SCAN"

ScanButton.AutoButtonColor = false

ScanButton.Parent = MainFrame



local ScanCorner = Instance.new("UICorner")

ScanCorner.CornerRadius = UDim.new(0, 6)

ScanCorner.Parent = ScanButton



-- Hover effect

local function AddHoverEffect(button)

	button.MouseEnter:Connect(function()

		button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

	end)

	button.MouseLeave:Connect(function()

		button.BackgroundColor3 = Color3.fromRGB(255,255,255)

	end)

	button.MouseButton1Click:Connect(function()

		button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

		task.wait(0.1)

		button.BackgroundColor3 = Color3.fromRGB(255,255,255)

	end)

end

AddHoverEffect(ScanButton)



-- Scrollable Player List

local PlayerListFrame = Instance.new("ScrollingFrame")

PlayerListFrame.Size = UDim2.new(0.9, 0, 0, 280)

PlayerListFrame.Position = UDim2.new(0.05, 0, 0, 90)

PlayerListFrame.BackgroundTransparency = 1

PlayerListFrame.BorderSizePixel = 0

PlayerListFrame.ScrollBarThickness = 6

PlayerListFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)

PlayerListFrame.Parent = MainFrame



local UIListLayout = Instance.new("UIListLayout")

UIListLayout.Parent = PlayerListFrame

UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

UIListLayout.Padding = UDim.new(0, 4)



-- Function to create each player entry

local function CreatePlayerButton(player)

	local PlayerButton = Instance.new("TextButton")

	PlayerButton.Size = UDim2.new(1, 0, 0, 30)

	PlayerButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

	PlayerButton.TextColor3 = Color3.fromRGB(0,0,0)

	PlayerButton.Font = Enum.Font.Gotham

	PlayerButton.TextSize = 16

	PlayerButton.Text = player.DisplayName .. " (@" .. player.Name .. ")"

	PlayerButton.AutoButtonColor = false

	PlayerButton.Parent = PlayerListFrame



	local PlayerCorner = Instance.new("UICorner")

	PlayerCorner.CornerRadius = UDim.new(0, 6)

	PlayerCorner.Parent = PlayerButton



	AddHoverEffect(PlayerButton)



	-- Actions Frame

	local ActionsFrame = Instance.new("Frame")

	ActionsFrame.Size = UDim2.new(1, 0, 0, 30)

	ActionsFrame.BackgroundTransparency = 1

	ActionsFrame.Visible = false

	ActionsFrame.Parent = PlayerListFrame



	local function CreateActionButton(text)

		local Btn = Instance.new("TextButton")

		Btn.Size = UDim2.new(0.3, 0, 1, 0)

		Btn.BackgroundColor3 = Color3.fromRGB(255,255,255)

		Btn.TextColor3 = Color3.fromRGB(0,0,0)

		Btn.Font = Enum.Font.GothamBold

		Btn.TextSize = 14

		Btn.Text = text

		Btn.AutoButtonColor = false

		Btn.Parent = ActionsFrame



		local BtnCorner = Instance.new("UICorner")

		BtnCorner.CornerRadius = UDim.new(0, 6)

		BtnCorner.Parent = Btn



		AddHoverEffect(Btn)

		return Btn

	end



	local ViewBtn = CreateActionButton("VIEW")

	local UnviewBtn = CreateActionButton("UNVIEW")

	local TeleportBtn = CreateActionButton("TELEPORT")



	ViewBtn.Position = UDim2.new(0, 0, 0, 0)

	UnviewBtn.Position = UDim2.new(0.35, 0, 0, 0)

	TeleportBtn.Position = UDim2.new(0.7, 0, 0, 0)



	-- === BUTTON FUNCTIONS ===

	ViewBtn.MouseButton1Click:Connect(function()

		if player.Character and player.Character:FindFirstChild("Head") then

			workspace.CurrentCamera.CameraSubject = player.Character:FindFirstChild("Head")

		end

	end)



	UnviewBtn.MouseButton1Click:Connect(function()

		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then

			workspace.CurrentCamera.CameraSubject = LocalPlayer.Character:FindFirstChild("Humanoid")

		end

	end)



	TeleportBtn.MouseButton1Click:Connect(function()

		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and

		   LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then

			LocalPlayer.Character.HumanoidRootPart.CFrame =

				player.Character.HumanoidRootPart.CFrame + Vector3.new(2, 0, 0)

		end

	end)



	-- Show/hide action buttons

	PlayerButton.MouseButton1Click:Connect(function()

		ActionsFrame.Visible = not ActionsFrame.Visible

	end)

end



-- SCAN function

ScanButton.MouseButton1Click:Connect(function()

	for _, child in ipairs(PlayerListFrame:GetChildren()) do

		if child:IsA("TextButton") or child:IsA("Frame") then

			child:Destroy()

		end

	end



	task.spawn(function()

		for _, player in ipairs(Players:GetPlayers()) do

			if player ~= LocalPlayer then

				CreatePlayerButton(player)

				task.wait(0.15)

			end

		end

	end)

end)



-- Hide/Unhide with U

UIS.InputBegan:Connect(function(input, gp)

	if not gp and input.KeyCode == Enum.KeyCode.U then

		MainFrame.Visible = not MainFrame.Visible

	end

end)

end)



--// 8 Buttons in Main Menu

addBtn("AIM VIEWER (MONSY)", function()

	--// NEXUS AIM VIEWER //--



local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local RunService = game:GetService("RunService")

local Camera = workspace.CurrentCamera



local AimViewerEnabled = false

local playerLines = {}

local lineDistance = 50 -- haba ng line (studs)



-- GUI

local ScreenGui = Instance.new("ScreenGui")

ScreenGui.Parent = game.CoreGui



local Frame = Instance.new("Frame")

Frame.Size = UDim2.new(0, 200, 0, 60)

Frame.Position = UDim2.new(0.4, 0, 0.05, 0)

Frame.BackgroundColor3 = Color3.fromRGB(255,255,255) -- black bg

Frame.BorderSizePixel = 2

Frame.Active = true

Frame.Draggable = true

Frame.Parent = ScreenGui



local Title = Instance.new("TextLabel")

Title.Size = UDim2.new(1, 0, 0, 25)

Title.BackgroundColor3 = Color3.fromRGB(255,255,255) -- black title bg

Title.Text = "NEXUS AIM VIEWER"

Title.TextColor3 = Color3.fromRGB(0,0,0) -- white text

Title.Font = Enum.Font.SourceSansBold

Title.TextSize = 18

Title.Parent = Frame



local ToggleButton = Instance.new("TextButton")

ToggleButton.Size = UDim2.new(1, 0, 0, 35)

ToggleButton.Position = UDim2.new(0, 0, 0, 25)

ToggleButton.BackgroundColor3 = Color3.fromRGB(255,255,255) -- black bg

ToggleButton.Text = "Aim Viewer: OFF"

ToggleButton.TextColor3 = Color3.fromRGB(0,0,0) -- red text (off)

ToggleButton.Font = Enum.Font.SourceSansBold

ToggleButton.TextSize = 18

ToggleButton.Parent = Frame



-- Function para gumawa ng line

local function createLine()

    local line = Drawing.new("Line")

    line.Thickness = 1.5

    line.Transparency = 1

    line.Color = Color3.fromRGB(0, 0, 0) -- black line

    return line

end



-- Toggle function

ToggleButton.MouseButton1Click:Connect(function()

    AimViewerEnabled = not AimViewerEnabled

    if AimViewerEnabled then

        ToggleButton.Text = "Aim Viewer: ON"

        ToggleButton.TextColor3 = Color3.fromRGB(0,0,0) -- green kapag on

    else

        ToggleButton.Text = "Aim Viewer: OFF"

        ToggleButton.TextColor3 = Color3.fromRGB(0,0,0) -- red kapag off

        for _, line in pairs(playerLines) do

            line.Visible = false

        end

    end

end)



-- Main loop

RunService.RenderStepped:Connect(function()

    if AimViewerEnabled then

        for _, plr in pairs(Players:GetPlayers()) do

            if plr ~= LocalPlayer then

                if not playerLines[plr] then

                    playerLines[plr] = createLine()

                end

                local line = playerLines[plr]

                local char = plr.Character

                if char and char:FindFirstChild("Head") then

                    local head = char.Head

                    local startPos, onScreen = Camera:WorldToViewportPoint(head.Position)

                    local endPos = head.Position + (head.CFrame.LookVector * lineDistance)

                    local endScreen, onScreen2 = Camera:WorldToViewportPoint(endPos)

                    if onScreen or onScreen2 then

                        line.From = Vector2.new(startPos.X, startPos.Y)

                        line.To = Vector2.new(endScreen.X, endScreen.Y)

                        line.Visible = true

                    else

                        line.Visible = false

                    end

                else

                    line.Visible = false

                end

            end

        end

    end

end)

end)



--// 8 Buttons in Main Menu

addBtn("HEAD DETECTOR (MONSY)", function()

	-- Local Anti-Headshot Detection GUI (Client-Side)

-- Detects if someone is aiming at your head

-- With ON/OFF toggle button + Hotkey (G)



local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local UserInputService = game:GetService("UserInputService")



-- SETTINGS

local FOV_THRESHOLD = 5 -- degrees: smaller = stricter

local UPDATE_INTERVAL = 0.2 -- seconds

local detectionEnabled = true -- toggle state



-- ScreenGui Setup

local ScreenGui = Instance.new("ScreenGui")

ScreenGui.Name = "AntiHeadshotGUI"

ScreenGui.Parent = game.CoreGui



-- Main Frame

local Frame = Instance.new("Frame", ScreenGui)

Frame.Size = UDim2.new(0, 300, 0, 200)

Frame.Position = UDim2.new(1, -310, 0, 10)

Frame.BackgroundColor3 = Color3.fromRGB(255,255,255)

Frame.BorderSizePixel = 0



-- Title

local Title = Instance.new("TextLabel", Frame)

Title.Size = UDim2.new(1, 0, 0, 30)

Title.BackgroundColor3 = Color3.fromRGB(255,255,255)

Title.TextColor3 = Color3.fromRGB(0,0,0)

Title.Font = Enum.Font.GothamBold

Title.TextSize = 18

Title.Text = "Taong Goma Head Detector"



-- Player List

local PlayerList = Instance.new("TextLabel", Frame)

PlayerList.Size = UDim2.new(1, -10, 1, -40)

PlayerList.Position = UDim2.new(0, 5, 0, 35)

PlayerList.BackgroundTransparency = 1

PlayerList.TextColor3 = Color3.fromRGB(0,0,0)

PlayerList.Font = Enum.Font.Code

PlayerList.TextSize = 14

PlayerList.TextXAlignment = Enum.TextXAlignment.Left

PlayerList.TextYAlignment = Enum.TextYAlignment.Top

PlayerList.Text = "No threats detected."

PlayerList.RichText = true



-- Warning Label (Top Center)

local WarningLabel = Instance.new("TextLabel", ScreenGui)

WarningLabel.Size = UDim2.new(1, 0, 0, 30)

WarningLabel.Position = UDim2.new(0, 0, 0, 10)

WarningLabel.BackgroundTransparency = 1

WarningLabel.TextColor3 = Color3.fromRGB(0,0,0)

WarningLabel.TextStrokeTransparency = 0

WarningLabel.Font = Enum.Font.GothamBold

WarningLabel.TextSize = 20

WarningLabel.Text = ""

WarningLabel.Visible = false



-- Toggle Button

local ToggleButton = Instance.new("TextButton", Frame)

ToggleButton.Size = UDim2.new(1, 0, 0, 25)

ToggleButton.Position = UDim2.new(0, 0, 1, -25)

ToggleButton.BackgroundColor3 = Color3.fromRGB(255,255,255)

ToggleButton.TextColor3 = Color3.fromRGB(0,0,0)

ToggleButton.Font = Enum.Font.GothamBold

ToggleButton.TextSize = 14

ToggleButton.Text = "Detection: ON"



-- Function to check aim

local function isAimingAtHead(attacker)

    if not attacker.Character or not attacker.Character:FindFirstChild("Head") then return false end

    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("Head") then return false end



    local attackerHead = attacker.Character.Head

    local localHead = LocalPlayer.Character.Head



    local lookDir = attackerHead.CFrame.LookVector

    local dirToOurHead = (localHead.Position - attackerHead.Position).Unit



    local dot = lookDir:Dot(dirToOurHead)

    local angle = math.deg(math.acos(dot))



    return angle <= FOV_THRESHOLD

end



-- Update loop

task.spawn(function()

    while true do

        task.wait(UPDATE_INTERVAL)



        if not detectionEnabled then

            PlayerList.Text = "Detection OFF"

            WarningLabel.Visible = false

            Title.BackgroundColor3 = Color3.fromRGB(255,255,255)

            continue

        end



        local threats = {}

        for _, plr in pairs(Players:GetPlayers()) do

            if plr ~= LocalPlayer then

                if isAimingAtHead(plr) then

                    table.insert(threats, plr.Name)

                end

            end

        end



        if #threats > 0 then

            Title.BackgroundColor3 = Color3.fromRGB(255,255,255)

            PlayerList.Text = "⚠ Threats:\n" .. table.concat(threats, "\n")

            WarningLabel.Text = "⚠ WARNING: " .. table.concat(threats, ", ") .. " aiming at you!"

            WarningLabel.Visible = true

        else

            Title.BackgroundColor3 = Color3.fromRGB(255,255,255)

            PlayerList.Text = "No threats detected."

            WarningLabel.Visible = false

        end

    end

end)



-- Toggle function

local function toggleDetection()

    detectionEnabled = not detectionEnabled

    ToggleButton.Text = detectionEnabled and "Detection: ON" or "Detection: OFF"

end



-- Button Click

ToggleButton.MouseButton1Click:Connect(toggleDetection)



-- Hotkey (G)

UserInputService.InputBegan:Connect(function(input, gameProcessed)

    if not gameProcessed and input.KeyCode == Enum.KeyCode.G then

        toggleDetection()

    end

end)

end)



--// 8 Buttons in Main Menu

addBtn("PLAYER LIST TP (MONSY)", function()

	-- NEXUS - Player Viewer (LocalScript sa StarterGui)

local Players = game:GetService("Players")

local RunService = game:GetService("RunService")

local UserInputService = game:GetService("UserInputService")



local LocalPlayer = Players.LocalPlayer

local Camera = workspace.CurrentCamera



-- GUI parent

local screenGui = Instance.new("ScreenGui")

screenGui.Name = "TaongGomaGui"

screenGui.ResetOnSpawn = false

screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")



-- Toggle visibility keybind (K)

UserInputService.InputBegan:Connect(function(input, isProcessed)

	if not isProcessed and input.KeyCode == Enum.KeyCode.K then

		screenGui.Enabled = not screenGui.Enabled

	end

end)



-- Main draggable frame

local mainFrame = Instance.new("Frame", screenGui)

mainFrame.Size = UDim2.new(0, 520, 0, 360)

mainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)

mainFrame.BackgroundColor3 = Color3.fromRGB(255,255,255)

mainFrame.Active = true

mainFrame.Draggable = true

mainFrame.BorderSizePixel = 0



-- Title bar

local titleBar = Instance.new("TextLabel", mainFrame)

titleBar.Size = UDim2.new(1, 0, 0, 36)

titleBar.BackgroundColor3 = Color3.fromRGB(255,255,255)

titleBar.Text = "NEXUS"

titleBar.Font = Enum.Font.GothamBold

titleBar.TextSize = 22

titleBar.TextColor3 = Color3.fromRGB(0,0,0)

titleBar.BorderSizePixel = 0



-- Left: player list (scrolling)

local leftWidth = 0.34

local scroll = Instance.new("ScrollingFrame", mainFrame)

scroll.Name = "PlayerList"

scroll.Position = UDim2.new(0, 0, 0, 36)

scroll.Size = UDim2.new(leftWidth, 0, 1, -36)

scroll.BackgroundColor3 = Color3.fromRGB(255,255,255)

scroll.ScrollBarThickness = 6

scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

scroll.BorderSizePixel = 0



local listLayout = Instance.new("UIListLayout", scroll)

listLayout.SortOrder = Enum.SortOrder.LayoutOrder

listLayout.Padding = UDim.new(0, 4)



-- Right: info + buttons

local right = Instance.new("Frame", mainFrame)

right.Position = UDim2.new(leftWidth, 0, 0, 36)

right.Size = UDim2.new(1 - leftWidth, 0, 1, -36)

right.BackgroundColor3 = Color3.fromRGB(255,255,255)

right.BorderSizePixel = 0



-- Center container for Name/Health

local infoContainer = Instance.new("Frame", right)

infoContainer.Size = UDim2.new(1, 0, 0.55, 0)

infoContainer.Position = UDim2.new(0, 0, 0, 8)

infoContainer.BackgroundTransparency = 1



local nameLabel = Instance.new("TextLabel", infoContainer)

nameLabel.Size = UDim2.new(1, -20, 0, 36)

nameLabel.Position = UDim2.new(0, 10, 0, 10)

nameLabel.BackgroundTransparency = 1

nameLabel.Font = Enum.Font.GothamBold

nameLabel.TextSize = 22

nameLabel.TextColor3 = Color3.fromRGB(0,0,0)

nameLabel.Text = "Name: None"

nameLabel.TextXAlignment = Enum.TextXAlignment.Center



local healthLabel = Instance.new("TextLabel", infoContainer)

healthLabel.Size = UDim2.new(1, -20, 0, 26)

healthLabel.Position = UDim2.new(0, 10, 0, 60)

healthLabel.BackgroundTransparency = 1

healthLabel.Font = Enum.Font.Gotham

healthLabel.TextSize = 18

healthLabel.TextColor3 = Color3.fromRGB(0,0,0)

healthLabel.Text = "Health: N/A"

healthLabel.TextXAlignment = Enum.TextXAlignment.Center



-- Buttons container

local buttonContainer = Instance.new("Frame", right)

buttonContainer.Size = UDim2.new(1, 0, 0.35, 0)

buttonContainer.Position = UDim2.new(0, 0, 0.6, 0)

buttonContainer.BackgroundTransparency = 1



local padding = Instance.new("UIPadding", buttonContainer)

padding.PaddingTop = UDim.new(0, 5)

padding.PaddingBottom = UDim.new(0, 5)



local btnLayout = Instance.new("UIListLayout", buttonContainer)

btnLayout.SortOrder = Enum.SortOrder.LayoutOrder

btnLayout.Padding = UDim.new(0, 8)

btnLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

btnLayout.VerticalAlignment = Enum.VerticalAlignment.Top



-- Button creator

local function createButton(label)

	local b = Instance.new("TextButton")

	b.Size = UDim2.new(0.85, 0, 0.22, 0)

	b.AnchorPoint = Vector2.new(0.5, 0)

	b.BackgroundColor3 = Color3.fromRGB(255,255,255)

	b.Font = Enum.Font.GothamBold

	b.TextSize = 18

	b.Text = label

	b.TextColor3 = Color3.fromRGB(0,0,0)

	b.AutoButtonColor = true

	local corner = Instance.new("UICorner")

	corner.CornerRadius = UDim.new(0, 8)

	corner.Parent = b

	b.Parent = buttonContainer

	return b

end



local viewButton = createButton("View Player")

local tpButton = createButton("Teleport to Player")

local bringButton = createButton("Bring Player") -- bagong button

local friendButton = createButton("Add Friend")



-- State

local selectedPlayer = nil

local isViewing = false

local isBringing = false

local originalCameraSubject = Camera.CameraSubject

local bringConnection



-- Helper: safely revert camera

local function revertCamera()

	if originalCameraSubject and typeof(originalCameraSubject) == "Instance" and originalCameraSubject.Parent then

		Camera.CameraSubject = originalCameraSubject

	else

		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then

			Camera.CameraSubject = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

		end

	end

	Camera.CameraType = Enum.CameraType.Custom

	isViewing = false

	viewButton.Text = "View Player"

end



-- Build player list

local function refreshPlayerList()

	for _, c in ipairs(scroll:GetChildren()) do

		if c:IsA("TextButton") then c:Destroy() end

	end

	for _, plr in ipairs(Players:GetPlayers()) do

		if plr ~= LocalPlayer then

			local btn = Instance.new("TextButton")

			btn.Size = UDim2.new(1, -8, 0, 28)

			btn.BackgroundColor3 = Color3.fromRGB(255,255,255)

			btn.TextColor3 = Color3.fromRGB(0,0,0)

			btn.Font = Enum.Font.Gotham

			btn.TextSize = 16

			btn.AutoButtonColor = true

			btn.Text = plr.Name

			local corner = Instance.new("UICorner")

			corner.CornerRadius = UDim.new(0, 4)

			corner.Parent = btn

			btn.Parent = scroll

			btn.MouseButton1Click:Connect(function()

				selectedPlayer = plr

				nameLabel.Text = "Name: " .. plr.Name

				local humanoid = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")

				if humanoid then

					healthLabel.Text = "Health: " .. math.floor(humanoid.Health)

				else

					healthLabel.Text = "Health: N/A"

				end

				if isViewing then revertCamera() end

			end)

		end

	end

end



-- Button behaviors

viewButton.MouseButton1Click:Connect(function()

	if not selectedPlayer then return end

	local char = selectedPlayer.Character

	local humanoid = char and char:FindFirstChildOfClass("Humanoid")

	if not humanoid then return end

	if not isViewing then

		originalCameraSubject = Camera.CameraSubject

		Camera.CameraSubject = humanoid

		Camera.CameraType = Enum.CameraType.Custom

		isViewing = true

		viewButton.Text = "Unview Player"

	else

		revertCamera()

	end

end)



tpButton.MouseButton1Click:Connect(function()

	if not selectedPlayer then return end

	local targetHRP = selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart")

	local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

	if targetHRP and myHRP then

		myHRP.CFrame = targetHRP.CFrame + Vector3.new(2, 0.5, 0)

	end

end)



bringButton.MouseButton1Click:Connect(function()

	if not selectedPlayer then return end

	if not isBringing then

		isBringing = true

		bringButton.Text = "Unbring Player"

		bringConnection = RunService.RenderStepped:Connect(function()

			local targetChar = selectedPlayer.Character

			local myChar = LocalPlayer.Character

			if targetChar and myChar then

				local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")

				local myHRP = myChar:FindFirstChild("HumanoidRootPart")

				if targetHRP and myHRP then

					targetHRP.CFrame = myHRP.CFrame + Vector3.new(2, 0, 0)

				end

			end

		end)

	else

		isBringing = false

		bringButton.Text = "Bring Player"

		if bringConnection then bringConnection:Disconnect() end

	end

end)



friendButton.MouseButton1Click:Connect(function()

	if selectedPlayer then

		LocalPlayer:RequestFriendship(selectedPlayer)

	end

end)



-- Keep health label updated

RunService.Heartbeat:Connect(function()

	if selectedPlayer then

		local humanoid = selectedPlayer.Character and selectedPlayer.Character:FindFirstChildOfClass("Humanoid")

		if humanoid then

			healthLabel.Text = "Health: " .. math.floor(humanoid.Health)

		else

			healthLabel.Text = "Health: N/A"

		end

	end

end)



Players.PlayerRemoving:Connect(function(plr)

	if plr == selectedPlayer then

		selectedPlayer = nil

		nameLabel.Text = "Name: None"

		healthLabel.Text = "Health: N/A"

		if isViewing then revertCamera() end

	end

	refreshPlayerList()

end)



Players.PlayerAdded:Connect(function()

	refreshPlayerList()

end)



refreshPlayerList()

end)



addBtn("TPUNANCHORED TO PLAYER (MONSY)", function()

	--// Services

local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local Workspace = game:GetService("Workspace")

local Debris = game:GetService("Debris")



--// GUI Setup

local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))

ScreenGui.Name = "UnanchoredToolTP"

ScreenGui.ResetOnSpawn = false



local Frame = Instance.new("Frame", ScreenGui)

Frame.Size = UDim2.new(0, 300, 0, 230)

Frame.Position = UDim2.new(0, 20, 0.5, -115)

Frame.BackgroundColor3 = Color3.fromRGB(255,255,255)

Frame.BorderSizePixel = 0

Frame.Active = true

Frame.Draggable = true

Instance.new("UICorner", Frame)



local Title = Instance.new("TextLabel", Frame)

Title.Size = UDim2.new(1, 0, 0, 30)

Title.Text = "NEXUS UNANCHORED TP"

Title.TextColor3 = Color3.new(0,0,0)

Title.Font = Enum.Font.GothamBold

Title.TextSize = 14

Title.BackgroundTransparency = 1



-- Username Input

local UsernameBox = Instance.new("TextBox", Frame)

UsernameBox.PlaceholderText = "Enter Player Username"

UsernameBox.Size = UDim2.new(1, -20, 0, 30)

UsernameBox.Position = UDim2.new(0, 10, 0, 40)

UsernameBox.BackgroundColor3 = Color3.fromRGB(255,255,255)

UsernameBox.TextColor3 = Color3.new(0,0,0)

UsernameBox.Font = Enum.Font.Gotham

UsernameBox.TextSize = 14

UsernameBox.Text = ""

Instance.new("UICorner", UsernameBox)



-- Filter Label

local FilterLabel = Instance.new("TextLabel", Frame)

FilterLabel.Size = UDim2.new(1, -20, 0, 20)

FilterLabel.Position = UDim2.new(0, 10, 0, 80)

FilterLabel.Text = "Tool Filter:"

FilterLabel.TextColor3 = Color3.new(0,0,0)

FilterLabel.Font = Enum.Font.Gotham

FilterLabel.TextSize = 13

FilterLabel.BackgroundTransparency = 1



-- Filter Dropdown

local FilterDropdown = Instance.new("TextButton", Frame)

FilterDropdown.Size = UDim2.new(1, -20, 0, 30)

FilterDropdown.Position = UDim2.new(0, 10, 0, 100)

FilterDropdown.BackgroundColor3 = Color3.fromRGB(255,255,255)

FilterDropdown.Text = "All Tools"

FilterDropdown.TextColor3 = Color3.new(0,0,0)

FilterDropdown.Font = Enum.Font.Gotham

FilterDropdown.TextSize = 13

Instance.new("UICorner", FilterDropdown)



-- Cycle filter options

local filterModes = {"All Tools", "Guns Only", "Melee Only"}

local filterIndex = 1



FilterDropdown.MouseButton1Click:Connect(function()

	filterIndex = filterIndex + 1

	if filterIndex > #filterModes then

		filterIndex = 1

	end

	FilterDropdown.Text = filterModes[filterIndex]

end)



-- Filter logic

local function isToolAllowed(tool)

	local name = tool.Name:lower()



	if filterModes[filterIndex] == "All Tools" then

		return true

	elseif filterModes[filterIndex] == "Guns Only" then

		return name:find("gun") or name:find("pistol") or name:find("UZI") or name:find("silenced pistol") or name:find("desert deagle") or name:find("glock-17") or name:find("glock-19")

	elseif filterModes[filterIndex] == "Melee Only" then

		return name:find("knife") or name:find("bat") or name:find("knife") or name:find("blade") or name:find("crowbar")

	end



	return false

end



-- Main TP (tools fly to player)

local function teleportToolsToPlayer(targetPlayer)

	if not targetPlayer then

		warn("No player specified or player not found.")

		return

	end



	local root = targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart")

	if not root then

		warn("Target player has no HRP")

		return

	end



	for _, v in ipairs(Workspace:GetDescendants()) do

		if v:IsA("Tool") or (v:IsA("BasePart") and v.Name == "Handle") then

			local tool = v:IsA("Tool") and v or v:FindFirstAncestorWhichIsA("Tool")

			if tool and tool:IsDescendantOf(Workspace) and not tool:FindFirstChildOfClass("Humanoid") then

				local handle = tool:FindFirstChild("Handle")

				if handle and not handle.Anchored and isToolAllowed(tool) then

					if handle:FindFirstChild("BodyVelocity") then handle.BodyVelocity:Destroy() end

					local bv = Instance.new("BodyVelocity")

					bv.Velocity = (root.Position - handle.Position).Unit * 100

					bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)

					bv.P = 10000

					bv.Parent = handle

					Debris:AddItem(bv, 0.5)

				end

			end

		end

	end

end



-- Grab Tools to Backpack

local function grabToolsToBackpack()

	for _, v in ipairs(Workspace:GetDescendants()) do

		if v:IsA("Tool") and v:FindFirstChild("Handle") and not v.Handle.Anchored and isToolAllowed(v) then

			v.Parent = LocalPlayer.Backpack

		end

	end

end



-- TP Button

local TPButton = Instance.new("TextButton", Frame)

TPButton.Size = UDim2.new(1, -20, 0, 30)

TPButton.Position = UDim2.new(0, 10, 1, -75)

TPButton.BackgroundColor3 = Color3.fromRGB(255,255,255)

TPButton.Text = "Teleport Unanchored To Player"

TPButton.TextColor3 = Color3.new(0,0,0)

TPButton.Font = Enum.Font.GothamBold

TPButton.TextSize = 13

Instance.new("UICorner", TPButton)



-- Grab Button

local GrabButton = Instance.new("TextButton", Frame)

GrabButton.Size = UDim2.new(1, -20, 0, 30)

GrabButton.Position = UDim2.new(0, 10, 1, -40)

GrabButton.BackgroundColor3 = Color3.fromRGB(255,255,255)

GrabButton.Text = "Grab Tools"

GrabButton.TextColor3 = Color3.new(0,0,0)

GrabButton.Font = Enum.Font.GothamBold

GrabButton.TextSize = 13

Instance.new("UICorner", GrabButton)



-- Button Events

TPButton.MouseButton1Click:Connect(function()

	local inputName = UsernameBox.Text

	if inputName == "" then

		warn("No username entered.")

		return

	end



	local targetPlayer = Players:FindFirstChild(inputName)

	if not targetPlayer then

		warn("Player not found: " .. inputName)

		return

	end



	teleportToolsToPlayer(targetPlayer)

end)



GrabButton.MouseButton1Click:Connect(grabToolsToBackpack)

end)



addBtn("FLING ALL (MONSY)", function()

	game:GetService("StarterGui"):SetCore("SendNotification",{

    Title = "Script Executed";

    Text = "Fling All";

    Duration = 6;

})

 

local Targets = {"All"} -- "All", "Target Name", "arian_was_here"

 

local Players = game:GetService("Players")

local Player = Players.LocalPlayer

 

local AllBool = false

 

local GetPlayer = function(Name)

    Name = Name:lower()

    if Name == "all" or Name == "others" then

        AllBool = true

        return

    elseif Name == "random" then

        local GetPlayers = Players:GetPlayers()

        if table.find(GetPlayers,Player) then table.remove(GetPlayers,table.find(GetPlayers,Player)) end

        return GetPlayers[math.random(#GetPlayers)]

    elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then

        for _,x in next, Players:GetPlayers() do

            if x ~= Player then

                if x.Name:lower():match("^"..Name) then

                    return x;

                elseif x.DisplayName:lower():match("^"..Name) then

                    return x;

                end

            end

        end

    else

        return

    end

end

 

local Message = function(_Title, _Text, Time)

    game:GetService("StarterGui"):SetCore("SendNotification", {Title = _Title, Text = _Text, Duration = Time})

end

 

local SkidFling = function(TargetPlayer)

    local Character = Player.Character

    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

    local RootPart = Humanoid and Humanoid.RootPart

 

    local TCharacter = TargetPlayer.Character

    local THumanoid

    local TRootPart

    local THead

    local Accessory

    local Handle

 

    if TCharacter:FindFirstChildOfClass("Humanoid") then

        THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")

    end

    if THumanoid and THumanoid.RootPart then

        TRootPart = THumanoid.RootPart

    end

    if TCharacter:FindFirstChild("Head") then

        THead = TCharacter.Head

    end

    if TCharacter:FindFirstChildOfClass("Accessory") then

        Accessory = TCharacter:FindFirstChildOfClass("Accessory")

    end

    if Accessoy and Accessory:FindFirstChild("Handle") then

        Handle = Accessory.Handle

    end

 

    if Character and Humanoid and RootPart then

        if RootPart.Velocity.Magnitude < 50 then

            getgenv().OldPos = RootPart.CFrame

        end

        if THumanoid and THumanoid.Sit and not AllBool then

            return Message("Error Occurred", "Targeting is sitting", 5) -- u can remove dis part if u want lol

        end

        if THead then

            workspace.CurrentCamera.CameraSubject = THead

        elseif not THead and Handle then

            workspace.CurrentCamera.CameraSubject = Handle

        elseif THumanoid and TRootPart then

            workspace.CurrentCamera.CameraSubject = THumanoid

        end

        if not TCharacter:FindFirstChildWhichIsA("BasePart") then

            return

        end

 

        local FPos = function(BasePart, Pos, Ang)

            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang

            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)

            RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)

            RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)

        end

 

        local SFBasePart = function(BasePart)

            local TimeToWait = 2

            local Time = tick()

            local Angle = 0

 

            repeat

                if RootPart and THumanoid then

                    if BasePart.Velocity.Magnitude < 50 then

                        Angle = Angle + 100

 

                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))

                        task.wait()

 

                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))

                        task.wait()

 

                        FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))

                        task.wait()

 

                        FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))

                        task.wait()

 

                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))

                        task.wait()

 

                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))

                        task.wait()

                    else

                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))

                        task.wait()

 

                        FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))

                        task.wait()

 

                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))

                        task.wait()

 

                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))

                        task.wait()

 

                        FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))

                        task.wait()

 

                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))

                        task.wait()

 

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))

                        task.wait()

 

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))

                        task.wait()

 

                        FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))

                        task.wait()

 

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))

                        task.wait()

                    end

                else

                    break

                end

            until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait

        end

 

        workspace.FallenPartsDestroyHeight = 0/0

 

        local BV = Instance.new("BodyVelocity")

        BV.Name = "EpixVel"

        BV.Parent = RootPart

        BV.Velocity = Vector3.new(9e8, 9e8, 9e8)

        BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)

 

        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

 

        if TRootPart and THead then

            if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then

                SFBasePart(THead)

            else

                SFBasePart(TRootPart)

            end

        elseif TRootPart and not THead then

            SFBasePart(TRootPart)

        elseif not TRootPart and THead then

            SFBasePart(THead)

        elseif not TRootPart and not THead and Accessory and Handle then

            SFBasePart(Handle)

        else

            return Message("Error Occurred", "Target is missing everything", 5)

        end

 

        BV:Destroy()

        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)

        workspace.CurrentCamera.CameraSubject = Humanoid

 

        repeat

            RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)

            Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))

            Humanoid:ChangeState("GettingUp")

            table.foreach(Character:GetChildren(), function(_, x)

                if x:IsA("BasePart") then

                    x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()

                end

            end)

            task.wait()

        until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25

        workspace.FallenPartsDestroyHeight = getgenv().FPDH

    else

        return Message("Error Ocurrido", "El Script A Fallado", 5)

    end

end

 

if not Welcome then Message("By Augus X", "", 6) end

getgenv().Welcome = true

if Targets[1] then for _,x in next, Targets do GetPlayer(x) end else return end

 

if AllBool then

    for _,x in next, Players:GetPlayers() do

        SkidFling(x)

    end

end

 

for _,x in next, Targets do

    if GetPlayer(x) and GetPlayer(x) ~= Player then

        if GetPlayer(x).UserId ~= 2924145477 then

            local TPlayer = GetPlayer(x)

            if TPlayer then

                SkidFling(TPlayer)

            end

        else

            Message("ERROR AL ASER FLING", "", 8)

        end

    elseif not GetPlayer(x) and not AllBool then

        Message("ERROR OCURRIDO", "NO SE LE ISO FLING", 8)

    end

end

end)



addBtn("HITBOX EXTENDER (MONSY)", function()

	loadstring(game:HttpGet("https://raw.githubusercontent.com/LisSploit/HitBoxExtender/main/Universal",true))()

end)



