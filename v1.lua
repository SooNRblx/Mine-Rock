--==================================================
-- MINE ROCKS - UI / AUTOMATION
--==================================================

--==================================================
-- 1. SERVICES
--==================================================

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
local antiAfkActive = false

local walkSpeedValue = 16
local jumpPowerValue = 50

--==================================================
-- 3. AUTO FARM POSITIONS
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
-- 4. CLEAN OLD GUI
--==================================================

local oldGui = playerGui:FindFirstChild("MagicEvolutionGui")

if oldGui then
    oldGui:Destroy()
end

--==================================================
-- 5. COLORS
--==================================================

local COLORS = {
    Background = Color3.fromRGB(13, 14, 18),
    Main = Color3.fromRGB(20, 21, 26),
    Card = Color3.fromRGB(28, 29, 35),
    Card2 = Color3.fromRGB(32, 33, 40),

    Header = Color3.fromRGB(24, 25, 31),

    Text = Color3.fromRGB(248, 248, 250),
    Secondary = Color3.fromRGB(165, 166, 178),
    Muted = Color3.fromRGB(105, 107, 120),

    Accent = Color3.fromRGB(95, 175, 255),
    AccentDark = Color3.fromRGB(50, 115, 190),

    Green = Color3.fromRGB(55, 205, 95),
    GreenDark = Color3.fromRGB(35, 120, 60),

    Off = Color3.fromRGB(55, 56, 65),

    Red = Color3.fromRGB(210, 65, 65),

    Slider = Color3.fromRGB(53, 54, 63),
    Jump = Color3.fromRGB(255, 190, 90)
}

--==================================================
-- 6. UTILITY
--==================================================

local function addCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = parent
    return corner
end

local function addStroke(parent, color, transparency, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Transparency = transparency or 0.5
    stroke.Thickness = thickness or 1
    stroke.Parent = parent
    return stroke
end

--==================================================
-- 7. SCREEN GUI
--==================================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MagicEvolutionGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

--==================================================
-- 8. OPEN BUTTON SHADOW
--==================================================

local logoShadow = Instance.new("Frame")
logoShadow.Name = "LogoShadow"
logoShadow.Size = UDim2.new(0, 64, 0, 64)
logoShadow.Position = UDim2.new(0, 19, 0, 151)
logoShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
logoShadow.BackgroundTransparency = 0.5
logoShadow.BorderSizePixel = 0
logoShadow.Parent = screenGui

addCorner(logoShadow, 19)

--==================================================
-- 9. OPEN BUTTON
--==================================================

local logo = Instance.new("TextButton")
logo.Name = "OpenButton"
logo.Size = UDim2.new(0, 58, 0, 58)
logo.Position = UDim2.new(0, 22, 0, 154)
logo.BackgroundColor3 = COLORS.Card
logo.BorderSizePixel = 0
logo.Text = "⚡"
logo.TextColor3 = COLORS.Text
logo.TextSize = 30
logo.Font = Enum.Font.GothamBold
logo.AutoButtonColor = false
logo.Parent = screenGui

addCorner(logo, 17)
addStroke(logo, COLORS.Accent, 0.55, 1.5)

-- petit effet de fond
local logoGradient = Instance.new("UIGradient")
logoGradient.Rotation = 135
logoGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(39, 42, 52)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 26, 32))
})
logoGradient.Parent = logo

--==================================================
-- 10. MAIN FRAME SHADOW
--==================================================

local shadow = Instance.new("Frame")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(0, 370, 0, 410)
shadow.Position = UDim2.new(0.5, -185, 0.5, -200)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.45
shadow.BorderSizePixel = 0
shadow.Visible = false
shadow.Parent = screenGui

addCorner(shadow, 21)

--==================================================
-- 11. MAIN FRAME
--==================================================

local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 360, 0, 400)
frame.Position = UDim2.new(0.5, -180, 0.5, -200)
frame.BackgroundColor3 = COLORS.Main
frame.BorderSizePixel = 0
frame.Visible = false
frame.ClipsDescendants = true
frame.Parent = screenGui

addCorner(frame, 19)
addStroke(frame, Color3.fromRGB(75, 78, 90), 0.65, 1)

--==================================================
-- 12. HEADER
--==================================================

local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 66)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = COLORS.Header
header.BorderSizePixel = 0
header.Parent = frame

