local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
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

local screenGui = new("ScreenGui", {
	Name = "NXS_GUI",
	ResetOnSpawn = false,
	Parent = playerGui,
	DisplayOrder = 1000,
})

-- ============ FALLING WHITE DOTS ============
local particleContainer = new("Frame", {
	Parent = screenGui,
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundTransparency = 1,
	Active = false,
})

local dots = {}
local DOT_COUNT = 50

for i = 1, DOT_COUNT do
	local dot = new("Frame", {
		Parent = particleContainer,
		Size = UDim2.new(0, math.random(2, 5), 0, math.random(2, 5)),
		Position = UDim2.new(math.random(), 0, math.random(), 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		BackgroundTransparency = 0.3,
	})
	new("UICorner", {CornerRadius = UDim.new(1, 0), Parent = dot})
	
	local speed = math.random(20, 60)
	local startX = dot.Position.X.Scale
	table.insert(dots, {dot, speed, startX})
end

task.spawn(function()
	while true do
		task.wait(0.05)
		for _, data in ipairs(dots) do
			local dot, speed, startX = data[1], data[2], data[3]
			local newY = dot.Position.Y.Scale + (speed / 10000)
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

local main = new("Frame", {
	Name = "MainFrame",
	Size = UDim2.new(0, 550, 0, 400),
	Position = UDim2.new(0.5, -275, 0.5, -200),
	BackgroundColor3 = Color3.fromRGB(15, 15, 15),
	BorderSizePixel = 0,
	Parent = screenGui,
})
main.ClipsDescendants = true
new("UICorner", {CornerRadius = UDim.new(0, 12), Parent = main})

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

-- Left Panel
local leftPanel = new("Frame", {
	Name = "LeftPanel",
	Size = UDim2.new(0, 150, 1, 0),
	BackgroundColor3 = Color3.fromRGB(20, 20, 20),
	BorderSizePixel = 0,
	Parent = main,
})
new("UICorner", {CornerRadius = UDim.new(0, 12), Parent = leftPanel})

local divider = new("Frame", {
	Parent = leftPanel,
	Size = UDim2.new(0, 1, 1, -24),
	Position = UDim2.new(1, -1, 0, 12),
	BackgroundColor3 = Color3.fromRGB(40, 40, 40),
	BorderSizePixel = 0,
})

new("TextLabel", {
	Parent = leftPanel,
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 10, 0, 14),
	Size = UDim2.new(1, -20, 0, 28),
	Text = "NXS MENU V2",
	Font = Enum.Font.GothamBlack,
	TextSize = 18,
	TextColor3 = Color3.new(255, 255, 255),
	TextXAlignment = Enum.TextXAlignment.Left,
})

local avatarFrame = new("Frame", {
	Parent = leftPanel,
	BackgroundColor3 = Color3.fromRGB(30, 30, 30),
	Size = UDim2.new(0, 65, 0, 65),
	Position = UDim2.new(0.5, -32.5, 0, 50),
	BorderSizePixel = 0,
	ClipsDescendants = true,
})

local ring = new("Frame", {
	Parent = avatarFrame,
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundColor3 = Color3.fromRGB(80, 80, 80),
	BorderSizePixel = 0,
})
new("UICorner", {CornerRadius = UDim.new(1, 0), Parent = ring})

local inner = new("Frame", {
	Parent = ring,
	Size = UDim2.new(0.86, 0, 0.86, 0),
	Position = UDim2.new(0.07, 0, 0.07, 0),
	BackgroundColor3 = Color3.fromRGB(15, 15, 15),
	BorderSizePixel = 0,
})
new("UICorner", {CornerRadius = UDim.new(1, 0), Parent = inner})

local avatar = new("ImageLabel", {
	Parent = inner,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 1, 0),
	Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150),
})
new("UICorner", {CornerRadius = UDim.new(1, 0), Parent = avatar})

new("TextLabel", {
	Parent = leftPanel,
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 0, 0, 125),
	Size = UDim2.new(1, 0, 0, 20),
	Text = player.DisplayName,
	Font = Enum.Font.GothamBold,
	TextSize = 13,
	TextColor3 = Color3.new(255, 255, 255),
	TextXAlignment = Enum.TextXAlignment.Center,
})

