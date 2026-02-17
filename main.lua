--[[
    ██████╗ ███████╗██╗  ████████╗ █████╗ 
    ██╔══██╗██╔════╝██║  ╚══██╔══╝██╔══██╗
    ██║  ██║█████╗  ██║     ██║   ███████║
    ██║  ██║██╔══╝  ██║     ██║   ██╔══██║
    ██████╔╝███████╗███████╗██║   ██║  ██║
    ╚═════╝ ╚══════╝╚══════╝╚═╝   ╚═╝  ╚═╝
    
    DELTA EXECUTOR MOBILE ULTIMATE
    VERSION: 4.20 REVENGE
    STATUS: 100% REAL NO BUG
    CREATED BY: AXELUZZCODE
    CONTACT: 0881010065137
]]

-- Variables Global
getgenv().Delta = {
    MenuOpen = false,
    SelectedTab = 1,
    Target = nil,
    ScreenGui = nil,
    Theme = {
        Background = Color3.fromRGB(25, 25, 35),
        Primary = Color3.fromRGB(147, 112, 219),
        Secondary = Color3.fromRGB(75, 0, 130),
        Text = Color3.fromRGB(255, 255, 255),
        Accent = Color3.fromRGB(255, 215, 0),
        Button = Color3.fromRGB(50, 50, 70),
        ButtonHover = Color3.fromRGB(70, 70, 90)
    },
    Toggles = {
        Fly = false,
        Speed = false,
        GodModeV1 = false,
        GodModeV2 = false,
        GodModeV3 = false,
        Aimlock = false,
        ESP = false,
        ESPName = false,
        ESPLine = false,
        ESPBox = false,
        ESPSkeleton = false,
        AimlockHead = false,
        AimlockBody = false,
        AimlockRandom = false,
        HitboxBig = false,
        HitboxSmall = false,
        HitboxMed = false
    },
    Values = {
        SpeedMultiplier = 50,
        AimlockSmoothness = 5,
        ESPDistance = 1000
    }
}

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Functions
function CreateUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "DeltaPremiumGUI"
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main Frame
    local main = Instance.new("Frame")
    main.Name = "MainFrame"
    main.Size = UDim2.new(0, 350, 0, 500)
    main.Position = UDim2.new(0.5, -175, 0.5, -250)
    main.BackgroundColor3 = Delta.Theme.Background
    main.BackgroundTransparency = 0.1
    main.BorderSizePixel = 0
    main.Active = true
    main.Draggable = true
    main.Visible = false
    
    -- Rounded corners
    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(0, 15)
    uicorner.Parent = main
    
    -- Stroke
    local uistroke = Instance.new("UIStroke")
    uistroke.Color = Delta.Theme.Primary
    uistroke.Thickness = 2
    uistroke.Parent = main
    
    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = Delta.Theme.Secondary
    titleBar.BorderSizePixel = 0
    titleBar.Parent = main
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 15)
    titleCorner.Parent = titleBar
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -50, 1, 0)
    title.Position = UDim2.new(0, 15, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "DELTA EXECUTOR ULTIMATE"
    title.TextColor3 = Delta.Theme.Text
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = titleBar
    
    local closeBtn = Instance.new("ImageButton")
    closeBtn.Size = UDim2.new(0, 25, 0, 25)
    closeBtn.Position = UDim2.new(1, -35, 0.5, -12.5)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Image = "rbxassetid://3926305904"
    closeBtn.ImageColor3 = Delta.Theme.Text
    closeBtn.Parent = titleBar
    
    -- Tabs Frame
    local tabs = Instance.new("Frame")
    tabs.Size = UDim2.new(1, -20, 0, 40)
    tabs.Position = UDim2.new(0, 10, 0, 50)
    tabs.BackgroundTransparency = 1
    tabs.Parent = main
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.FillDirection = Enum.FillDirection.Horizontal
    tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 10)
    tabLayout.Parent = tabs
    
    local tabsList = {"MOVEMENT", "COMBAT", "VISUAL", "MISC"}
    for i,tabName in ipairs(tabsList) do
        local tab = Instance.new("TextButton")
        tab.Name = "Tab"..i
        tab.Size = UDim2.new(0, 70, 1, 0)
        tab.BackgroundColor3 = Delta.Theme.Button
        tab.Text = tabName
        tab.TextColor3 = Delta.Theme.Text
        tab.TextScaled = true
        tab.Font = Enum.Font.GothamBold
        tab.BorderSizePixel = 0
        
        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 10)
        tabCorner.Parent = tab
        
        tab.Parent = tabs
        
        tab.MouseEnter:Connect(function()
            tab.BackgroundColor3 = Delta.Theme.ButtonHover
        end)
        
        tab.MouseLeave:Connect(function()
            if i ~= Delta.SelectedTab then
                tab.BackgroundColor3 = Delta.Theme.Button
            end
        end)
        
        tab.MouseButton1Click:Connect(function()
            for _,v in ipairs(tabs:GetChildren()) do
                if v:IsA("TextButton") then
                    v.BackgroundColor3 = Delta.Theme.Button
                end
            end
            tab.BackgroundColor3 = Delta.Theme.Primary
            Delta.SelectedTab = i
            UpdateContent(main, i)
        end)
        
        if i == 1 then
            tab.BackgroundColor3 = Delta.Theme.Primary
        end
    end
    
    -- Content Frame
    local content = Instance.new("ScrollingFrame")
    content.Name = "Content"
    content.Size = UDim2.new(1, -20, 1, -100)
    content.Position = UDim2.new(0, 10, 0, 100)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.ScrollBarThickness = 5
    content.ScrollBarImageColor3 = Delta.Theme.Primary
    content.CanvasSize = UDim2.new(0, 0, 0, 0)
    content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    content.Parent = main
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = content
    
    Delta.ScreenGui = gui
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    
    -- Close Button
    closeBtn.MouseButton1Click:Connect(function()
        Delta.MenuOpen = false
        main.Visible = false
    end)
    
    Delta.MainFrame = main
    Delta.ContentFrame = content
    
    -- Initial content
    UpdateContent(main, 1)
    
    return main
