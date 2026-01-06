local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local flyEnabled, noclipEnabled = false, false
local flySpeed = 50
local bodyVelocity, bodyGyro, noclipConnection

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SammyPanelGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 420, 0, 550)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -275)
mainFrame.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 15)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(150, 20, 20)
mainStroke.Thickness = 3
mainStroke.Parent = mainFrame

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 70)
header.BackgroundColor3 = Color3.fromRGB(150, 20, 20)
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 15)
headerCorner.Parent = header

local headerFix = Instance.new("Frame")
headerFix.Size = UDim2.new(1, 0, 0, 15)
headerFix.Position = UDim2.new(0, 0, 1, -15)
headerFix.BackgroundColor3 = Color3.fromRGB(150, 20, 20)
headerFix.BorderSizePixel = 0
headerFix.Parent = header

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -130, 0, 35)
titleLabel.Position = UDim2.new(0, 15, 0, 5)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Sammy Panel V3.5 😈"
titleLabel.TextColor3 = Color3.fromRGB(255, 220, 50)
titleLabel.TextSize = 24
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = header

local creditLabel = Instance.new("TextLabel")
creditLabel.Size = UDim2.new(1, -130, 0, 20)
creditLabel.Position = UDim2.new(0, 15, 0, 45)
creditLabel.BackgroundTransparency = 1
creditLabel.Text = "🎩♦️💎 by Sammy Fans Team 💎♦️🎩"
creditLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
creditLabel.TextSize = 14
creditLabel.Font = Enum.Font.GothamBold
creditLabel.TextXAlignment = Enum.TextXAlignment.Left
creditLabel.Parent = header

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 55, 0, 55)
closeButton.Position = UDim2.new(1, -65, 0, 7)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 220, 50)
closeButton.Text = "✖"
closeButton.TextColor3 = Color3.fromRGB(200, 30, 30)
closeButton.TextSize = 22
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 10)
closeCorner.Parent = closeButton

local closeStroke = Instance.new("UIStroke")
closeStroke.Color = Color3.fromRGB(200, 30, 30)
closeStroke.Thickness = 3
closeStroke.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
    if bodyVelocity then bodyVelocity:Destroy() end
    if bodyGyro then bodyGyro:Destroy() end
    if noclipConnection then noclipConnection:Disconnect() end
    for _, effect in pairs(rootPart:GetChildren()) do
        if effect:IsA("Fire") or effect:IsA("Smoke") or effect:IsA("PointLight") or effect:IsA("Sparkles") then
            effect:Destroy()
        end
    end
    screenGui:Destroy()
end)

local buttonContainer = Instance.new("ScrollingFrame")
buttonContainer.Size = UDim2.new(1, -30, 1, -90)
buttonContainer.Position = UDim2.new(0, 15, 0, 80)
buttonContainer.BackgroundTransparency = 1
buttonContainer.BorderSizePixel = 0
buttonContainer.ScrollBarThickness = 8
buttonContainer.ScrollBarImageColor3 = Color3.fromRGB(255, 220, 50)
buttonContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
buttonContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
buttonContainer.Parent = mainFrame

local buttonLayout = Instance.new("UIListLayout")
buttonLayout.Padding = UDim.new(0, 12)
buttonLayout.SortOrder = Enum.SortOrder.LayoutOrder
buttonLayout.Parent = buttonContainer

local function createButton(name, text, callback)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(1, -15, 0, 55)
    button.BackgroundColor3 = Color3.fromRGB(255, 220, 50)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(200, 30, 30)
    button.TextSize = 18
    button.Font = Enum.Font.GothamBold
    button.TextStrokeTransparency = 1
    button.Parent = buttonContainer
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 12)
    buttonCorner.Parent = button
    
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = Color3.fromRGB(200, 30, 30)
    buttonStroke.Thickness = 4
    buttonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    buttonStroke.Parent = button
    
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(255, 240, 100)
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(255, 220, 50)
    end)
    
    button.MouseButton1Click:Connect(callback)
    return button
end

createButton("FireButton", "🔥 FIRE ON ME", function()
    if rootPart:FindFirstChild("SammyFire") then
        rootPart.SammyFire:Destroy()
        StarterGui:SetCore("SendNotification", {Title = "Fire", Text = "Desactivado", Duration = 2})
    else
        local fire = Instance.new("Fire")
        fire.Name = "SammyFire"
        fire.Size = 20
        fire.Heat = 20
        fire.Color = Color3.fromRGB(255, 100, 0)
        fire.SecondaryColor = Color3.fromRGB(255, 0, 0)
        fire.Parent = rootPart
        StarterGui:SetCore("SendNotification", {Title = "Fire", Text = "¡Todos te ven ardiendo!", Duration = 2})
    end
end)

createButton("SmokeButton", "💨 SMOKE ON ME", function()
    if rootPart:FindFirstChild("SammySmoke") then
        rootPart.SammySmoke:Destroy()
        StarterGui:SetCore("SendNotification", {Title = "Smoke", Text = "Desactivado", Duration = 2})
    else
        local smoke = Instance.new("Smoke")
        smoke.Name = "SammySmoke"
        smoke.Size = 15
        smoke.Opacity = 0.8
        smoke.RiseVelocity = 10
        smoke.Color = Color3.fromRGB(100, 100, 100)
        smoke.Parent = rootPart
        StarterGui:SetCore("SendNotification", {Title = "Smoke", Text = "¡Todos ven el humo!", Duration = 2})
    end
end)