addCorner(header, 19)

-- Partie basse pour garder le header droit
local headerBottom = Instance.new("Frame")
headerBottom.Size = UDim2.new(1, 0, 0, 22)
headerBottom.Position = UDim2.new(0, 0, 1, -22)
headerBottom.BackgroundColor3 = COLORS.Header
headerBottom.BorderSizePixel = 0
headerBottom.Parent = header

-- Ligne décorative
local headerLine = Instance.new("Frame")
headerLine.Size = UDim2.new(1, -30, 0, 1)
headerLine.Position = UDim2.new(0, 15, 1, -1)
headerLine.BackgroundColor3 = Color3.fromRGB(75, 78, 90)
headerLine.BackgroundTransparency = 0.45
headerLine.BorderSizePixel = 0
headerLine.Parent = header

--==================================================
-- 13. HEADER ICON
--==================================================

local headerIcon = Instance.new("Frame")
headerIcon.Size = UDim2.new(0, 32, 0, 32)
headerIcon.Position = UDim2.new(0, 17, 0, 15)
headerIcon.BackgroundColor3 = Color3.fromRGB(35, 39, 49)
headerIcon.BorderSizePixel = 0
headerIcon.Parent = header

addCorner(headerIcon, 10)
addStroke(headerIcon, COLORS.Accent, 0.6, 1)

local iconText = Instance.new("TextLabel")
iconText.Size = UDim2.new(1, 0, 1, 0)
iconText.BackgroundTransparency = 1
iconText.Text = "⚡"
iconText.TextColor3 = COLORS.Accent
iconText.TextSize = 17
iconText.Font = Enum.Font.GothamBold
iconText.Parent = headerIcon

--==================================================
-- 14. TITLE
--==================================================

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 190, 0, 25)
title.Position = UDim2.new(0, 58, 0, 10)
title.BackgroundTransparency = 1
title.Text = "Mine Rocks"
title.TextColor3 = COLORS.Text
title.Font = Enum.Font.GothamBold
title.TextSize = 19
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(0, 190, 0, 18)
subtitle.Position = UDim2.new(0, 59, 0, 34)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Automation Panel"
subtitle.TextColor3 = COLORS.Secondary
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 10
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = header

--==================================================
-- 15. CLOSE BUTTON
--==================================================

local close = Instance.new("TextButton")
close.Name = "Close"
close.Size = UDim2.new(0, 34, 0, 34)
close.Position = UDim2.new(1, -48, 0, 16)
close.BackgroundColor3 = Color3.fromRGB(42, 43, 51)
close.BorderSizePixel = 0
close.Text = "×"
close.TextColor3 = COLORS.Secondary
close.TextSize = 23
close.Font = Enum.Font.GothamBold
close.AutoButtonColor = false
close.Parent = header

addCorner(close, 11)

addStroke(close, Color3.fromRGB(85, 87, 100), 0.65, 1)

--==================================================
-- 16. SCROLL
--==================================================

local scroll = Instance.new("ScrollingFrame")
scroll.Name = "Content"
scroll.Size = UDim2.new(1, -20, 1, -82)
scroll.Position = UDim2.new(0, 10, 0, 72)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 3
scroll.ScrollBarImageColor3 = COLORS.Accent
scroll.ScrollBarImageTransparency = 0.4
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.Parent = frame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 11)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scroll

--==================================================
-- 17. SECTION CREATOR
--==================================================

local function createSection(name, height)

    local section = Instance.new("Frame")
    section.Name = name
    section.Size = UDim2.new(0, 320, 0, height)
    section.BackgroundColor3 = COLORS.Card
    section.BorderSizePixel = 0
    section.Parent = scroll

    addCorner(section, 14)
    addStroke(section, Color3.fromRGB(72, 74, 86), 0.75, 1)

    return section
end

--==================================================
-- 18. SECTION TITLE
--==================================================

local function createSectionTitle(parent, text)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -28, 0, 20)
    label.Position = UDim2.new(0, 14, 0, 8)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = COLORS.Secondary
    label.Font = Enum.Font.GothamBold
    label.TextSize = 10
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent

    return label
end

--==================================================
-- 19. TOGGLE CREATOR
--==================================================

