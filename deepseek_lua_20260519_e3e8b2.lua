--[[ NEXUS MENU - MODIFIED VERSION ]]--

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function new(class, props)
	local obj = Instance.new(class)
	if props then
		for k,v in pairs(props) do
			obj[k] = v
		end
	end
	return obj
end

local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://315416964"
clickSound.Volume = 0.5
clickSound.Parent = playerGui

local currentTheme = "BLACK"
local themes = {
	BLACK = {primary = Color3.fromRGB(255,255,255), accent = Color3.fromRGB(60,60,60)},
}

local screenGui = new("ScreenGui", {
	Name = "NEXUS_GUI",
	ResetOnSpawn = false,
	Parent = playerGui,
	DisplayOrder = 1000,
})

-- ============ FALLING WHITE DOTS (Nakadikit sa GUI) ============
local particleContainer = new("Frame", {
	Parent = main,  -- NAKADIKIT SA MAIN FRAME
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundTransparency = 1,
	Active = false,
	ZIndex = 0,
})

local dots = {}
local DOT_COUNT = 60

for i = 1, DOT_COUNT do
	local dot = new("Frame", {
		Parent = particleContainer,
		Size = UDim2.new(0, math.random(2, 4), 0, math.random(2, 4)),
		Position = UDim2.new(math.random(), 0, math.random(), 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		BackgroundTransparency = math.random(30, 70) / 100,
	})
	new("UICorner", {CornerRadius = UDim.new(1, 0), Parent = dot})
	
	local speed = math.random(10, 40)
	local startX = dot.Position.X.Scale
	table.insert(dots, {dot, speed, startX})
end

task.spawn(function()
	while true do
		task.wait(0.03)
		for _, data in ipairs(dots) do
			local dot, speed, startX = data[1], data[2], data[3]
			local newY = dot.Position.Y.Scale + (speed / 5000)
			if newY > 1 then
				newY = 0
				dot.Position = UDim2.new(startX, 0, newY, 0)
			else
				dot.Position = UDim2.new(startX, 0, newY, 0)
			end
		end
	end
end)
-- ============================================

-- MAIN FRAME (DARK BLACK)
local main = new("Frame", {
	Name = "MainFrame",
	Size = UDim2.new(0, 860, 0, 520),
	Position = UDim2.new(0.5, -430, 0.5, -260),
	BackgroundColor3 = Color3.fromRGB(15, 15, 15),  -- DARK BLACK
	BorderSizePixel = 0,
	Parent = screenGui,
	ClipsDescendants = false,
})
new("UICorner", {CornerRadius = UDim.new(0,12), Parent = main})

-- Make draggable
local dragging, dragInput, dragStart, startPos
local function update(input)
	local delta = input.Position - dragStart
	main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
		startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

main.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

-- Left Panel (DARK)
local leftPanel = new("Frame", {
	Name = "LeftPanel",
	Size = UDim2.new(0, 220, 1, 0),
	BackgroundColor3 = Color3.fromRGB(20, 20, 20),
	BorderSizePixel = 0,
	Parent = main,
})
new("UICorner", {CornerRadius = UDim.new(0,12), Parent = leftPanel})

local divider = new("Frame", {
	Parent = leftPanel,
	Size = UDim2.new(0, 1, 1, -24),
	Position = UDim2.new(1, -1, 0, 12),
	BackgroundColor3 = Color3.fromRGB(50, 50, 50),
	BorderSizePixel = 0,
})

new("TextLabel", {
	Parent = leftPanel,
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 14, 0, 14),
	Size = UDim2.new(1, -28, 0, 32),
	Text = "NEXUS MENU V2",
	Font = Enum.Font.GothamBlack,
	TextSize = 25,
	TextColor3 = Color3.new(255,255,255),
	TextXAlignment = Enum.TextXAlignment.Left,
})

local avatarFrame = new("Frame", {
	Parent = leftPanel,
	BackgroundColor3 = Color3.fromRGB(30, 30, 30),
	Size = UDim2.new(0, 100, 0, 100),
	Position = UDim2.new(0.5, -50, 0, 60),
	BorderSizePixel = 0,
	ClipsDescendants = true,
})

local ring = new("Frame", {
	Parent = avatarFrame,
	Size = UDim2.new(1,0,1,0),
	BackgroundColor3 = Color3.fromRGB(80, 80, 80),
	BorderSizePixel = 0,
})
new("UICorner", {CornerRadius = UDim.new(1,0), Parent = ring})

local inner = new("Frame", {
	Parent = ring,
	Size = UDim2.new(0.86,0,0.86,0),
	Position = UDim2.new(0.07,0,0.07,0),
	BackgroundColor3 = Color3.fromRGB(20,20,20),
	BorderSizePixel = 0,
})
new("UICorner", {CornerRadius = UDim.new(1,0), Parent = inner})

local avatar = new("ImageLabel", {
	Parent = inner,
	BackgroundTransparency = 1,
	Size = UDim2.new(1,0,1,0),
	Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150),
})
new("UICorner", {CornerRadius = UDim.new(1,0), Parent = avatar})

new("TextLabel", {
	Parent = leftPanel,
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 0, 0, 170),
	Size = UDim2.new(1, 0, 0, 28),
	Text = player.DisplayName,
	Font = Enum.Font.GothamBold,
	TextSize = 16,
	TextColor3 = Color3.new(255,255,255),
	TextXAlignment = Enum.TextXAlignment.Center,
})

new("TextLabel", {
	Parent = leftPanel,
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 0, 0, 194),
	Size = UDim2.new(1, 0, 0, 20),
	Text = "@" .. player.Name,
	Font = Enum.Font.Gotham,
	TextSize = 13,
	TextColor3 = Color3.fromRGB(150,150,150),
	TextXAlignment = Enum.TextXAlignment.Center,
})

local socialLine = new("Frame", {
	Parent = leftPanel,
	Size = UDim2.new(0.8, 0, 0, 1),
	Position = UDim2.new(0.1, 0, 0, 260),
	BackgroundColor3 = Color3.fromRGB(50,50,50),
	BorderSizePixel = 0,
})

new("TextLabel", {
	Parent = leftPanel,
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 0, 0, 310),
	Size = UDim2.new(1, 0, 0, 120),
	Text = "@nexus\n\nDiscord: nexus\n\nTiktok: nexus\n\nYoutube: nexus",
	Font = Enum.Font.Gotham,
	TextSize = 12,
	TextColor3 = Color3.fromRGB(180,180,180),
	TextXAlignment = Enum.TextXAlignment.Center,
	TextYAlignment = Enum.TextYAlignment.Top,
	TextWrapped = true,
})

-- Right Panel (DARK)
local rightPanel = new("Frame", {
	Name = "RightPanel",
	Parent = main,
	Size = UDim2.new(1, -220, 1, -50),
	Position = UDim2.new(0, 220, 0, 0),
	BackgroundColor3 = Color3.fromRGB(15, 15, 15),
	BorderSizePixel = 0,
})
new("UICorner", {CornerRadius = UDim.new(0,12), Parent = rightPanel})

local titleLabel = new("TextLabel", {
	Parent = rightPanel,
	Position = UDim2.new(0, 16, 0, 12),
	Size = UDim2.new(1, -32, 0, 32),
	BackgroundTransparency = 1,
	Text = "MAIN MENU",
	Font = Enum.Font.GothamBold,
	TextSize = 20,
	TextColor3 = Color3.new(255,255,255),
	TextXAlignment = Enum.TextXAlignment.Left,
})

