--==================================================
-- MINE ROCKS - UI / AUTOMATION
--==================================================

-- 1. SERVICES
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--==================================================
-- 2. VARIABLES
--==================================================

local autoFarmActive = false
local rebirthActive = false
local antiAfkActive = false

local walkSpeedValue = 16
local jumpPowerValue = 50

--==================================================
-- 3. REMOTES
--==================================================

local remotesFolder = ReplicatedStorage:WaitForChild("Remotes")

--==================================================
-- 4. AUTO FARM POSITIONS
--==================================================

local farmPoints = {
    {
        position = Vector3.new(-35.52, 43.027, 3877.809),
        waitTime = 2
    },

    {
        position = Vector3.new(-238.408, 42.12, 3686.551),
        waitTime = 3
    },

    {
        position = Vector3.new(-240.931, 38.719, 3543.366),
        waitTime = 4
    },

    {
        position = Vector3.new(-294.847, 40.748, 3459.949),
        waitTime = 90
    },

    {
        position = Vector3.new(23.434, 42.303, 3825.376),
        waitTime = 2
    }
}

--==================================================
-- 5. CLEAN OLD GUI
--==================================================

local oldGui = playerGui:FindFirstChild("MagicEvolutionGui")

if oldGui then
    oldGui:Destroy()
end

--==================================================
-- 6. SCREEN GUI
--==================================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MagicEvolutionGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

--==================================================
-- 7. COLORS
--==================================================

local backgroundColor = Color3.fromRGB(24, 24, 28)
local panelColor = Color3.fromRGB(31, 31, 36)
local sectionColor = Color3.fromRGB(36, 36, 42)
local headerColor = Color3.fromRGB(29, 29, 34)

local textColor = Color3.fromRGB(245, 245, 245)
local secondaryText = Color3.fromRGB(170, 170, 180)

local offColor = Color3.fromRGB(70, 70, 78)
local onColor = Color3.fromRGB(45, 170, 75)

local redColor = Color3.fromRGB(190, 55, 55)

--==================================================
-- 8. OPEN BUTTON
--==================================================

local logo = Instance.new("TextButton")
logo.Name = "OpenButton"
logo.Size = UDim2.new(0, 58, 0, 58)
logo.Position = UDim2.new(0, 20, 0, 150)
logo.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
logo.Text = "⚡"
logo.TextColor3 = Color3.fromRGB(255, 255, 255)
logo.TextSize = 30
logo.Font = Enum.Font.GothamBold
logo.AutoButtonColor = false
logo.Parent = screenGui

local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(0, 16)
logoCorner.Parent = logo

local logoStroke = Instance.new("UIStroke")
logoStroke.Thickness = 1.5
logoStroke.Transparency = 0.35
logoStroke.Parent = logo

--==================================================
-- 9. MAIN FRAME
--==================================================

local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 360, 0, 380)
frame.Position = UDim2.new(0.5, -180, 0.5, -190)
frame.BackgroundColor3 = backgroundColor
frame.BorderSizePixel = 0
frame.Visible = false
frame.Parent = screenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 18)
frameCorner.Parent = frame

local frameStroke = Instance.new("UIStroke")
frameStroke.Thickness = 1
frameStroke.Transparency = 0.35
frameStroke.Parent = frame

--==================================================
-- 10. HEADER
--==================================================

local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 52)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = headerColor
header.BorderSizePixel = 0
header.Parent = frame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 18)
headerCorner.Parent = header

local headerBottom = Instance.new("Frame")
headerBottom.Size = UDim2.new(1, 0, 0, 18)
headerBottom.Position = UDim2.new(0, 0, 1, -18)
headerBottom.BackgroundColor3 = headerColor
headerBottom.BorderSizePixel = 0
headerBottom.Parent = header

--==================================================
-- TITLE
--==================================================

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 180, 0, 30)
title.Position = UDim2.new(0, 18, 0, 6)
title.BackgroundTransparency = 1
title.Text = "Mine Rocks"
title.TextColor3 = textColor
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(0, 180, 0, 16)
subtitle.Position = UDim2.new(0, 19, 0, 31)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Automation Panel"
subtitle.TextColor3 = secondaryText
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 9
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = header

--==================================================
-- CLOSE BUTTON
--==================================================

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 32, 0, 32)
close.Position = UDim2.new(1, -44, 0, 10)
close.Text = "×"
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.TextSize = 22
close.Font = Enum.Font.GothamBold
close.BackgroundColor3 = redColor
close.AutoButtonColor = false
close.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 10)
closeCorner.Parent = close

--==================================================
-- 11. SCROLL
--==================================================

local scroll = Instance.new("ScrollingFrame")
scroll.Name = "Content"
scroll.Size = UDim2.new(1, -20, 1, -72)
scroll.Position = UDim2.new(0, 10, 0, 60)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 3
scroll.ScrollBarImageTransparency = 0.35
scroll.CanvasSize = UDim2.new(0, 0, 0, 470)
scroll.Parent = frame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 10)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scroll

--==================================================
-- 12. HELPER FUNCTIONS
--==================================================