local function createToggle(parent, text, y)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 180, 0, 34)
    label.Position = UDim2.new(0, 14, 0, y)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = COLORS.Text
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 78, 0, 31)
    button.Position = UDim2.new(1, -92, 0, y + 1)
    button.Text = "OFF"
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 11
    button.BackgroundColor3 = COLORS.Off
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    button.Parent = parent

    addCorner(button, 10)
    addStroke(button, Color3.fromRGB(85, 87, 98), 0.65, 1)

    return button
end

--==================================================
-- 20. TOGGLE STATE
--==================================================

local function setToggle(button, state)

    if state then

        button.Text = "ON"
        button.BackgroundColor3 = COLORS.Green

        local stroke = button:FindFirstChildOfClass("UIStroke")

        if stroke then
            stroke.Color = COLORS.Green
            stroke.Transparency = 0.35
        end

    else

        button.Text = "OFF"
        button.BackgroundColor3 = COLORS.Off

        local stroke = button:FindFirstChildOfClass("UIStroke")

        if stroke then
            stroke.Color = Color3.fromRGB(85, 87, 98)
            stroke.Transparency = 0.65
        end

    end

end

--==================================================
-- 21. FARM SECTION
--==================================================

local farmSection = createSection("Farm", 85)

createSectionTitle(
    farmSection,
    "FARM"
)

local btnAF = createToggle(
    farmSection,
    "Auto Farm",
    37
)

--==================================================
-- 22. MOVEMENT SECTION
--==================================================

local moveSection = createSection("Movement", 155)

createSectionTitle(
    moveSection,
    "MOVEMENT"
)

-- WALK SPEED LABEL

local labelWS = Instance.new("TextLabel")
labelWS.Size = UDim2.new(0, 220, 0, 24)
labelWS.Position = UDim2.new(0, 14, 0, 33)
labelWS.BackgroundTransparency = 1
labelWS.Text = "WalkSpeed: 16"
labelWS.TextColor3 = COLORS.Text
labelWS.Font = Enum.Font.GothamMedium
labelWS.TextSize = 14
labelWS.TextXAlignment = Enum.TextXAlignment.Left
labelWS.Parent = moveSection

-- WALK SPEED SLIDER

local sliderWS = Instance.new("Frame")
sliderWS.Size = UDim2.new(0, 270, 0, 6)
sliderWS.Position = UDim2.new(0.5, -135, 0, 65)
sliderWS.BackgroundColor3 = COLORS.Slider
sliderWS.BorderSizePixel = 0
sliderWS.Parent = moveSection

addCorner(sliderWS, 10)

local fillWS = Instance.new("Frame")
fillWS.Size = UDim2.new(0, 0, 1, 0)
fillWS.BackgroundColor3 = COLORS.Accent
fillWS.BorderSizePixel = 0
fillWS.Parent = sliderWS

addCorner(fillWS, 10)

local dotWS = Instance.new("Frame")
dotWS.Size = UDim2.new(0, 18, 0, 18)
dotWS.Position = UDim2.new(0, -1, 0.5, -9)
dotWS.BackgroundColor3 = Color3.fromRGB(235, 245, 255)
dotWS.BorderSizePixel = 0
dotWS.Parent = sliderWS

addCorner(dotWS, 10)
addStroke(dotWS, COLORS.Accent, 0.2, 1)

-- JUMP POWER LABEL

local labelJP = Instance.new("TextLabel")
labelJP.Size = UDim2.new(0, 220, 0, 24)
labelJP.Position = UDim2.new(0, 14, 0, 91)
labelJP.BackgroundTransparency = 1
labelJP.Text = "JumpPower: 50"
labelJP.TextColor3 = COLORS.Text
labelJP.Font = Enum.Font.GothamMedium
labelJP.TextSize = 14
labelJP.TextXAlignment = Enum.TextXAlignment.Left
labelJP.Parent = moveSection

-- JUMP POWER SLIDER

local sliderJP = Instance.new("Frame")
sliderJP.Size = UDim2.new(0, 270, 0, 6)
sliderJP.Position = UDim2.new(0.5, -135, 0, 123)
sliderJP.BackgroundColor3 = COLORS.Slider
sliderJP.BorderSizePixel = 0
sliderJP.Parent = moveSection

addCorner(sliderJP, 10)

local fillJP = Instance.new("Frame")
fillJP.Size = UDim2.new(0, 0, 1, 0)
fillJP.BackgroundColor3 = COLORS.Jump
fillJP.BorderSizePixel = 0
fillJP.Parent = sliderJP