local tabBar = new("ScrollingFrame", {
	Parent = rightPanel,
	Position = UDim2.new(0, 16, 0, 56),
	Size = UDim2.new(1, -32, 0, 44),
	BackgroundColor3 = Color3.fromRGB(25, 25, 25),
	BorderSizePixel = 0,
	ScrollBarThickness = 6,
	ScrollBarImageColor3 = Color3.fromRGB(80,80,80),
	CanvasSize = UDim2.new(0,0,0,0),
	ScrollingDirection = Enum.ScrollingDirection.X,
	AutomaticCanvasSize = Enum.AutomaticSize.X,
})
new("UICorner", {CornerRadius = UDim.new(0,8), Parent = tabBar})

local tabLayout = new("UIListLayout", {
	Parent = tabBar,
	FillDirection = Enum.FillDirection.Horizontal,
	Padding = UDim.new(0, 8),
	SortOrder = Enum.SortOrder.LayoutOrder,
})

local contentArea = new("Frame", {
	Parent = rightPanel,
	Position = UDim2.new(0, 16, 0, 108),
	Size = UDim2.new(1, -32, 1, -166),
	BackgroundTransparency = 1,
	ClipsDescendants = true,
})

local bottomBar = new("Frame", {
	Parent = main,
	Position = UDim2.new(0, 220, 1, -50),
	Size = UDim2.new(1, -220, 0, 50),
	BackgroundColor3 = Color3.fromRGB(20, 20, 20),
	BorderSizePixel = 0,
})
new("UICorner", {CornerRadius = UDim.new(0,12), Parent = bottomBar})

local allTabButtons = {}
local allTabPanels = {}
local currentTab = "MAIN MENU"

local function showTab(name)
	if currentTab == name then return end
	if currentTab and allTabPanels[currentTab] then
		allTabPanels[currentTab].Visible = false
	end
	currentTab = name
	if allTabPanels[name] then
		allTabPanels[name].Visible = true
	end
	titleLabel.Text = name
	local t = themes[currentTheme]
	for _, obj in ipairs(screenGui:GetDescendants()) do
		if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
			obj.TextColor3 = t.primary
		end
	end
	if divider then divider.BackgroundColor3 = Color3.fromRGB(50,50,50) end
	if ring then ring.BackgroundColor3 = Color3.fromRGB(80,80,80) end
	for _, btn in ipairs(allTabButtons) do
		if currentTab == btn.Text then
			btn.BackgroundColor3 = t.accent
		else
			btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
		end
	end
end

-- TOP TABS (lahat ng original)
local topTabNames = {
	"MAIN MENU", "ROLEPLAY MENU", "ROLEPLAY MENU 2", "LATEST SCRIPT",
	"BRING MENU", "AIMBOT MENU", "SCRIPT MENU", "CASH MENU", "PLAYER MENU",
	"NEXUS MENU", "THE BILLIONARE", "RP TELEPORT", "ADMIN PANEL", "REMOTES"
}

local function createTopTab(name)
	local btn = new("TextButton", {
		Parent = tabBar,
		Size = UDim2.new(0, 110, 1, -12),
		BackgroundColor3 = Color3.fromRGB(30,30,30),
		Text = name,
		Font = Enum.Font.GothamSemibold,
		TextSize = 13,
		TextColor3 = Color3.new(255,255,255),
		AutoButtonColor = false,
		TextXAlignment = Enum.TextXAlignment.Center,
	})
	new("UICorner", {CornerRadius = UDim.new(0,6), Parent = btn})

	btn.MouseEnter:Connect(function()
		if currentTab ~= name then
			TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(50,50,50)}):Play()
		end
	end)
	btn.MouseLeave:Connect(function()
		if currentTab ~= name then
			TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(30,30,30)}):Play()
		end
	end)

	btn.MouseButton1Click:Connect(function()
		clickSound:Play()
		showTab(name)
	end)

	local panel = new("ScrollingFrame", {
		Parent = contentArea,
		Size = UDim2.new(1,0,1,0),
		BackgroundTransparency = 1,
		Visible = false,
		ScrollBarThickness = 6,
		ScrollBarImageColor3 = Color3.fromRGB(80,80,80),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
	})
	new("UIListLayout", {Parent = panel, Padding = UDim.new(0,8)})

	allTabPanels[name] = panel
	table.insert(allTabButtons, btn)
	return panel
end

for _, name in ipairs(topTabNames) do
	createTopTab(name)
end

-- BOTTOM TABS
local bottomTabs = {"PLAYER LIST", "SETTINGS", "LUA EXECUTOR"}

local function createBottomTab(name)
	local btn = new("TextButton", {
		Parent = bottomBar,
		Size = UDim2.new(0, 140, 1, -16),
		BackgroundColor3 = Color3.fromRGB(30,30,30),
		Text = name,
		Font = Enum.Font.GothamSemibold,
		TextSize = 14,
		TextColor3 = Color3.new(255,255,255),
		AutoButtonColor = false,
	})
	new("UICorner", {CornerRadius = UDim.new(0,6), Parent = btn})

	local function positionButton()
		local totalWidth = #bottomTabs * 140 + (#bottomTabs-1) * 16
		local startX = (bottomBar.AbsoluteSize.X - totalWidth) / 2
		btn.Position = UDim2.new(0, startX + (table.find(bottomTabs, name)-1)*(140+16), 0, 8)
	end
	task.delay(0, positionButton)
	bottomBar:GetPropertyChangedSignal("AbsoluteSize"):Connect(positionButton)

	btn.MouseButton1Click:Connect(function()
		clickSound:Play()
		showTab(name)
	end)

	local panel = new("ScrollingFrame", {
		Parent = contentArea,
		Size = UDim2.new(1,0,1,0),
		BackgroundTransparency = 1,
		Visible = false,
		ScrollBarThickness = 6,
		ScrollBarImageColor3 = Color3.fromRGB(80,80,80),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
	})
	new("UIListLayout", {Parent = panel, Padding = UDim.new(0,8)})

	allTabPanels[name] = panel
	table.insert(allTabButtons, btn)
	return panel
end

for _, name in ipairs(bottomTabs) do
	createBottomTab(name)
end

if allTabButtons[1] then
	allTabButtons[1].BackgroundColor3 = Color3.fromRGB(60,60,60)
end
showTab("MAIN MENU")

-- BUTTON CREATOR
local function addMainMenuButton(text, callback)
	local panel = allTabPanels["MAIN MENU"]
	if not panel then return end
	local btn = new("TextButton", {
		Size = UDim2.new(1, -16, 0, 38),
		BackgroundColor3 = Color3.fromRGB(30,30,30),
		TextColor3 = Color3.new(255,255,255),
		Font = Enum.Font.GothamSemibold,
		TextSize = 14,
		Text = text,
		AutoButtonColor = false,
		Parent = panel,
	})
	new("UICorner", {CornerRadius = UDim.new(0,6), Parent = btn})
	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(50,50,50)}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(30,30,30)}):Play()
	end)
	btn.MouseButton1Click:Connect(function()
		clickSound:Play()
		callback()
	end)
end