local function createSection(name, height)

    local section = Instance.new("Frame")
    section.Name = name
    section.Size = UDim2.new(0, 320, 0, height)
    section.BackgroundColor3 = sectionColor
    section.BorderSizePixel = 0
    section.Parent = scroll

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 14)
    corner.Parent = section

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1
    stroke.Transparency = 0.7
    stroke.Parent = section

    return section
end

local function createSectionTitle(parent, text)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 150, 0, 20)
    label.Position = UDim2.new(0, 14, 0, 8)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = secondaryText
    label.Font = Enum.Font.GothamBold
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent

    return label
end

local function createToggle(parent, text, y)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 170, 0, 34)
    label.Position = UDim2.new(0, 14, 0, y)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = textColor
    label.Font = Enum.Font.Gotham
    label.TextSize = 15
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 75, 0, 30)
    button.Position = UDim2.new(1, -89, 0, y + 2)
    button.Text = "OFF"
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 12
    button.BackgroundColor3 = offColor
    button.AutoButtonColor = false
    button.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 9)
    corner.Parent = button

    return button
end

local function setToggle(button, state)

    if state then
        button.Text = "ON"
        button.BackgroundColor3 = onColor
    else
        button.Text = "OFF"
        button.BackgroundColor3 = offColor
    end

end

--==================================================
-- 13. FARM SECTION
--==================================================

local farmSection = createSection("Farm", 115)
createSectionTitle(farmSection, "FARM")

local btnAF = createToggle(
    farmSection,
    "Auto Farm",
    38
)

--==================================================
-- 14. REBIRTH SECTION
--==================================================

local rebirthSection = createSection("Rebirth", 85)
createSectionTitle(rebirthSection, "REBIRTH")

local rebirthButton = createToggle(
    rebirthSection,
    "Rebirth",
    34
)

--==================================================
-- 15. MOVEMENT SECTION
--==================================================

local moveSection = createSection("Movement", 150)
createSectionTitle(moveSection, "MOVEMENT")

local labelWS = Instance.new("TextLabel")
labelWS.Size = UDim2.new(0, 220, 0, 25)
labelWS.Position = UDim2.new(0, 14, 0, 34)
labelWS.BackgroundTransparency = 1
labelWS.Text = "WalkSpeed: 16"
labelWS.TextColor3 = textColor
labelWS.Font = Enum.Font.Gotham
labelWS.TextSize = 14
labelWS.TextXAlignment = Enum.TextXAlignment.Left
labelWS.Parent = moveSection

local sliderWS = Instance.new("Frame")
sliderWS.Size = UDim2.new(0, 270, 0, 6)
sliderWS.Position = UDim2.new(0.5, -135, 0, 68)
sliderWS.BackgroundColor3 = Color3.fromRGB(55, 55, 62)
sliderWS.BorderSizePixel = 0
sliderWS.Parent = moveSection

local sliderCornerWS = Instance.new("UICorner")
sliderCornerWS.CornerRadius = UDim.new(1, 0)
sliderCornerWS.Parent = sliderWS

local dotWS = Instance.new("Frame")
dotWS.Size = UDim2.new(0, 18, 0, 18)
dotWS.Position = UDim2.new(0, -1, 0.5, -9)
dotWS.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
dotWS.BorderSizePixel = 0
dotWS.Parent = sliderWS

local dotCornerWS = Instance.new("UICorner")
dotCornerWS.CornerRadius = UDim.new(1, 0)
dotCornerWS.Parent = dotWS

local labelJP = Instance.new("TextLabel")
labelJP.Size = UDim2.new(0, 220, 0, 25)
labelJP.Position = UDim2.new(0, 14, 0, 91)
labelJP.BackgroundTransparency = 1
labelJP.Text = "JumpPower: 50"
labelJP.TextColor3 = textColor
labelJP.Font = Enum.Font.Gotham
labelJP.TextSize = 14
labelJP.TextXAlignment = Enum.TextXAlignment.Left
labelJP.Parent = moveSection

local sliderJP = Instance.new("Frame")
sliderJP.Size = UDim2.new(0, 270, 0, 6)
sliderJP.Position = UDim2.new(0.5, -135, 0, 125)
sliderJP.BackgroundColor3 = Color3.fromRGB(55, 55, 62)
sliderJP.BorderSizePixel = 0
sliderJP.Parent = moveSection

local sliderCornerJP = Instance.new("UICorner")
sliderCornerJP.CornerRadius = UDim.new(1, 0)
sliderCornerJP.Parent = sliderJP

local dotJP = Instance.new("Frame")
dotJP.Size = UDim2.new(0, 18, 0, 18)
dotJP.Position = UDim2.new(0, -1, 0.5, -9)
dotJP.BackgroundColor3 = Color3.fromRGB(255, 200, 100)
dotJP.BorderSizePixel = 0
dotJP.Parent = sliderJP

local dotCornerJP = Instance.new("UICorner")
dotCornerJP.CornerRadius = UDim.new(1, 0)
dotCornerJP.Parent = dotJP

--==================================================
-- 16. MISC
--==================================================