new("TextLabel", {
	Parent = leftPanel,
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 0, 0, 145),
	Size = UDim2.new(1, 0, 0, 16),
	Text = "@" .. player.Name,
	Font = Enum.Font.Gotham,
	TextSize = 10,
	TextColor3 = Color3.fromRGB(150, 150, 150),
	TextXAlignment = Enum.TextXAlignment.Center,
})

local socialLine = new("Frame", {
	Parent = leftPanel,
	Size = UDim2.new(0.8, 0, 0, 1),
	Position = UDim2.new(0.1, 0, 0, 180),
	BackgroundColor3 = Color3.fromRGB(40, 40, 40),
	BorderSizePixel = 0,
})

new("TextLabel", {
	Parent = leftPanel,
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 0, 0, 195),
	Size = UDim2.new(1, 0, 0, 80),
	Text = "NXS\n\nDiscord: nxs\n\nTiktok: nxs",
	Font = Enum.Font.Gotham,
	TextSize = 10,
	TextColor3 = Color3.fromRGB(150, 150, 150),
	TextXAlignment = Enum.TextXAlignment.Center,
	TextYAlignment = Enum.TextYAlignment.Top,
	TextWrapped = true,
})

local rightPanel = new("Frame", {
	Name = "RightPanel",
	Parent = main,
	Size = UDim2.new(1, -150, 1, -45),
	Position = UDim2.new(0, 150, 0, 0),
	BackgroundColor3 = Color3.fromRGB(15, 15, 15),
	BorderSizePixel = 0,
})
new("UICorner", {CornerRadius = UDim.new(0, 12), Parent = rightPanel})

local titleLabel = new("TextLabel", {
	Parent = rightPanel,
	Position = UDim2.new(0, 12, 0, 8),
	Size = UDim2.new(1, -24, 0, 25),
	BackgroundTransparency = 1,
	Text = "MAIN MENU",
	Font = Enum.Font.GothamBold,
	TextSize = 16,
	TextColor3 = Color3.new(255, 255, 255),
	TextXAlignment = Enum.TextXAlignment.Left,
})

local tabBar = new("ScrollingFrame", {
	Parent = rightPanel,
	Position = UDim2.new(0, 12, 0, 38),
	Size = UDim2.new(1, -24, 0, 34),
	BackgroundColor3 = Color3.fromRGB(22, 22, 22),
	BorderSizePixel = 0,
	ScrollBarThickness = 4,
	ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80),
	CanvasSize = UDim2.new(0, 0, 0, 0),
	ScrollingDirection = Enum.ScrollingDirection.X,
	AutomaticCanvasSize = Enum.AutomaticSize.X,
})
new("UICorner", {CornerRadius = UDim.new(0, 6), Parent = tabBar})

local tabLayout = new("UIListLayout", {
	Parent = tabBar,
	FillDirection = Enum.FillDirection.Horizontal,
	Padding = UDim.new(0, 6),
	SortOrder = Enum.SortOrder.LayoutOrder,
})

local contentArea = new("Frame", {
	Parent = rightPanel,
	Position = UDim2.new(0, 12, 0, 78),
	Size = UDim2.new(1, -24, 1, -120),
	BackgroundTransparency = 1,
	ClipsDescendants = true,
})

local bottomBar = new("Frame", {
	Parent = main,
	Position = UDim2.new(0, 150, 1, -40),
	Size = UDim2.new(1, -150, 0, 40),
	BackgroundColor3 = Color3.fromRGB(20, 20, 20),
	BorderSizePixel = 0,
})
new("UICorner", {CornerRadius = UDim.new(0, 12), Parent = bottomBar})

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
end

local topTabNames = {
	"MAIN MENU", "ROLEPLAY", "BRING", "AIMBOT",
	"SCRIPT", "CASH", "PLAYER", "NXS MENU",
	"BILLIONARE", "RP TP", "ADMIN", "REMOTES"
}

local function createTopTab(name)
	local btn = new("TextButton", {
		Parent = tabBar,
		Size = UDim2.new(0, 85, 1, -8),
		BackgroundColor3 = Color3.fromRGB(28, 28, 28),
		Text = name,
		Font = Enum.Font.GothamSemibold,
		TextSize = 11,
		TextColor3 = Color3.new(255, 255, 255),
		AutoButtonColor = false,
		TextXAlignment = Enum.TextXAlignment.Center,
	})
	new("UICorner", {CornerRadius = UDim.new(0, 4), Parent = btn})

	btn.MouseEnter:Connect(function()
		if currentTab ~= name then
			TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
		end
	end)
	btn.MouseLeave:Connect(function()
		if currentTab ~= name then
			TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(28, 28, 28)}):Play()
		end
	end)

	btn.MouseButton1Click:Connect(function()
		clickSound:Play()
		showTab(name)
	end)

	local panel = new("ScrollingFrame", {
		Parent = contentArea,
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Visible = false,
		ScrollBarThickness = 4,
		ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
	})
	new("UIListLayout", {Parent = panel, Padding = UDim.new(0, 6)})

	allTabPanels[name] = panel
	table.insert(allTabButtons, btn)
	return panel