-- ============ MGA BUTTONS (PINALITAN NG NEXUS) ============
addMainMenuButton("INFINITE YIELD (NEXUS)", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

addMainMenuButton("MUSIC EXPLOITS (NEXUS)", function()
	-- Music script (original)
	local CoreGui = game:GetService("CoreGui")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Workspace = game:GetService("Workspace")
	local InjectTo = game:GetService("TestService")

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
	local gui = Instance.new("ScreenGui", CoreGui)
	gui.Name = "NEXUS_MUSIC_GUI"
	gui.ResetOnSpawn = false

	local main = Instance.new("Frame", gui)
	main.Size = UDim2.new(0, 300, 0, 120)
	main.Position = UDim2.new(0.5, -150, 0.5, -60)
	main.BackgroundColor3 = Color3.fromRGB(20,20,20)
	main.BorderSizePixel = 0
	main.Active = true
	main.Draggable = true
	Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

	local title = Instance.new("TextLabel", main)
	title.Size = UDim2.new(1, 0, 0.25, 0)
	title.Position = UDim2.new(0, 0, 0, 0)
	title.Text = "NEXUS MUSIC EXPLOITS"
	title.TextColor3 = Color3.fromRGB(255,255,255)
	title.BackgroundTransparency = 1
	title.Font = Enum.Font.SourceSansBold
	title.TextSize = 22

	local inputBox = Instance.new("TextBox", main)
	inputBox.Size = UDim2.new(0.9, 0, 0.25, 0)
	inputBox.Position = UDim2.new(0.05, 0, 0.35, 0)
	inputBox.PlaceholderText = "Enter Music ID"
	inputBox.Text = ""
	inputBox.TextColor3 = Color3.fromRGB(255,255,255)
	inputBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
	inputBox.Font = Enum.Font.SourceSansBold
	inputBox.TextSize = 18
	inputBox.ClearTextOnFocus = false
	Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0, 6)

	local toggleButton = Instance.new("TextButton", main)
	toggleButton.Size = UDim2.new(0.5, 0, 0.2, 0)
	toggleButton.Position = UDim2.new(0.25, 0, 0.7, 0)
	toggleButton.Text = "OFF"
	toggleButton.TextColor3 = Color3.fromRGB(255,255,255)
	toggleButton.BackgroundColor3 = Color3.fromRGB(40,40,40)
	toggleButton.Font = Enum.Font.SourceSansBold
	toggleButton.TextSize = 24
	Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 6)

	local isOn = false
	local soundName = "NEXUS_SOUND_" .. tostring(math.random(1000,9999))

	toggleButton.MouseButton1Click:Connect(function()
		isOn = not isOn
		if isOn then
			toggleButton.Text = "ON"
			local id = inputBox.Text
			if id == "" then return end
			if remote then
				pcall(function()
					remote:FireServer("newSound", soundName, InjectTo, "rbxassetid://" .. id, 1, 1, true, 0)
					remote:FireServer("playSound", soundName)
				end)
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

addMainMenuButton("ESP PLAYER (NEXUS)", function()
	-- ESP script (same as original but with white lines/nametags)
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local Camera = workspace.CurrentCamera
	local LocalPlayer = Players.LocalPlayer

	local gui = Instance.new("ScreenGui")
	gui.Name = "ESP_Toggle_GUI"
	gui.ResetOnSpawn = false
	gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

	local toggleButton = Instance.new("TextButton")
	toggleButton.Size = UDim2.new(0, 100, 0, 35)
	toggleButton.Position = UDim2.new(0, 20, 0, 120)
	toggleButton.BackgroundColor3 = Color3.fromRGB(30,30,30)
	toggleButton.TextColor3 = Color3.fromRGB(255,255,255)
	toggleButton.Text = "ESP: ON"
	toggleButton.Font = Enum.Font.GothamBold
	toggleButton.TextSize = 14
	toggleButton.Parent = gui
	Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 6)

	local ESP_ENABLED = true
	local ESPObjects = {}

	local function newLine()
		local line = Drawing.new("Line")
		line.Thickness = 2
		line.Color = Color3.fromRGB(255, 255, 255)
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
						Name = newText(),
					}
					ESPObjects[player] = esp
				end
				local head = char:FindFirstChild("Head")
				local torso = char:FindFirstChild("HumanoidRootPart")
				if head and torso then
					local headPos, headVis = Camera:WorldToViewportPoint(head.Position)
					local torsoPos, torsoVis = Camera:WorldToViewportPoint(torso.Position)
					if headVis and torsoVis then
						esp.HeadToTorso.From = Vector2.new(headPos.X, headPos.Y)
						esp.HeadToTorso.To = Vector2.new(torsoPos.X, torsoPos.Y)
						esp.HeadToTorso.Visible = true
					end
					if headVis then
						esp.Name.Position = Vector2.new(headPos.X, headPos.Y - 20)
						esp.Name.Text = player.Name
						esp.Name.Visible = true
					end
				end
			end
		end
	end)

	toggleButton.MouseButton1Click:Connect(function()
		ESP_ENABLED = not ESP_ENABLED
		toggleButton.Text = ESP_ENABLED and "ESP: ON" or "ESP: OFF"
	end)
end)

addMainMenuButton("BIG HEAD PLAYER (NEXUS)", function()
	_G.HeadSize = 6 
	_G.Disabled = true 
	game:GetService('RunService').RenderStepped:connect(function() 
		if _G.Disabled then 
			for i,v in next, game:GetService('Players'):GetPlayers() do 
				if v.Name ~= game:GetService('Players').LocalPlayer.Name then 
					pcall(function() 
						v.Character.Head.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize) 
						v.Character.Head.Transparency = 0.4 
						v.Character.Head.BrickColor = BrickColor.new("Red") 
						v.Character.Head.Material = "Neon" 
						v.Character.Head.CanCollide = false 
						v.Character.Head.Massless = true 
					end) 
				end 
			end 
		end 
	end)
end)