addCorner(fillJP, 10)

local dotJP = Instance.new("Frame")
dotJP.Size = UDim2.new(0, 18, 0, 18)
dotJP.Position = UDim2.new(0, -1, 0.5, -9)
dotJP.BackgroundColor3 = Color3.fromRGB(255, 245, 225)
dotJP.BorderSizePixel = 0
dotJP.Parent = sliderJP

addCorner(dotJP, 10)
addStroke(dotJP, COLORS.Jump, 0.2, 1)

--==================================================
-- 23. MISC SECTION
--==================================================

local miscSection = createSection("Misc", 85)

createSectionTitle(
    miscSection,
    "MISC"
)

local btnAA = createToggle(
    miscSection,
    "Anti-AFK",
    37
)

--==================================================
-- 24. FOOTER
--==================================================

local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, -28, 0, 18)
footer.Position = UDim2.new(0, 14, 1, -23)
footer.BackgroundTransparency = 1
footer.Text = "Mine Rocks  •  Automation Panel"
footer.TextColor3 = COLORS.Muted
footer.Font = Enum.Font.Gotham
footer.TextSize = 9
footer.TextXAlignment = Enum.TextXAlignment.Left
footer.Parent = frame

--==================================================
-- 25. DRAG SYSTEM
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

            if target == frame then

                shadow.Position = UDim2.new(
                    target.Position.X.Scale,
                    target.Position.X.Offset + 5,
                    target.Position.Y.Scale,
                    target.Position.Y.Offset + 7
                )

            end

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
-- 26. SLIDER SYSTEM
--==================================================

local function setupSlider(back, dot, fill, min, max, callback)

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

        fill.Size = UDim2.new(
            relative,
            0,
            1,
            0
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

--==================================================
-- 27. WALK SPEED SLIDER
--==================================================

setupSlider(
    sliderWS,
    dotWS,
    fillWS,
    16,
    250,
    function(value)

        walkSpeedValue = value
        labelWS.Text = "WalkSpeed: " .. value

    end
)

--==================================================
-- 28. JUMP POWER SLIDER
--==================================================

setupSlider(
    sliderJP,
    dotJP,
    fillJP,
    50,
    350,
    function(value)

        jumpPowerValue = value
        labelJP.Text = "JumpPower: " .. value

    end
)

--==================================================
-- 29. OPEN / CLOSE
--==================================================

logo.Activated:Connect(function()

    frame.Visible = not frame.Visible
    shadow.Visible = frame.Visible

end)

close.Activated:Connect(function()

    frame.Visible = false
    shadow.Visible = false

end)

--==================================================
-- 30. AUTO FARM BUTTON
--==================================================

btnAF.Activated:Connect(function()

    autoFarmActive = not autoFarmActive

    setToggle(
        btnAF,
        autoFarmActive
    )

end)

--==================================================
-- 31. ANTI-AFK BUTTON
--==================================================

btnAA.Activated:Connect(function()

    antiAfkActive = not antiAfkActive

    setToggle(
        btnAA,
        antiAfkActive
    )

end)

--==================================================
-- 32. MOVEMENT
--==================================================

RunService.Stepped:Connect(function()

    pcall(function()

        local character = player.Character

        if not character then
            return
        end

        local humanoid =
            character:FindFirstChildOfClass("Humanoid")

        if humanoid then

            humanoid.WalkSpeed = walkSpeedValue
            humanoid.JumpPower = jumpPowerValue

        end

    end)

end)

--==================================================
-- 33. TELEPORT FUNCTION
--==================================================

local function teleportTo(position)

    pcall(function()

        local character = player.Character

        if not character then
            return
        end

        local root =
            character:FindFirstChild("HumanoidRootPart")

        if root then

            root.CFrame =
                CFrame.new(position)

        end

    end)

end

--==================================================
-- 34. AUTO FARM LOOP
--==================================================

task.spawn(function()

    while true do

        if autoFarmActive then

            for _, point in ipairs(farmPoints) do

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
-- 35. ANTI-AFK
--==================================================

player.Idled:Connect(function()

    if antiAfkActive then

        pcall(function()

            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(
                Vector2.new()
            )

        end)

    end

end)

--==================================================
-- FIN
--==================================================