end

for _, name in ipairs(topTabNames) do
	createTopTab(name)
end

local bottomTabs = {"PLAYER LIST", "SETTINGS", "LUA EXECUTOR"}

local function createBottomTab(name)
	local btn = new("TextButton", {
		Parent = bottomBar,
		Size = UDim2.new(0, 95, 1, -10),
		BackgroundColor3 = Color3.fromRGB(28, 28, 28),
		Text = name,
		Font = Enum.Font.GothamSemibold,
		TextSize = 12,
		TextColor3 = Color3.new(255, 255, 255),
		AutoButtonColor = false,
	})
	new("UICorner", {CornerRadius = UDim.new(0, 4), Parent = btn})

	local function positionButton()
		local totalWidth = #bottomTabs * 95 + (#bottomTabs-1) * 10
		local startX = (bottomBar.AbsoluteSize.X - totalWidth) / 2
		btn.Position = UDim2.new(0, startX + (table.find(bottomTabs, name)-1)*(95+10), 0, 5)
	end
	task.delay(0, positionButton)
	bottomBar:GetPropertyChangedSignal("AbsoluteSize"):Connect(positionButton)

	btn.MouseButton1Click:Connect(function()
		clickSound:Play()
		showTab(name)
	end)

	local panel = new("ScrollingFrame", {
		Parent = contentArea,
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Visible = false,
		ScrollBarThickness = 4,
		ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
	})
	new("UIListLayout", {Parent = panel, Padding = UDim.new(0, 6)})

	allTabPanels[name] = panel
	table.insert(allTabButtons, btn)
	return panel
end

for _, name in ipairs(bottomTabs) do
	createBottomTab(name)
end

if allTabButtons[1] then
	allTabButtons[1].BackgroundColor3 = Color3.fromRGB(55, 55, 55)
end
showTab("MAIN MENU")

-- BUTTON CREATOR FUNCTION
local function addMainMenuButton(text, callback)
	local panel = allTabPanels["MAIN MENU"]
	if not panel then return end
	local btn = new("TextButton", {
		Size = UDim2.new(1, -12, 0, 34),
		BackgroundColor3 = Color3.fromRGB(28, 28, 28),
		TextColor3 = Color3.new(255, 255, 255),
		Font = Enum.Font.GothamSemibold,
		TextSize = 13,
		Text = text,
		AutoButtonColor = false,
		Parent = panel,
	})
	new("UICorner", {CornerRadius = UDim.new(0, 4), Parent = btn})
	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(28, 28, 28)}):Play()
	end)
	btn.MouseButton1Click:Connect(function()
		clickSound:Play()
		callback()
	end)
end

-- ============ MAIN MENU BUTTONS ============
addMainMenuButton("INFINITE YIELD (NXS)", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

addMainMenuButton("ESP PLAYER (NXS)", function()
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local Camera = workspace.CurrentCamera
	local LocalPlayer = Players.LocalPlayer
	
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
		if not ESP_ENABLED then return end
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
end)

addMainMenuButton("BIG HEAD PLAYER (NXS)", function()
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
					end) 
				end 
			end 
		end 
	end)
end)