addMainMenuButton("KEYBIND Q TO FREECAM (NEXUS)", function()
	-- Freecam script (same as original)
	local Players = game:GetService("Players")
	local UserInputService = game:GetService("UserInputService")
	local RunService = game:GetService("RunService")
	local player = Players.LocalPlayer
	local cam = workspace.CurrentCamera
	local MOVE_SPEED = 60
	local SPRINT_MULTIPLIER = 2
	local MOUSE_SENSITIVITY = 0.15
	local MAX_PITCH = 89
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
	local justToggled = false

	local function addKeyDirection(key)
		if key == Enum.KeyCode.W then moveDir += Vector3.new(0,0,1) end
		if key == Enum.KeyCode.S then moveDir += Vector3.new(0,0,-1) end
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

	local function toggleFreecam()
		enabled = not enabled
		moveDir = Vector3.new()
		sprint = false
		justToggled = true
		if enabled then
			originalCameraType = cam.CameraType
			originalMouseBehavior = UserInputService.MouseBehavior
			originalMouseIconEnabled = UserInputService.MouseIconEnabled
			if player.Character then
				humanoid = player.Character:FindFirstChildOfClass("Humanoid")
				if humanoid then
					savedWalkSpeed = humanoid.WalkSpeed
					savedJumpPower = humanoid.JumpPower
					humanoid.WalkSpeed = 0
					humanoid.JumpPower = 0
				end
			end
			local x, y, z = cam.CFrame:ToEulerAnglesYXZ()
			pitch = math.deg(x)
			yaw = math.deg(y)
			cam.CameraType = Enum.CameraType.Scriptable
			UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
			UserInputService.MouseIconEnabled = false
		else
			if humanoid then
				humanoid.WalkSpeed = savedWalkSpeed or 16
				humanoid.JumpPower = savedJumpPower or 50
			end
			cam.CameraType = originalCameraType or Enum.CameraType.Custom
			UserInputService.MouseBehavior = originalMouseBehavior or Enum.MouseBehavior.Default
			UserInputService.MouseIconEnabled = originalMouseIconEnabled
		end
	end

	UserInputService.InputBegan:Connect(function(input, gpe)
		if gpe then return end
		if input.KeyCode == Enum.KeyCode.Q then
			toggleFreecam()
			return
		end
		if justToggled then return end
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
		if justToggled then return end
		if input.KeyCode == Enum.KeyCode.LeftShift then
			sprint = false
		else
			removeKeyDirection(input.KeyCode)
		end
	end)

	UserInputService.InputChanged:Connect(function(input, gpe)
		if not enabled then return end
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			yaw -= input.Delta.X * MOUSE_SENSITIVITY
			pitch = math.clamp(pitch - input.Delta.Y * MOUSE_SENSITIVITY, -MAX_PITCH, MAX_PITCH)
		end
	end)

	RunService.RenderStepped:Connect(function(dt)
		if justToggled then
			justToggled = false
		end
		if not enabled then return end
		local rot = CFrame.Angles(0, math.rad(yaw), 0) * CFrame.Angles(math.rad(pitch), 0, 0)
		local localMove = (rot.RightVector * moveDir.X + rot.UpVector * moveDir.Y + rot.LookVector * moveDir.Z)
		local speed = MOVE_SPEED * (sprint and SPRINT_MULTIPLIER or 1)
		local newPos = cam.CFrame.Position + localMove * speed * dt
		cam.CFrame = CFrame.new(newPos) * rot
	end)
end)

addMainMenuButton("AIMBOT ADJUSTABLE (NEXUS)", function()
	getgenv().Environment = {
		FOVSettings = { Amount = 150, Visible = true, Color = Color3.fromRGB(255, 255, 255) },
		Aimbot = { Enabled = true, AimPart = "Head" }
	}
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local UIS = game:GetService("UserInputService")
	local RunService = game:GetService("RunService")
	local Circle = Drawing.new("Circle")
	Circle.Radius = Environment.FOVSettings.Amount
	Circle.Thickness = 2
	Circle.Transparency = 1
	Circle.Filled = false
	Circle.Color = Environment.FOVSettings.Color
	
	RunService.RenderStepped:Connect(function()
		Circle.Position = UIS:GetMouseLocation()
		Circle.Visible = Environment.FOVSettings.Visible
		Circle.Radius = Environment.FOVSettings.Amount
	end)
	
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
	
	local ScreenGui = Instance.new("ScreenGui")
	local Frame = Instance.new("Frame")
	local Title = Instance.new("TextLabel")
	local SliderBack = Instance.new("Frame")
	local SliderFill = Instance.new("Frame")
	local SliderButton = Instance.new("TextButton")
	local FOVLabel = Instance.new("TextLabel")
	local ToggleButton = Instance.new("TextButton")
	
	ScreenGui.Parent = game.CoreGui
	Frame.Size = UDim2.new(0, 220, 0, 140)
	Frame.Position = UDim2.new(0, 50, 0, 50)
	Frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
	Frame.BorderSizePixel = 0
	Frame.Active = true
	Frame.Draggable = true
	Frame.Parent = ScreenGui
	
	Title.Size = UDim2.new(1, 0, 0, 30)
	Title.BackgroundTransparency = 1
	Title.Text = "NEXUS AIMBOT"
	Title.TextColor3 = Color3.fromRGB(255,255,255)
	Title.TextSize = 16
	Title.Font = Enum.Font.SourceSansBold
	Title.Parent = Frame
	
	SliderBack.Size = UDim2.new(0.8, 0, 0, 6)
	SliderBack.Position = UDim2.new(0.1, 0, 0.35, 0)
	SliderBack.BackgroundColor3 = Color3.fromRGB(40,40,40)
	SliderBack.BorderSizePixel = 0
	SliderBack.Parent = Frame
	
	SliderFill.Size = UDim2.new(0.5, 0, 1, 0)
	SliderFill.BackgroundColor3 = Color3.fromRGB(255,255,255)
	SliderFill.BorderSizePixel = 0
	SliderFill.Parent = SliderBack
	
	SliderButton.Size = UDim2.new(0, 20, 0, 20)
	SliderButton.Position = UDim2.new(0.5, -10, 0.5, -10)
	SliderButton.BackgroundColor3 = Color3.fromRGB(255,255,255)
	SliderButton.Text = ""
	SliderButton.BorderSizePixel = 0
	SliderButton.Parent = Frame
	
	FOVLabel.Size = UDim2.new(1, 0, 0, 20)
	FOVLabel.Position = UDim2.new(0, 0, 0.45, 0)
	FOVLabel.BackgroundTransparency = 1
	FOVLabel.TextColor3 = Color3.fromRGB(255,255,255)
	FOVLabel.TextSize = 14
	FOVLabel.Font = Enum.Font.SourceSans
	FOVLabel.Text = "FOV: " .. Environment.FOVSettings.Amount
	FOVLabel.Parent = Frame
	
	ToggleButton.Size = UDim2.new(0.8, 0, 0, 30)
	ToggleButton.Position = UDim2.new(0.1, 0, 0.7, 0)
	ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
	ToggleButton.TextColor3 = Color3.fromRGB(255,255,255)
	ToggleButton.TextSize = 14
	ToggleButton.Font = Enum.Font.SourceSansBold
	ToggleButton.Text = "FOV: Visible"
	ToggleButton.Parent = Frame
	
	local dragging = false
	local function updateFOV(percent)
		percent = math.clamp(percent, 0, 1)
		SliderFill.Size = UDim2.new(percent, 0, 1, 0)
		SliderButton.Position = UDim2.new(percent, -10, 0.5, -10)
		local newFOV = math.floor(50 + percent * 400)
		Environment.FOVSettings.Amount = newFOV
		FOVLabel.Text = "FOV: " .. newFOV
	end
	
	SliderButton.MouseButton1Down:Connect(function() dragging = true end)
	UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
	UIS.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local percent = (UIS:GetMouseLocation().X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X
			updateFOV(percent)
		end
	end)
	
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
	updateFOV((Environment.FOVSettings.Amount - 50) / 400)
end)

addMainMenuButton("FADED GUI UNIVERSAL (NEXUS)", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/NighterEpic/Faded-Grid/main/YesEpic", true))()
end)