local miscSection = createSection("Misc", 85)
createSectionTitle(miscSection, "MISC")

local btnAA = createToggle(
    miscSection,
    "Anti-AFK",
    34
)

--==================================================
-- 17. DRAG SYSTEM
--==================================================

local function makeDraggable(obj, target)

    target = target or obj

    local dragging = false
    local dragStart
    local startPosition

    obj.InputBegan:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            dragging = true
            dragStart = input.Position
            startPosition = target.Position

        end

    end)

    UserInputService.InputChanged:Connect(function(input)

        if not dragging then
            return
        end

        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then

            local delta = input.Position - dragStart

            target.Position = UDim2.new(
                startPosition.X.Scale,
                startPosition.X.Offset + delta.X,
                startPosition.Y.Scale,
                startPosition.Y.Offset + delta.Y
            )

        end

    end)

    UserInputService.InputEnded:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            dragging = false

        end

    end)

end

-- Menu déplaçable
makeDraggable(header, frame)

-- Bouton ⚡ déplaçable
makeDraggable(logo)

--==================================================
-- 18. SLIDER SYSTEM
--==================================================

local function setupSlider(back, dot, min, max, callback)

    local sliding = false

    local function update(input)

        local relative = math.clamp(
            (input.Position.X - back.AbsolutePosition.X)
            / back.AbsoluteSize.X,
            0,
            1
        )

        dot.Position = UDim2.new(
            relative,
            -9,
            0.5,
            -9
        )

        local value = math.floor(
            min + relative * (max - min)
        )

        callback(value)

    end

    back.InputBegan:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            sliding = true
            scroll.ScrollingEnabled = false

            update(input)

        end

    end)

    UserInputService.InputChanged:Connect(function(input)

        if sliding then

            if input.UserInputType == Enum.UserInputType.MouseMovement
                or input.UserInputType == Enum.UserInputType.Touch then

                update(input)

            end

        end

    end)

    UserInputService.InputEnded:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            sliding = false
            scroll.ScrollingEnabled = true

        end

    end)

end

setupSlider(
    sliderWS,
    dotWS,
    16,
    250,
    function(value)

        walkSpeedValue = value
        labelWS.Text = "WalkSpeed: " .. value

    end
)

setupSlider(
    sliderJP,
    dotJP,
    50,
    350,
    function(value)

        jumpPowerValue = value
        labelJP.Text = "JumpPower: " .. value

    end
)

--==================================================
-- 19. OPEN / CLOSE
--==================================================

logo.Activated:Connect(function()

    frame.Visible = not frame.Visible

end)

close.Activated:Connect(function()

    frame.Visible = false

end)

--==================================================
-- 20. AUTO FARM BUTTON
--==================================================

btnAF.Activated:Connect(function()

    autoFarmActive = not autoFarmActive

    setToggle(btnAF, autoFarmActive)

end)

--==================================================
-- 21. REBIRTH BUTTON
--==================================================

rebirthButton.Activated:Connect(function()

    rebirthActive = not rebirthActive

    setToggle(rebirthButton, rebirthActive)

end)

--==================================================
-- 22. ANTI-AFK BUTTON
--==================================================

btnAA.Activated:Connect(function()

    antiAfkActive = not antiAfkActive

    setToggle(btnAA, antiAfkActive)

end)

--==================================================
-- 23. MOVEMENT
--==================================================

RunService.Stepped:Connect(function()

    pcall(function()

        local character = player.Character

        if not character then
            return
        end

        local humanoid = character:FindFirstChildOfClass("Humanoid")

        if humanoid then

            humanoid.WalkSpeed = walkSpeedValue
            humanoid.JumpPower = jumpPowerValue

        end

    end)

end)

--==================================================
-- 24. TELEPORT FUNCTION
--==================================================

local function teleportTo(position)

    pcall(function()

        local character = player.Character

        if not character then
            return
        end

        local root = character:FindFirstChild("HumanoidRootPart")

        if root then
            root.CFrame = CFrame.new(position)
        end

    end)

end

--==================================================
-- 25. AUTO FARM LOOP
--==================================================

task.spawn(function()

    while true do

        if autoFarmActive then

            for _, point in ipairs(farmPoints) do

                -- Si désactivé pendant le parcours,
                -- on arrête immédiatement.
                if not autoFarmActive then
                    break
                end

                teleportTo(point.position)

                task.wait(point.waitTime)

            end

        else

            task.wait(0.2)

        end

    end

end)

--==================================================
-- 26. AUTO REBIRTH
--==================================================

task.spawn(function()

    while true do

        if rebirthActive then

            pcall(function()

                for _, remote in ipairs(remotesFolder:GetChildren()) do

                    if remote:IsA("RemoteEvent")
                        and remote.Name == "Rebirth" then

                        remote:FireServer()

                    end

                end

            end)

            task.wait(1)

        else

            task.wait(0.3)

        end

    end

end)

--==================================================
-- 27. ANTI-AFK
--==================================================

player.Idled:Connect(function()

    if antiAfkActive then

        pcall(function()

            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())

        end)

    end

end)

--==================================================
-- FIN
--==================================================