addMainMenuButton("PRESS Q TO FREECAM (NXS)", function()
	local Players = game:GetService("Players")
	local UserInputService = game:GetService("UserInputService")
	local RunService = game:GetService("RunService")
	local player = Players.LocalPlayer
	local cam = workspace.CurrentCamera
	local enabled = false
	local yaw = 0
	local pitch = 0
	local moveDir = Vector3.new()
	
	local function toggleFreecam()
		enabled = not enabled
		if enabled then
			cam.CameraType = Enum.CameraType.Scriptable
			UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
			UserInputService.MouseIconEnabled = false
		else
			cam.CameraType = Enum.CameraType.Custom
			UserInputService.MouseBehavior = Enum.MouseBehavior.Default
			UserInputService.MouseIconEnabled = true
		end
	end
	
	UserInputService.InputBegan:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.Q then
			toggleFreecam()
		end
		if enabled and input.UserInputType == Enum.UserInputType.Keyboard then
			if input.KeyCode == Enum.KeyCode.W then moveDir += Vector3.new(0,0,1) end
			if input.KeyCode == Enum.KeyCode.S then moveDir += Vector3.new(0,0,-1) end
			if input.KeyCode == Enum.KeyCode.A then moveDir += Vector3.new(-1,0,0) end
			if input.KeyCode == Enum.KeyCode.D then moveDir += Vector3.new(1,0,0) end
		end
	end)
	
	UserInputService.InputEnded:Connect(function(input)
		if enabled and input.UserInputType == Enum.UserInputType.Keyboard then
			if input.KeyCode == Enum.KeyCode.W then moveDir -= Vector3.new(0,0,1) end
			if input.KeyCode == Enum.KeyCode.S then moveDir -= Vector3.new(0,0,-1) end
			if input.KeyCode == Enum.KeyCode.A then moveDir -= Vector3.new(-1,0,0) end
			if input.KeyCode == Enum.KeyCode.D then moveDir -= Vector3.new(1,0,0) end
		end
	end)
	
	RunService.RenderStepped:Connect(function(dt)
		if not enabled then return end
		local speed = 50
		local newPos = cam.CFrame.Position + (cam.CFrame.RightVector * moveDir.X + cam.CFrame.UpVector * moveDir.Y + cam.CFrame.LookVector * moveDir.Z) * speed * dt
		cam.CFrame = CFrame.new(newPos, newPos + cam.CFrame.LookVector)
	end)
end)

addMainMenuButton("FADED GUI UNIVERSAL (NXS)", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/NighterEpic/Faded-Grid/main/YesEpic", true))()
end)

addMainMenuButton("LOOP BRING ALL (NXS)", function()
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local LocalPlayer = Players.LocalPlayer
	local loopEnabled = false
	
	local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
	local Frame = Instance.new("Frame", ScreenGui)
	Frame.Size = UDim2.new(0, 250, 0, 80)
	Frame.Position = UDim2.new(0.5, -125, 0, 50)
	Frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
	Frame.BorderSizePixel = 0
	Frame.Active = true
	Frame.Draggable = true
	Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)
	
	local Title = Instance.new("TextLabel", Frame)
	Title.Size = UDim2.new(1, 0, 0.4, 0)
	Title.BackgroundTransparency = 1
	Title.Font = Enum.Font.SourceSansBold
	Title.TextSize = 16
	Title.Text = "NXS LOOP BRING ALL"
	Title.TextColor3 = Color3.fromRGB(255,255,255)
	
	local StatusButton = Instance.new("TextButton", Frame)
	StatusButton.Size = UDim2.new(1, 0, 0.6, 0)
	StatusButton.Position = UDim2.new(0, 0, 0.4, 0)
	StatusButton.Font = Enum.Font.SourceSansBold
	StatusButton.TextSize = 18
	StatusButton.Text = "OFF"
	StatusButton.BackgroundColor3 = Color3.fromRGB(30,30,30)
	StatusButton.TextColor3 = Color3.fromRGB(255,255,255)
	
	StatusButton.MouseButton1Click:Connect(function()
		loopEnabled = not loopEnabled
		StatusButton.Text = loopEnabled and "ON" or "OFF"
	end)
	
	RunService.RenderStepped:Connect(function()
		if loopEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = LocalPlayer.Character.HumanoidRootPart
			local targetPos = hrp.Position + (hrp.CFrame.LookVector * 5)
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
					plr.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos)
				end
			end
		end
	end)
end)

addMainMenuButton("HITBOX EXTENDER (NXS)", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/LisSploit/HitBoxExtender/main/Universal",true))()
end)

addMainMenuButton("FLING ALL (NXS)", function()
	local Players = game:GetService("Players")
	local Player = Players.LocalPlayer
	
	for _, target in pairs(Players:GetPlayers()) do
		if target ~= Player and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = target.Character.HumanoidRootPart
			hrp.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
			hrp.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
		end
	end
end)