addMainMenuButton("LOOP BRING ALL (NEXUS)", function()
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local LocalPlayer = Players.LocalPlayer
	local loopEnabled = false
	local originalPositions = {}
	
	local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
	local Frame = Instance.new("Frame", ScreenGui)
	Frame.Size = UDim2.new(0, 300, 0, 100)
	Frame.Position = UDim2.new(0.5, -150, 0, 50)
	Frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
	Frame.BorderSizePixel = 0
	Frame.Active = true
	Frame.Draggable = true
	Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)
	
	local Title = Instance.new("TextLabel", Frame)
	Title.Size = UDim2.new(1, 0, 0.4, 0)
	Title.BackgroundTransparency = 1
	Title.Font = Enum.Font.SourceSansBold
	Title.TextSize = 18
	Title.Text = "NEXUS LOOP BRING ALL"
	Title.TextColor3 = Color3.fromRGB(255,255,255)
	
	local StatusButton = Instance.new("TextButton", Frame)
	StatusButton.Size = UDim2.new(1, 0, 0.6, 0)
	StatusButton.Position = UDim2.new(0, 0, 0.4, 0)
	StatusButton.Font = Enum.Font.SourceSansBold
	StatusButton.TextSize = 20
	StatusButton.Text = "OFF"
	StatusButton.BackgroundColor3 = Color3.fromRGB(30,30,30)
	StatusButton.TextColor3 = Color3.fromRGB(255,255,255)
	
	StatusButton.MouseButton1Click:Connect(function()
		loopEnabled = not loopEnabled
		if loopEnabled then
			originalPositions = {}
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
					originalPositions[plr.Name] = plr.Character.HumanoidRootPart.CFrame
				end
			end
			StatusButton.Text = "ON"
		else
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
					local savedPos = originalPositions[plr.Name]
					if savedPos then
						plr.Character.HumanoidRootPart.CFrame = savedPos
					end
				end
			end
			StatusButton.Text = "OFF"
		end
	end)
	
	RunService.RenderStepped:Connect(function()
		if loopEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = LocalPlayer.Character.HumanoidRootPart
			local targetPos = hrp.Position + (hrp.CFrame.LookVector * 5)
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
					plr.Backpack:ClearAllChildren()
					for _, tool in pairs(plr.Character:GetChildren()) do
						if tool:IsA("Tool") then
							tool:Destroy()
						end
					end
					plr.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos)
				end
			end
		end
	end)
end)

addMainMenuButton("PLAYER SCANNER (NEXUS)", function()
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local UIS = game:GetService("UserInputService")
	
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	ScreenGui.ResetOnSpawn = false
	
	local MainFrame = Instance.new("Frame")
	MainFrame.Size = UDim2.new(0, 350, 0, 400)
	MainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
	MainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
	MainFrame.BorderSizePixel = 0
	MainFrame.Visible = true
	MainFrame.Active = true
	MainFrame.Draggable = true
	MainFrame.Parent = ScreenGui
	Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
	
	local Title = Instance.new("TextLabel")
	Title.Size = UDim2.new(1, 0, 0, 40)
	Title.BackgroundTransparency = 1
	Title.Text = "NEXUS PLAYER SCANNER"
	Title.TextColor3 = Color3.fromRGB(255,255,255)
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 18
	Title.Parent = MainFrame
	
	local ScanButton = Instance.new("TextButton")
	ScanButton.Size = UDim2.new(0.9, 0, 0, 35)
	ScanButton.Position = UDim2.new(0.05, 0, 0, 50)
	ScanButton.BackgroundColor3 = Color3.fromRGB(30,30,30)
	ScanButton.TextColor3 = Color3.fromRGB(255,255,255)
	ScanButton.Font = Enum.Font.GothamBold
	ScanButton.TextSize = 16
	ScanButton.Text = "SCAN"
	ScanButton.AutoButtonColor = false
	ScanButton.Parent = MainFrame
	Instance.new("UICorner", ScanButton).CornerRadius = UDim.new(0, 6)
	
	local PlayerListFrame = Instance.new("ScrollingFrame")
	PlayerListFrame.Size = UDim2.new(0.9, 0, 0, 280)
	PlayerListFrame.Position = UDim2.new(0.05, 0, 0, 95)
	PlayerListFrame.BackgroundTransparency = 1
	PlayerListFrame.BorderSizePixel = 0
	PlayerListFrame.ScrollBarThickness = 6
	PlayerListFrame.Parent = MainFrame
	
	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.Parent = PlayerListFrame
	UIListLayout.Padding = UDim.new(0, 4)
	
	local function AddHoverEffect(button)
		button.MouseEnter:Connect(function()
			button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		end)
		button.MouseLeave:Connect(function()
			button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		end)
	end
	
	local function CreatePlayerButton(plr)
		local PlayerButton = Instance.new("TextButton")
		PlayerButton.Size = UDim2.new(1, 0, 0, 30)
		PlayerButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		PlayerButton.TextColor3 = Color3.fromRGB(255,255,255)
		PlayerButton.Font = Enum.Font.Gotham
		PlayerButton.TextSize = 14
		PlayerButton.Text = plr.DisplayName .. " (@" .. plr.Name .. ")"
		PlayerButton.AutoButtonColor = false
		PlayerButton.Parent = PlayerListFrame
		Instance.new("UICorner", PlayerButton).CornerRadius = UDim.new(0, 6)
		AddHoverEffect(PlayerButton)
		
		local ActionsFrame = Instance.new("Frame")
		ActionsFrame.Size = UDim2.new(1, 0, 0, 30)
		ActionsFrame.BackgroundTransparency = 1
		ActionsFrame.Visible = false
		ActionsFrame.Parent = PlayerListFrame
		
		local function CreateActionButton(text, pos)
			local Btn = Instance.new("TextButton")
			Btn.Size = UDim2.new(0.3, 0, 1, 0)
			Btn.Position = UDim2.new(pos, 0, 0, 0)
			Btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
			Btn.TextColor3 = Color3.fromRGB(255,255,255)
			Btn.Font = Enum.Font.GothamBold
			Btn.TextSize = 12
			Btn.Text = text
			Btn.AutoButtonColor = false
			Btn.Parent = ActionsFrame
			Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
			AddHoverEffect(Btn)
			return Btn
		end
		
		local ViewBtn = CreateActionButton("VIEW", 0)
		local UnviewBtn = CreateActionButton("UNVIEW", 0.35)
		local TeleportBtn = CreateActionButton("TELEPORT", 0.7)
		
		ViewBtn.MouseButton1Click:Connect(function()
			if plr.Character and plr.Character:FindFirstChild("Head") then
				workspace.CurrentCamera.CameraSubject = plr.Character:FindFirstChild("Head")
			end
		end)
		
		UnviewBtn.MouseButton1Click:Connect(function()
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
				workspace.CurrentCamera.CameraSubject = LocalPlayer.Character:FindFirstChild("Humanoid")
			end
		end)
		
		TeleportBtn.MouseButton1Click:Connect(function()
			if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and
			   LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame + Vector3.new(2, 0, 0)
			end
		end)
		
		PlayerButton.MouseButton1Click:Connect(function()
			ActionsFrame.Visible = not ActionsFrame.Visible
		end)
	end
	
	ScanButton.MouseButton1Click:Connect(function()
		for _, child in ipairs(PlayerListFrame:GetChildren()) do
			if child:IsA("TextButton") or child:IsA("Frame") then
				child:Destroy()
			end
		end
		task.spawn(function()
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr ~= LocalPlayer then
					CreatePlayerButton(plr)
					task.wait(0.1)
				end
			end
		end)
	end)
	
	UIS.InputBegan:Connect(function(input, gp)
		if not gp and input.KeyCode == Enum.KeyCode.U then
			MainFrame.Visible = not MainFrame.Visible
		end
	end)
end)