createButton("SparklesButton", "✨ SPARKLES ON ME", function()
    if rootPart:FindFirstChild("SammySparkles") then
        rootPart.SammySparkles:Destroy()
        StarterGui:SetCore("SendNotification", {Title = "Sparkles", Text = "Desactivado", Duration = 2})
    else
        local sparkles = Instance.new("Sparkles")
        sparkles.Name = "SammySparkles"
        sparkles.SparkleColor = Color3.fromRGB(255, 220, 50)
        sparkles.Parent = rootPart
        StarterGui:SetCore("SendNotification", {Title = "Sparkles", Text = "¡Todos ven los brillos!", Duration = 2})
    end
end)

createButton("LightButton", "💡 GLOW LIGHT", function()
    if rootPart:FindFirstChild("SammyLight") then
        rootPart.SammyLight:Destroy()
        StarterGui:SetCore("SendNotification", {Title = "Light", Text = "Desactivado", Duration = 2})
    else
        local light = Instance.new("PointLight")
        light.Name = "SammyLight"
        light.Brightness = 5
        light.Range = 40
        light.Color = Color3.fromRGB(255, 220, 50)
        light.Parent = rootPart
        StarterGui:SetCore("SendNotification", {Title = "Light", Text = "¡Todos ven tu luz!", Duration = 2})
    end
end)

createButton("HintButton", "🎩 YOUTUBE HINT", function()
    local hint = Instance.new("Hint")
    hint.Text = "👑 Sammy Panel V3.5 😈 | Suscríbete: @SpyderSammy"
    hint.Parent = workspace
    StarterGui:SetCore("SendNotification", {Title = "Hint", Text = "¡Mensaje enviado al servidor!", Duration = 2})
    task.wait(10)
    hint:Destroy()
end)

createButton("MessageButton", "📢 SERVER MESSAGE", function()
    local msg = Instance.new("Message")
    msg.Text = "sigan a Sammy en YouTube: https://youtube.com/@SpyderSammy :3 🎩"
    msg.Parent = workspace
    StarterGui:SetCore("SendNotification", {Title = "Message", Text = "¡Mensaje global enviado!", Duration = 2})
    task.wait(8)
    msg:Destroy()
end)

createButton("SpeedButton", "⚡ SPEED BOOST", function()
    if humanoid.WalkSpeed == 16 then
        humanoid.WalkSpeed = 100
        StarterGui:SetCore("SendNotification", {Title = "Speed", Text = "Velocidad aumentada!", Duration = 2})
    else
        humanoid.WalkSpeed = 16
        StarterGui:SetCore("SendNotification", {Title = "Speed", Text = "Velocidad normal", Duration = 2})
    end
end)

createButton("JumpButton", "🦘 JUMP POWER", function()
    if humanoid.JumpPower == 50 then
        humanoid.JumpPower = 150
        StarterGui:SetCore("SendNotification", {Title = "Jump", Text = "Salto aumentado!", Duration = 2})
    else
        humanoid.JumpPower = 50
        StarterGui:SetCore("SendNotification", {Title = "Jump", Text = "Salto normal", Duration = 2})
    end
end)

createButton("BrightButton", "💡 FULLBRIGHT", function()
    if Lighting.Brightness == 2 then
        Lighting.Brightness = 1
        Lighting.ClockTime = 12
        Lighting.GlobalShadows = true
        Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
        StarterGui:SetCore("SendNotification", {Title = "Fullbright", Text = "Desactivado", Duration = 2})
    else
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        StarterGui:SetCore("SendNotification", {Title = "Fullbright", Text = "Activado!", Duration = 2})
    end
end)

local flyButton = createButton("FlyButton", "🚀 FLY [OFF]", function()
    flyEnabled = not flyEnabled
    if flyEnabled then
        flyButton.Text = "🚀 FLY [ON]"
        flyButton.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bodyVelocity.Parent = rootPart
        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.P = 9e9
        bodyGyro.Parent = rootPart
        local flyConnection
        flyConnection = RunService.RenderStepped:Connect(function()
            if not flyEnabled then
                flyConnection:Disconnect()
                return
            end
            local camera = workspace.CurrentCamera
            bodyGyro.CFrame = camera.CFrame
            local velocity = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                velocity = velocity + camera.CFrame.LookVector * flySpeed
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                velocity = velocity - camera.CFrame.LookVector * flySpeed
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                velocity = velocity - camera.CFrame.RightVector * flySpeed
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                velocity = velocity + camera.CFrame.RightVector * flySpeed
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                velocity = velocity + Vector3.new(0, flySpeed, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                velocity = velocity - Vector3.new(0, flySpeed, 0)
            end
            bodyVelocity.Velocity = velocity
        end)
        StarterGui:SetCore("SendNotification", {Title = "Fly", Text = "WASD + Space/Ctrl", Duration = 3})
    else
        flyButton.Text = "🚀 FLY [OFF]"
        flyButton.BackgroundColor3 = Color3.fromRGB(255, 220, 50)
        if bodyVelocity then bodyVelocity:Destroy() end
        if bodyGyro then bodyGyro:Destroy() end
    end
end)

local noclipButton = createButton("NoclipButton", "👻 NOCLIP [OFF]", function()
    noclipEnabled = not noclipEnabled
    if noclipEnabled then
        noclipButton.Text = "👻 NOCLIP [ON]"
        noclipButton.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
        noclipConnection = RunService.Stepped:Connect(function()
            if not noclipEnabled then return end
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end)
        StarterGui:SetCore("SendNotification", {Title = "Noclip", Text = "Atraviesa paredes!", Duration = 2})
    else
        noclipButton.Text = "👻 NOCLIP [OFF]"
        noclipButton.BackgroundColor3 = Color3.fromRGB(255, 220, 50)
        if noclipConnection then noclipConnection:Disconnect() end
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.CanCollide = true
            end
        end
    end
end)

StarterGui:SetCore("SendNotification", {
    Title = "Sammy Panel V3.5 😈",
    Text = "Panel cargado! By Sammy Team",
    Duration = 10
})