addMainMenuButton("GIVE ALL CASH 10M (NXS)", function()
	for _, player in ipairs(Players:GetPlayers()) do
		local stats = player:FindFirstChild("leaderstats")
		if stats then
			local cash = stats:FindFirstChild("Cash")
			if cash then
				cash.Value = cash.Value + 10000000
			end
		end
	end
end)

addMainMenuButton("UNIVERSAL NO FALL DAMAGE (NXS)", function()
	local LocalPlayer = Players.LocalPlayer
	local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	local Humanoid = Character:WaitForChild("Humanoid")
	Humanoid.MaxHealth = math.huge
	Humanoid.Health = math.huge
	RunService.Heartbeat:Connect(function()
		if Humanoid.Health < math.huge then
			Humanoid.Health = math.huge
		end
	end)
end)

-- PLAYER LIST TAB
local playerListPanel = allTabPanels["PLAYER LIST"]

local function refreshPlayers()
	for _, child in ipairs(playerListPanel:GetChildren()) do
		if child:IsA("Frame") then child:Destroy() end
	end
	
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= player then
			local row = new("Frame", {
				Parent = playerListPanel,
				Size = UDim2.new(1, -12, 0, 38),
				BackgroundColor3 = Color3.fromRGB(25, 25, 25),
				BorderSizePixel = 0,
			})
			new("UICorner", {CornerRadius = UDim.new(0, 4), Parent = row})
			
			local nameLabel = new("TextLabel", {
				Parent = row,
				Size = UDim2.new(0.5, 0, 1, 0),
				Position = UDim2.new(0, 8, 0, 0),
				BackgroundTransparency = 1,
				Text = plr.Name,
				TextColor3 = Color3.new(255, 255, 255),
				Font = Enum.Font.Gotham,
				TextSize = 12,
				TextXAlignment = Enum.TextXAlignment.Left,
			})
			
			local buttonContainer = new("Frame", {
				Parent = row,
				Size = UDim2.new(0.5, 0, 1, 0),
				Position = UDim2.new(0.5, 0, 0, 0),
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
					Size = UDim2.new(0, 55, 0, 26),
					BackgroundColor3 = Color3.fromRGB(35, 35, 35),
					Text = text,
					TextColor3 = Color3.new(255, 255, 255),
					Font = Enum.Font.GothamSemibold,
					TextSize = 10,
				})
				new("UICorner", {CornerRadius = UDim.new(0, 4), Parent = b})
				b.MouseButton1Click:Connect(function()
					if callback then callback(plr) end
				end)
			end
			
			makeMiniBtn("VIEW", function(p) 
				if p.Character then
					pcall(function() workspace.CurrentCamera.CameraSubject = p.Character end)
				end
			end)
			makeMiniBtn("TP", function(p)
				if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and player.Character then
					player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
				end
			end)
			makeMiniBtn("BRING", function(p)
				if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and player.Character then
					p.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
				end
			end)
		end
	end
end

refreshPlayers()
Players.PlayerAdded:Connect(refreshPlayers)
Players.PlayerRemoving:Connect(refreshPlayers)

-- LUA EXECUTOR TAB
local executorPanel = allTabPanels["LUA EXECUTOR"]

local execBtn = new("TextButton", {
	Parent = executorPanel,
	Size = UDim2.new(1, 0, 0, 36),
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
	Size = UDim2.new(1, 0, 1, -46),
	Position = UDim2.new(0, 0, 0, 46),
	BackgroundColor3 = Color3.fromRGB(25, 25, 25),
	Text = "-- Enter Lua script here\nprint('NXS Executor Ready!')",
	MultiLine = true,
	TextColor3 = Color3.new(200, 200, 200),
	Font = Enum.Font.Code,
	TextSize = 12,
	ClearTextOnFocus = false,
})
new("UICorner", {CornerRadius = UDim.new(0, 4), Parent = codeBox})

execBtn.MouseButton1Click:Connect(function()
	local success, err = pcall(function()
		loadstring(codeBox.Text)()
	end)
	if not success then
		warn("Executor Error: " .. err)
	end
end)

-- SETTINGS TAB
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

-- TOGGLE GUI WITH RIGHT SHIFT
UserInputService.InputBegan:Connect(function(i, gp)
	if gp then return end
	if i.KeyCode == Enum.KeyCode.RightShift then
		screenGui.Enabled = not screenGui.Enabled
	end
end)

print("NXS MENU LOADED - FALLING WHITE DOTS ACTIVE")