addMainMenuButton("AIM VIEWER (NEXUS)", function()
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local RunService = game:GetService("RunService")
	local Camera = workspace.CurrentCamera
	local AimViewerEnabled = false
	local playerLines = {}
	local lineDistance = 50
	
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Parent = game.CoreGui
	
	local Frame = Instance.new("Frame")
	Frame.Size = UDim2.new(0, 200, 0, 60)
	Frame.Position = UDim2.new(0.4, 0, 0.05, 0)
	Frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
	Frame.BorderSizePixel = 2
	Frame.Active = true
	Frame.Draggable = true
	Frame.Parent = ScreenGui
	
	local Title = Instance.new("TextLabel")
	Title.Size = UDim2.new(1, 0, 0, 25)
	Title.BackgroundColor3 = Color3.fromRGB(20,20,20)
	Title.Text = "NEXUS AIM VIEWER"
	Title.TextColor3 = Color3.fromRGB(255,255,255)
	Title.Font = Enum.Font.SourceSansBold
	Title.TextSize = 16
	Title.Parent = Frame
	
	local ToggleButton = Instance.new("TextButton")
	ToggleButton.Size = UDim2.new(1, 0, 0, 35)
	ToggleButton.Position = UDim2.new(0, 0, 0, 25)
	ToggleButton.BackgroundColor3 = Color3.fromRGB(30,30,30)
	ToggleButton.Text = "Aim Viewer: OFF"
	ToggleButton.TextColor3 = Color3.fromRGB(255,255,255)
	ToggleButton.Font = Enum.Font.SourceSansBold
	ToggleButton.TextSize = 16
	ToggleButton.Parent = Frame
	
	local function createLine()
		local line = Drawing.new("Line")
		line.Thickness = 1.5
		line.Transparency = 1
		line.Color = Color3.fromRGB(255, 255, 255)
		return line
	end
	
	ToggleButton.MouseButton1Click:Connect(function()
		AimViewerEnabled = not AimViewerEnabled
		if AimViewerEnabled then
			ToggleButton.Text = "Aim Viewer: ON"
		else
			ToggleButton.Text = "Aim Viewer: OFF"
			for _, line in pairs(playerLines) do
				line.Visible = false
			end
		end
	end)
	
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

addMainMenuButton("HEAD DETECTOR (NEXUS)", function()
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local UserInputService = game:GetService("UserInputService")
	local FOV_THRESHOLD = 5
	local UPDATE_INTERVAL = 0.2
	local detectionEnabled = true
	
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "AntiHeadshotGUI"
	ScreenGui.Parent = game.CoreGui
	
	local Frame = Instance.new("Frame", ScreenGui)
	Frame.Size = UDim2.new(0, 300, 0, 200)
	Frame.Position = UDim2.new(1, -310, 0, 10)
	Frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
	Frame.BorderSizePixel = 0
	
	local Title = Instance.new("TextLabel", Frame)
	Title.Size = UDim2.new(1, 0, 0, 30)
	Title.BackgroundColor3 = Color3.fromRGB(20,20,20)
	Title.TextColor3 = Color3.fromRGB(255,255,255)
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 16
	Title.Text = "NEXUS Head Detector"
	
	local PlayerList = Instance.new("TextLabel", Frame)
	PlayerList.Size = UDim2.new(1, -10, 1, -40)
	PlayerList.Position = UDim2.new(0, 5, 0, 35)
	PlayerList.BackgroundTransparency = 1
	PlayerList.TextColor3 = Color3.fromRGB(255,255,255)
	PlayerList.Font = Enum.Font.Code
	PlayerList.TextSize = 12
	PlayerList.TextXAlignment = Enum.TextXAlignment.Left
	PlayerList.TextYAlignment = Enum.TextYAlignment.Top
	PlayerList.Text = "No threats detected."
	PlayerList.RichText = true
	
	local WarningLabel = Instance.new("TextLabel", ScreenGui)
	WarningLabel.Size = UDim2.new(1, 0, 0, 30)
	WarningLabel.Position = UDim2.new(0, 0, 0, 10)
	WarningLabel.BackgroundTransparency = 1
	WarningLabel.TextColor3 = Color3.fromRGB(255,0,0)
	WarningLabel.TextStrokeTransparency = 0
	WarningLabel.Font = Enum.Font.GothamBold
	WarningLabel.TextSize = 18
	WarningLabel.Text = ""
	WarningLabel.Visible = false
	
	local ToggleButton = Instance.new("TextButton", Frame)
	ToggleButton.Size = UDim2.new(1, 0, 0, 25)
	ToggleButton.Position = UDim2.new(0, 0, 1, -25)
	ToggleButton.BackgroundColor3 = Color3.fromRGB(30,30,30)
	ToggleButton.TextColor3 = Color3.fromRGB(255,255,255)
	ToggleButton.Font = Enum.Font.GothamBold
	ToggleButton.TextSize = 12
	ToggleButton.Text = "Detection: ON"
	
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
	
	task.spawn(function()
		while true do
			task.wait(UPDATE_INTERVAL)
			if not detectionEnabled then
				PlayerList.Text = "Detection OFF"
				WarningLabel.Visible = false
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
				PlayerList.Text = "Threats:\n" .. table.concat(threats, "\n")
				WarningLabel.Text = "WARNING: " .. table.concat(threats, ", ") .. " aiming at you!"
				WarningLabel.Visible = true
			else
				PlayerList.Text = "No threats detected."
				WarningLabel.Visible = false
			end
		end
	end)
	
	local function toggleDetection()
		detectionEnabled = not detectionEnabled
		ToggleButton.Text = detectionEnabled and "Detection: ON" or "Detection: OFF"
	end
	
	ToggleButton.MouseButton1Click:Connect(toggleDetection)
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if not gameProcessed and input.KeyCode == Enum.KeyCode.G then
			toggleDetection()
		end
	end)
end)