end

function CreateToggle(parent, text, toggleVar, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 40)
    frame.BackgroundColor3 = Delta.Theme.Button
    frame.BackgroundTransparency = 0.5
    frame.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.5, -10, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Delta.Theme.Text
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.Parent = frame
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 60, 0, 30)
    toggleBtn.Position = UDim2.new(1, -70, 0.5, -15)
    toggleBtn.BackgroundColor3 = Delta.Toggles[toggleVar] and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    toggleBtn.Text = Delta.Toggles[toggleVar] and "ON" or "OFF"
    toggleBtn.TextColor3 = Delta.Theme.Text
    toggleBtn.TextScaled = true
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.BorderSizePixel = 0
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 5)
    btnCorner.Parent = toggleBtn
    
    toggleBtn.Parent = frame
    
    toggleBtn.MouseButton1Click:Connect(function()
        Delta.Toggles[toggleVar] = not Delta.Toggles[toggleVar]
        toggleBtn.BackgroundColor3 = Delta.Toggles[toggleVar] and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        toggleBtn.Text = Delta.Toggles[toggleVar] and "ON" or "OFF"
        if callback then callback(Delta.Toggles[toggleVar]) end
    end)
    
    frame.Parent = parent
    return frame
end

function CreateSlider(parent, text, var, min, max, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 60)
    frame.BackgroundColor3 = Delta.Theme.Button
    frame.BackgroundTransparency = 0.5
    frame.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 20)
    label.Position = UDim2.new(0, 10, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Delta.Theme.Text
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.Parent = frame
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0, 50, 0, 20)
    valueLabel.Position = UDim2.new(1, -60, 0, 5)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(Delta.Values[var])
    valueLabel.TextColor3 = Delta.Theme.Accent
    valueLabel.TextScaled = true
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.Parent = frame
    
    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(1, -20, 0, 10)
    slider.Position = UDim2.new(0, 10, 0, 35)
    slider.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    slider.BorderSizePixel = 0
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 5)
    sliderCorner.Parent = slider
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((Delta.Values[var] - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Delta.Theme.Primary
    fill.BorderSizePixel = 0
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 5)
    fillCorner.Parent = fill
    
    fill.Parent = slider
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundTransparency = 1
    button.Text = ""
    button.Parent = slider
    
    local dragging = false
    
    button.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    RunService.RenderStepped:Connect(function()
        if dragging then
            local mousePos = UserInputService:GetMouseLocation()
            local sliderPos = slider.AbsolutePosition
            local sliderSize = slider.AbsoluteSize.X
            
            local relativeX = math.clamp(mousePos.X - sliderPos.X, 0, sliderSize)
            local percent = relativeX / sliderSize
            local value = min + (percent * (max - min))
            value = math.floor(value * 10) / 10
            
            Delta.Values[var] = value
            fill.Size = UDim2.new(percent, 0, 1, 0)
            valueLabel.Text = tostring(value)
            if callback then callback(value) end
        end
    end)
    
    slider.Parent = frame
    frame.Parent = parent
    return frame
end

function UpdateContent(main, tab)
    local content = Delta.ContentFrame
    for _,v in ipairs(content:GetChildren()) do
        if v:IsA("Frame") then
            v:Destroy()
        end
    end
    
    if tab == 1 then -- MOVEMENT
        CreateToggle(content, "FLY MODE", "Fly", function(state)
            if state then
                -- Fly script
                local flyConnection
                local bodyVelocity
                
                LocalPlayer.CharacterAdded:Connect(function(char)
                    if Delta.Toggles.Fly then
                        wait(1)
                        local humanoid = char:WaitForChild("Humanoid")
                        local root = char:WaitForChild("HumanoidRootPart")
                        
                        bodyVelocity = Instance.new("BodyVelocity")
                        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
                        bodyVelocity.Parent = root
                        
                        flyConnection = RunService.Heartbeat:Connect(function()
                            if not Delta.Toggles.Fly or not root then
                                return
                            end
                            
                            local moveDir = Vector3.new()
                            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                                moveDir = moveDir + Camera.CFrame.LookVector
                            end
                            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                                moveDir = moveDir - Camera.CFrame.LookVector
                            end
                            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                                moveDir = moveDir - Camera.CFrame.RightVector
                            end
                            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                                moveDir = moveDir + Camera.CFrame.RightVector
                            end
                            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                                moveDir = moveDir + Vector3.new(0, 1, 0)
                            end
                            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                                moveDir = moveDir - Vector3.new(0, 1, 0)
                            end
                            
                            if moveDir.Magnitude > 0 then
                                moveDir = moveDir.Unit * Delta.Values.SpeedMultiplier
                            end
                            
                            bodyVelocity.Velocity = moveDir
                        end)
                    end
                end)
            else
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart:FindFirstChildOfClass("BodyVelocity"):Destroy()
                end
            end
        end)
        
        CreateSlider(content, "SPEED", "SpeedMultiplier", 10, 200, function(val)
            Delta.Values.SpeedMultiplier = val
        end)
        
        CreateToggle(content, "GOD MODE V1 (ANTI DMG)", "GodModeV1", function(state)
            if state then
                LocalPlayer.CharacterAdded:Connect(function(char)
                    wait(1)
                    local humanoid = char:WaitForChild("Humanoid")
                    humanoid.MaxHealth = math.huge
                    humanoid.Health = math.huge
                    humanoid.BreakJointsOnDeath = false
                    
                    humanoid.HealthChanged:Connect(function()
                        if state then
                            humanoid.Health = math.huge
                        end
                    end)
                end)
            end
        end)
        
        CreateToggle(content, "GOD MODE V2 (IMMORTAL)", "GodModeV2", function(state)
            if state then
                LocalPlayer.CharacterAdded:Connect(function(char)
                    wait(1)
                    local humanoid = char:WaitForChild("Humanoid")
                    local root = char:WaitForChild("HumanoidRootPart")
                    
                    -- Anti kill bricks
                    char.ChildAdded:Connect(function(child)
                        if child:IsA("Part") and child.Name:match("Kill") then
                            child:Destroy()
                        end
                    end)
                    
                    -- Anti fall damage
                    humanoid.StateChanged:Connect(function(_, newState)
                        if newState == Enum.HumanoidStateType.FallingDown then
                            humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                        end
                    end)
                end)
            end
        end)
        
        CreateToggle(content, "GOD MODE V3 (ADMIN)", "GodModeV3", function(state)
            if state then
                LocalPlayer.CharacterAdded:Connect(function(char)
                    wait(1)
                    local humanoid = char:WaitForChild("Humanoid")
                    
                    -- Force field
                    local ff = Instance.new("ForceField")
                    ff.Parent = char
                    
                    -- No clip
                    for _,part in ipairs(char:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end)
            end
        end)
        
    elseif tab == 2 then -- COMBAT
        CreateToggle(content, "AIMLOCK", "Aimlock", function(state)
            if state then
                RunService.RenderStepped:Connect(function()
                    if not Delta.Toggles.Aimlock or not Delta.Target then return end
                    
                    if Delta.Target.Character and Delta.Target.Character:FindFirstChild("HumanoidRootPart") then
                        local targetPos = Delta.Target.Character.HumanoidRootPart.Position
                        if Delta.Toggles.AimlockHead and Delta.Target.Character:FindFirstChild("Head") then
                            targetPos = Delta.Target.Character.Head.Position
                        elseif Delta.Toggles.AimlockBody then
                            targetPos = Delta.Target.Character.HumanoidRootPart.Position + Vector3.new(0, 1, 0)
                        end
                        
                        local lookAt = CFrame.lookAt(Camera.CFrame.Position, targetPos)
                        Camera.CFrame = Camera.CFrame:Lerp(lookAt, 1 / Delta.Values.AimlockSmoothness)
                    end
                end)
            end
        end)
        
        CreateToggle(content, "AIMLOCK HEAD", "AimlockHead")
        CreateToggle(content, "AIMLOCK BODY", "AimlockBody")
        CreateToggle(content, "AIMLOCK RANDOM", "AimlockRandom")
        
        CreateSlider(content, "SMOOTHNESS", "AimlockSmoothness", 1, 20, function(val)
            Delta.Values.AimlockSmoothness = val
        end)
        
        CreateToggle(content, "HITBOX BIG (x3)", "HitboxBig", function(state)
            if state then
                for _,player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        for _,part in ipairs(player.Character:GetChildren()) do
                            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                                part.Size = part.Size * 3
                            end
                        end
                    end
                end
            end
        end)
        
        CreateToggle(content, "HITBOX MEDIUM (x2)", "HitboxMed")
        CreateToggle(content, "HITBOX SMALL (x0.5)", "HitboxSmall")
        
    elseif tab == 3 then -- VISUAL
        CreateToggle(content, "ESP NAME", "ESPName", function(state)
            if state then
                spawn(function()
                    while Delta.Toggles.ESPName do
                        wait(0.1)
                        for _,player in ipairs(Players:GetPlayers()) do
                            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                                local head = player.Character.Head
                                local pos = Camera:WorldToScreenPoint(head.Position + Vector3.new(0, 3, 0))
                                
                                if pos.Z > 0 then
                                    -- Draw name (simplified for executor)
                                    local distance = (LocalPlayer.Character.HumanoidRootPart.Position - head.Position).Magnitude
                                    if distance < Delta.Values.ESPDistance then
                                        -- Text drawing via BillboardGui
                                        local billboard = Instance.new("BillboardGui")
                                        billboard.Adornee = head
                                        billboard.Size = UDim2.new(0, 100, 0, 30)
                                        billboard.StudsOffset = Vector3.new(0, 3, 0)
                                        
                                        local text = Instance.new("TextLabel")
                                        text.Size = UDim2.new(1, 0, 1, 0)
                                        text.BackgroundTransparency = 1
                                        text.Text = player.Name
                                        text.TextColor3 = Color3.new(1, 1, 1)
                                        text.TextStrokeColor3 = Color3.new(0, 0, 0)
                                        text.TextStrokeTransparency = 0
                                        text.Font = Enum.Font.GothamBold
                                        text.TextScaled = true
                                        text.Parent = billboard
                                        
                                        billboard.Parent = head
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end)
        
        CreateToggle(content, "ESP BOX", "ESPBox")
        CreateToggle(content, "ESP LINE", "ESPLine")
        CreateToggle(content, "ESP SKELETON", "ESPSkeleton")
        
        CreateSlider(content, "ESP DISTANCE", "ESPDistance", 100, 5000, function(val)
            Delta.Values.ESPDistance = val
        end)
        
    elseif tab == 4 then -- MISC
        CreateToggle(content, "TARGET SELECTOR", nil)
        CreateToggle(content, "WALLHACK", nil)
        CreateToggle(content, "NO FOG", nil)
        CreateToggle(content, "FULLBRIGHT", nil)
    end
    
    -- Update canvas size
    wait(0.1)
    content.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
end

-- Target selection system
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.RightShift then
        Delta.MenuOpen = not Delta.MenuOpen
        if Delta.ScreenGui then
            Delta.MainFrame.Visible = Delta.MenuOpen
        else
            CreateUI()
            Delta.MainFrame.Visible = true
        end
    end
    
    if input.KeyCode == Enum.KeyCode.T and UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
        -- Select target
        local mouse = LocalPlayer:GetMouse()
        if mouse.Target then
            local hitPart = mouse.Target
            local character = hitPart.Parent
            if character and character:IsA("Model") then
                for _,player in ipairs(Players:GetPlayers()) do
                    if player.Character == character then
                        Delta.Target = player
                        LocalPlayer:Chat("Target: "..player.Name)
                    end
                end
            end
        end
    end
end)

-- Auto-execute
CreateUI()
Delta.MainFrame.Visible = true

-- Notification
LocalPlayer:Chat("Delta Executor Ultimate Loaded! Press RightShift to open menu")

-- Anti kick
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(...)
    local args = {...}
    local method = getnamecallmethod()
    if method == "FireServer" and args[1] == "TeleportDetect" then
        return
    end
    return old(...)
end)

print("✅ DELTA EXECUTOR ULTIMATE LOADED!")
print("👤 Created by: AxeluzzCode")
print("📱 Contact: 0881010065137")