addMainMenuButton("PLAYER LIST TP (NEXUS)", function()
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local UserInputService = game:GetService("UserInputService")
	local LocalPlayer = Players.LocalPlayer
	local Camera = workspace.CurrentCamera
	
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "NEXUS_GUI"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	
	UserInputService.InputBegan:Connect(function(input, isProcessed)
		if not isProcessed and input.KeyCode == Enum.KeyCode.K then
			screenGui.Enabled = not screenGui.Enabled
		end
	end)
	
	local mainFrame = Instance.new("Frame", screenGui)
	mainFrame.Size = UDim2.new(0, 520, 0, 360)
	mainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
	mainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
	mainFrame.Active = true
	mainFrame.Draggable = true
	mainFrame.BorderSizePixel = 0
	
	local titleBar = Instance.new("TextLabel", mainFrame)
	titleBar.Size = UDim2.new(1, 0, 0, 36)
	titleBar.BackgroundColor3 = Color3.fromRGB(30,30,30)
	titleBar.Text = "NEXUS"
	titleBar.Font = Enum.Font.GothamBold
	titleBar.TextSize = 22
	titleBar.TextColor3 = Color3.fromRGB(255,255,255)
	titleBar.BorderSizePixel = 0
	
	local leftWidth = 0.34
	local scroll = Instance.new("ScrollingFrame", mainFrame)
	scroll.Name = "PlayerList"
	scroll.Position = UDim2.new(0, 0, 0, 36)
	scroll.Size = UDim2.new(leftWidth, 0, 1, -36)
	scroll.BackgroundColor3 = Color3.fromRGB(25,25,25)
	scroll.ScrollBarThickness = 6
	scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
	scroll.BorderSizePixel = 0
	
	local listLayout = Instance.new("UIListLayout", scroll)
	listLayout.SortOrder = Enum.SortOrder.LayoutOrder
	listLayout.Padding = UDim.new(0, 4)
	
	local right = Instance.new("Frame", mainFrame)
	right.Position = UDim2.new(leftWidth, 0, 0, 36)
	right.Size = UDim2.new(1 - leftWidth, 0, 1, -36)
	right.BackgroundColor3 = Color3.fromRGB(20,20,20)
	right.BorderSizePixel = 0
	
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
	nameLabel.TextColor3 = Color3.fromRGB(255,255,255)
	nameLabel.Text = "Name: None"
	nameLabel.TextXAlignment = Enum.TextXAlignment.Center
	
	local healthLabel = Instance.new("TextLabel", infoContainer)
	healthLabel.Size = UDim2.new(1, -20, 0, 26)
	healthLabel.Position = UDim2.new(0, 10, 0, 60)
	healthLabel.BackgroundTransparency = 1
	healthLabel.Font = Enum.Font.Gotham
	healthLabel.TextSize = 18
	healthLabel.TextColor3 = Color3.fromRGB(255,255,255)
	healthLabel.Text = "Health: N/A"
	healthLabel.TextXAlignment = Enum.TextXAlignment.Center
	
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
	
	local function createButton(label)
		local b = Instance.new("TextButton")
		b.Size = UDim2.new(0.85, 0, 0.22, 0)
		b.AnchorPoint = Vector2.new(0.5, 0)
		b.BackgroundColor3 = Color3.fromRGB(30,30,30)
		b.Font = Enum.Font.GothamBold
		b.TextSize = 16
		b.Text = label
		b.TextColor3 = Color3.fromRGB(255,255,255)
		b.AutoButtonColor = true
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, 8)
		corner.Parent = b
		b.Parent = buttonContainer
		return b
	end
	
	local viewButton = createButton("View Player")
	local tpButton = createButton("Teleport to Player")
	local bringButton = createButton("Bring Player")
	local friendButton = createButton("Add Friend")
	
	local selectedPlayer = nil
	local isViewing = false
	local isBringing = false
	local originalCameraSubject = Camera.CameraSubject
	local bringConnection
	
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
	
	local function refreshPlayerList()
		for _, c in ipairs(scroll:GetChildren()) do
			if c:IsA("TextButton") then c:Destroy() end
		end
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer then
				local btn = Instance.new("TextButton")
				btn.Size = UDim2.new(1, -8, 0, 28)
				btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
				btn.TextColor3 = Color3.fromRGB(255,255,255)
				btn.Font = Enum.Font.Gotham
				btn.TextSize = 14
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

addMainMenuButton("TPUNANCHORED TO PLAYER (NEXUS)", function()
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local Workspace = game:GetService("Workspace")
	local Debris = game:GetService("Debris")
	
	local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
	ScreenGui.Name = "UnanchoredToolTP"
	ScreenGui.ResetOnSpawn = false
	
	local Frame = Instance.new("Frame", ScreenGui)
	Frame.Size = UDim2.new(0, 300, 0, 230)
	Frame.Position = UDim2.new(0, 20, 0.5, -115)
	Frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
	Frame.BorderSizePixel = 0
	Frame.Active = true
	Frame.Draggable = true
	Instance.new("UICorner", Frame)
	
	local Title = Instance.new("TextLabel", Frame)
	Title.Size = UDim2.new(1, 0, 0, 30)
	Title.Text = "NEXUS UNANCHORED TP"
	Title.TextColor3 = Color3.fromRGB(255,255,255)
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 14
	Title.BackgroundTransparency = 1
	
	local UsernameBox = Instance.new("TextBox", Frame)
	UsernameBox.PlaceholderText = "Enter Player Username"
	UsernameBox.Size = UDim2.new(1, -20, 0, 30)
	UsernameBox.Position = UDim2.new(0, 10, 0, 40)
	UsernameBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
	UsernameBox.TextColor3 = Color3.fromRGB(255,255,255)
	UsernameBox.Font = Enum.Font.Gotham
	UsernameBox.TextSize = 14
	UsernameBox.Text = ""
	Instance.new("UICorner", UsernameBox)
	
	local FilterLabel = Instance.new("TextLabel", Frame)
	FilterLabel.Size = UDim2.new(1, -20, 0, 20)
	FilterLabel.Position = UDim2.new(0, 10, 0, 80)
	FilterLabel.Text = "Tool Filter:"
	FilterLabel.TextColor3 = Color3.fromRGB(255,255,255)
	FilterLabel.Font = Enum.Font.Gotham
	FilterLabel.TextSize = 13
	FilterLabel.BackgroundTransparency = 1
	
	local FilterDropdown = Instance.new("TextButton", Frame)
	FilterDropdown.Size = UDim2.new(1, -20, 0, 30)
	FilterDropdown.Position = UDim2.new(0, 10, 0, 100)
	FilterDropdown.BackgroundColor3 = Color3.fromRGB(30,30,30)
	FilterDropdown.Text = "All Tools"
	FilterDropdown.TextColor3 = Color3.fromRGB(255,255,255)
	FilterDropdown.Font = Enum.Font.Gotham
	FilterDropdown.TextSize = 13
	Instance.new("UICorner", FilterDropdown)
	
	local filterModes = {"All Tools", "Guns Only", "Melee Only"}
	local filterIndex = 1
	
	FilterDropdown.MouseButton1Click:Connect(function()
		filterIndex = filterIndex + 1
		if filterIndex > #filterModes then
			filterIndex = 1
		end
		FilterDropdown.Text = filterModes[filterIndex]
	end)
	
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
	
	local function teleportToolsToPlayer(targetPlayer)
		if not targetPlayer then return end
		local root = targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not root then return end
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
	
	local function grabToolsToBackpack()
		for _, v in ipairs(Workspace:GetDescendants()) do
			if v:IsA("Tool") and v:FindFirstChild("Handle") and not v.Handle.Anchored and isToolAllowed(v) then
				v.Parent = LocalPlayer.Backpack
			end
		end
	end
	
	local TPButton = Instance.new("TextButton", Frame)
	TPButton.Size = UDim2.new(1, -20, 0, 30)
	TPButton.Position = UDim2.new(0, 10, 1, -75)
	TPButton.BackgroundColor3 = Color3.fromRGB(30,30,30)
	TPButton.Text = "Teleport Unanchored To Player"
	TPButton.TextColor3 = Color3.fromRGB(255,255,255)
	TPButton.Font = Enum.Font.GothamBold
	TPButton.TextSize = 13
	Instance.new("UICorner", TPButton)
	
	local GrabButton = Instance.new("TextButton", Frame)
	GrabButton.Size = UDim2.new(1, -20, 0, 30)
	GrabButton.Position = UDim2.new(0, 10, 1, -40)
	GrabButton.BackgroundColor3 = Color3.fromRGB(30,30,30)
	GrabButton.Text = "Grab Tools"
	GrabButton.TextColor3 = Color3.fromRGB(255,255,255)
	GrabButton.Font = Enum.Font.GothamBold
	GrabButton.TextSize = 13
	Instance.new("UICorner", GrabButton)
	
	TPButton.MouseButton1Click:Connect(function()
		local inputName = UsernameBox.Text
		if inputName == "" then return end
		local targetPlayer = Players:FindFirstChild(inputName)
		if not targetPlayer then return end
		teleportToolsToPlayer(targetPlayer)
	end)
	
	GrabButton.MouseButton1Click:Connect(grabToolsToBackpack)
end)

addMainMenuButton("FLING ALL (NEXUS)", function()
	game:GetService("StarterGui"):SetCore("SendNotification",{ Title = "Script Executed", Text = "Fling All", Duration = 3 })
	local Targets = {"All"}
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
					if x.Name:lower():match("^"..Name) then return x
					elseif x.DisplayName:lower():match("^"..Name) then return x end
				end
			end
		end
	end
	
	local SkidFling = function(TargetPlayer)
		local Character = Player.Character
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
		local RootPart = Humanoid and Humanoid.RootPart
		local TCharacter = TargetPlayer.Character
		local THumanoid = TCharacter and TCharacter:FindFirstChildOfClass("Humanoid")
		local TRootPart = THumanoid and THumanoid.RootPart
		local THead = TCharacter and TCharacter:FindFirstChild("Head")
		if Character and Humanoid and RootPart and THumanoid and TRootPart then
			RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
			RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
		end
	end
	
	if Targets[1] then for _,x in next, Targets do GetPlayer(x) end end
	if AllBool then for _,x in next, Players:GetPlayers() do SkidFling(x) end end
	for _,x in next, Targets do
		if GetPlayer(x) and GetPlayer(x) ~= Player then
			local TPlayer = GetPlayer(x)
			if TPlayer then SkidFling(TPlayer) end
		end
	end
end)

addMainMenuButton("HITBOX EXTENDER (NEXUS)", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/LisSploit/HitBoxExtender/main/Universal",true))()
end)

-- ============ SETTINGS TAB ============
local settingsPanel = allTabPanels["SETTINGS"]

local closeBtn = new("TextButton", {
	Parent = settingsPanel,
	Size = UDim2.new(1, 0, 0, 40),
	BackgroundColor3 = Color3.fromRGB(40, 40, 40),
	Text = "CLOSE GUI",
	TextColor3 = Color3.new(255, 255, 255),
	Font = Enum.Font.GothamBold,
	TextSize = 14,
})
new("UICorner", {CornerRadius = UDim.new(0, 4), Parent = closeBtn})
closeBtn.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

-- ============ LUA EXECUTOR TAB ============
local executorPanel = allTabPanels["LUA EXECUTOR"]

local execBtn = new("TextButton", {
	Parent = executorPanel,
	Size = UDim2.new(1, 0, 0, 40),
	Position = UDim2.new(0, 0, 0, 0),
	BackgroundColor3 = Color3.fromRGB(40, 40, 40),
	Text = "EXECUTE",
	TextColor3 = Color3.new(255, 255, 255),
	Font = Enum.Font.GothamBold,
	TextSize = 14,
})
new("UICorner", {CornerRadius = UDim.new(0, 4), Parent = execBtn})

local codeBox = new("TextBox", {
	Parent = executorPanel,
	Size = UDim2.new(1, 0, 1, -50),
	Position = UDim2.new(0, 0, 0, 50),
	BackgroundColor3 = Color3.fromRGB(25, 25, 25),
	Text = "-- Enter Lua script here\nprint('NEXUS Executor Ready!')",
	MultiLine = true,
	TextColor3 = Color3.new(200, 200, 200),
	Font = Enum.Font.Code,
	TextSize = 14,
	ClearTextOnFocus = false,
})
new("UICorner", {CornerRadius = UDim.new(0, 4), Parent = codeBox})

execBtn.MouseButton1Click:Connect(function()
	local success, err = pcall(function()
		loadstring(codeBox.Text)()
	end)
	if not success then warn("Executor Error: " .. err) end
end)

-- ============ PLAYER LIST TAB ============
local playerListPanel = allTabPanels["PLAYER LIST"]

local function refreshPlayers()
	for _, child in ipairs(playerListPanel:GetChildren()) do
		if child:IsA("Frame") then child:Destroy() end
	end
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= player then
			local row = new("Frame", {
				Parent = playerListPanel,
				Size = UDim2.new(1, -16, 0, 40),
				BackgroundColor3 = Color3.fromRGB(25, 25, 25),
				BorderSizePixel = 0,
			})
			new("UICorner", {CornerRadius = UDim.new(0,6), Parent = row})
			
			local nameLabel = new("TextLabel", {
				Parent = row,
				Size = UDim2.new(0.6, 0, 1, 0),
				Position = UDim2.new(0, 8, 0, 0),
				BackgroundTransparency = 1,
				Text = plr.DisplayName .. " (@" .. plr.Name .. ")",
				TextColor3 = Color3.new(255,255,255),
				Font = Enum.Font.Gotham,
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left,
			})
			
			local buttonContainer = new("Frame", {
				Parent = row,
				Size = UDim2.new(0.4, 0, 1, 0),
				Position = UDim2.new(0.6, 0, 0, 0),
				BackgroundTransparency = 1,
			})
			new("UIListLayout", {
				Parent = buttonContainer,
				FillDirection = Enum.FillDirection.Horizontal,
				Padding = UDim.new(0, 4),
				HorizontalAlignment = Enum.HorizontalAlignment.Right,
			})
			
			local function makeMiniBtn(text, callback)
				local b = new("TextButton", {
					Parent = buttonContainer,
					Size = UDim2.new(0, 60, 0, 28),
					BackgroundColor3 = Color3.fromRGB(35, 35, 35),
					Text = text,
					TextColor3 = Color3.new(255,255,255),
					Font = Enum.Font.GothamSemibold,
					TextSize = 10,
				})
				new("UICorner", {CornerRadius = UDim.new(0,4), Parent = b})
				b.MouseButton1Click:Connect(function()
					if callback then callback(plr) end
				end)
			end
			
			makeMiniBtn("VIEW", function(p) 
				if p.Character and p.Character:FindFirstChildOfClass("Humanoid") then
					pcall(function() workspace.CurrentCamera.CameraSubject = p.Character end)
				end
			end)
			makeMiniBtn("UNVIEW", function() 
				pcall(function() workspace.CurrentCamera.CameraSubject = player.Character end)
			end)
			makeMiniBtn("BRING", function(p)
				if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and player.Character then
					p.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
				end
			end)
			makeMiniBtn("UNBRING", function() end)
			makeMiniBtn("TP", function(p)
				if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and player.Character then
					player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
				end
			end)
		end
	end
end

refreshPlayers()
Players.PlayerAdded:Connect(refreshPlayers)
Players.PlayerRemoving:Connect(refreshPlayers)

-- ============ TOGGLE KEY (RIGHT SHIFT) ============
UserInputService.InputBegan:Connect(function(i, gp)
	if gp then return end
	if i.KeyCode == Enum.KeyCode.RightShift then
		screenGui.Enabled = not screenGui.Enabled
	end
end)

print("NEXUS MENU LOADED - COMPLETE")