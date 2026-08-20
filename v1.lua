--==================================================
-- MINE ROCKS - PREMIUM DARK UI / AUTOMATION
--==================================================

--==================================================
-- 1. SERVICES
--==================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
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

local menuOpen = false
local autoFarmCooldown = false
local antiAfkCooldown = false

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
-- 5. SCREEN GUI
--==================================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MagicEvolutionGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

--==================================================
-- 6. COLORS - PREMIUM DARK
--==================================================

local COLORS = {
    Background = Color3.fromRGB(13, 13, 16),
    Panel = Color3.fromRGB(18, 18, 22),
    Section = Color3.fromRGB(24, 24, 29),
    SectionHover = Color3.fromRGB(29, 29, 35),

    Header = Color3.fromRGB(20, 20, 25),

    Text = Color3.fromRGB(245, 245, 248),
    Secondary = Color3.fromRGB(160, 160, 172),
    Muted = Color3.fromRGB(95, 95, 105),

    Accent = Color3.fromRGB(115, 180, 255),
    AccentDark = Color3.fromRGB(55, 100, 165),

    Green = Color3.fromRGB(60, 205, 105),
    GreenDark = Color3.fromRGB(35, 105, 60),

    Off = Color3.fromRGB(48, 48, 56),

    Red = Color3.fromRGB(210, 65, 70),

    Slider = Color3.fromRGB(50, 50, 58),
    Jump = Color3.fromRGB(255, 190, 95)
}

--==================================================
-- 7. UTILITY
--==================================================

local function addCorner(object, radius)

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = object

    return corner
end

local function addStroke(object, color, transparency, thickness)

    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Color3.new(1, 1, 1)
    stroke.Transparency = transparency or 0.7
    stroke.Thickness = thickness or 1
    stroke.Parent = object

    return stroke
end

local function addGradient(object, color1, color2, rotation)

    local gradient = Instance.new("UIGradient")

    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color1),
        ColorSequenceKeypoint.new(1, color2)
    })

    gradient.Rotation = rotation or 90
    gradient.Parent = object

    return gradient
end

--==================================================
-- 8. OPEN BUTTON / ROCK
--==================================================

local logo = Instance.new("TextButton")

logo.Name = "OpenButton"
logo.Size = UDim2.new(0, 60, 0, 60)
logo.Position = UDim2.new(0, 22, 0, 150)

logo.BackgroundColor3 = Color3.fromRGB(38, 38, 45)
logo.BorderSizePixel = 0

logo.Text = "鈼�"
logo.TextColor3 = Color3.fromRGB(150, 185, 215)
logo.TextSize = 30
logo.Font = Enum.Font.GothamBold

logo.AutoButtonColor = false
logo.Parent = screenGui

addCorner(logo, 18)

local logoStroke = addStroke(
    logo,
    Color3.fromRGB(100, 140, 180),
    0.35,
    1.5
)

addGradient(
    logo,
    Color3.fromRGB(48, 48, 57),
    Color3.fromRGB(28, 28, 34),
    135
)

-- Petit reflet

local logoHighlight = Instance.new("Frame")
logoHighlight.Size = UDim2.new(0, 20, 0, 2)
logoHighlight.Position = UDim2.new(0, 11, 0, 9)
logoHighlight.BackgroundColor3 = Color3.fromRGB(170, 195, 220)
logoHighlight.BackgroundTransparency = 0.75
logoHighlight.BorderSizePixel = 0
logoHighlight.Parent = logo

addCorner(logoHighlight, 5)

--==================================================
-- 9. MAIN FRAME
--==================================================

local shadow = Instance.new("Frame")

shadow.Name = "Shadow"
shadow.Size = UDim2.new(0, 370, 0, 400)
shadow.Position = UDim2.new(0.5, -180, 0.5, -190)

shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.45
shadow.BorderSizePixel = 0
shadow.Visible = false
shadow.Parent = screenGui

addCorner(shadow, 20)

local frame = Instance.new("Frame")

frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 360, 0, 390)
frame.Position = UDim2.new(0.5, -180, 0.5, -195)

frame.BackgroundColor3 = COLORS.Background
frame.BorderSizePixel = 0
frame.Visible = false
frame.ClipsDescendants = true
frame.Parent = screenGui

addCorner(frame, 18)

addStroke(
    frame,
    Color3.fromRGB(75, 75, 90),
    0.5,
    1
)

--==================================================
-- 10. HEADER
--==================================================

local header = Instance.new("Frame")

header.Size = UDim2.new(1, 0, 0, 62)
header.Position = UDim2.new(0, 0, 0, 0)

header.BackgroundColor3 = COLORS.Header
header.BorderSizePixel = 0
header.Parent = frame

addCorner(header, 18)

local headerBottom = Instance.new("Frame")
headerBottom.Size = UDim2.new(1, 0, 0, 20)
headerBottom.Position = UDim2.new(0, 0, 1, -20)
headerBottom.BackgroundColor3 = COLORS.Header
headerBottom.BorderSizePixel = 0
headerBottom.Parent = header

local headerLine = Instance.new("Frame")
headerLine.Size = UDim2.new(1, -28, 0, 1)
headerLine.Position = UDim2.new(0, 14, 1, -1)
headerLine.BackgroundColor3 = Color3.fromRGB(70, 70, 82)
headerLine.BackgroundTransparency = 0.45
headerLine.BorderSizePixel = 0
headerLine.Parent = header

--==================================================
-- 11. TITLE
--==================================================

local title = Instance.new("TextLabel")

title.Size = UDim2.new(1, -100, 0, 28)
title.Position = UDim2.new(0, 18, 0, 8)

title.BackgroundTransparency = 1
title.Text = "Mine Rocks"
title.TextColor3 = COLORS.Text
title.Font = Enum.Font.GothamBold
title.TextSize = 19
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local subtitle = Instance.new("TextLabel")

subtitle.Size = UDim2.new(1, -100, 0, 17)
subtitle.Position = UDim2.new(0, 19, 0, 36)

subtitle.BackgroundTransparency = 1
subtitle.Text = "Premium Design"
subtitle.TextColor3 = COLORS.Secondary
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 10
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = header

--==================================================
-- 12. CLOSE BUTTON
--==================================================

local close = Instance.new("TextButton")

close.Size = UDim2.new(0, 34, 0, 34)
close.Position = UDim2.new(1, -48, 0, 14)

close.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
close.Text = "脳"
close.TextColor3 = COLORS.Secondary
close.TextSize = 23
close.Font = Enum.Font.GothamBold

close.AutoButtonColor = false
close.Parent = header

addCorner(close, 10)

local closeStroke = addStroke(
    close,
    Color3.fromRGB(90, 90, 100),
    0.65
)

close.MouseEnter:Connect(function()

    close.BackgroundColor3 = COLORS.Red
    close.TextColor3 = Color3.new(1, 1, 1)

end)

close.MouseLeave:Connect(function()

    close.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
    close.TextColor3 = COLORS.Secondary

end)

--==================================================
-- 13. SCROLL
--==================================================

local scroll = Instance.new("ScrollingFrame")

scroll.Name = "Content"
scroll.Size = UDim2.new(1, -20, 1, -75)
scroll.Position = UDim2.new(0, 10, 0, 70)

scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0

scroll.ScrollBarThickness = 3
scroll.ScrollBarImageColor3 = Color3.fromRGB(90, 90, 100)
scroll.ScrollBarImageTransparency = 0.35

scroll.CanvasSize = UDim2.new(0, 0, 0, 470)

scroll.Parent = frame

local layout = Instance.new("UIListLayout")

layout.Padding = UDim.new(0, 10)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.SortOrder = Enum.SortOrder.LayoutOrder

layout.Parent = scroll

--==================================================
-- 14. SECTION
--==================================================

local function createSection(name, height)

    local section = Instance.new("Frame")

    section.Name = name
    section.Size = UDim2.new(0, 320, 0, height)

    section.BackgroundColor3 = COLORS.Section
    section.BorderSizePixel = 0

    section.Parent = scroll

    addCorner(section, 14)

    addStroke(
        section,
        Color3.fromRGB(70, 70, 82),
        0.72
    )

    return section
end

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
-- 15. TOGGLE
--==================================================

local function createToggle(parent, text, y)

    local label = Instance.new("TextLabel")

    label.Size = UDim2.new(0, 150, 0, 34)
    label.Position = UDim2.new(0, 14, 0, y)

    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = COLORS.Text
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 14

    label.TextXAlignment = Enum.TextXAlignment.Left

    label.Parent = parent

    local button = Instance.new("TextButton")

    button.Size = UDim2.new(0, 82, 0, 32)
    button.Position = UDim2.new(1, -96, 0, y + 1)

    button.BackgroundColor3 = COLORS.Off
    button.BorderSizePixel = 0

    button.Text = ""
    button.AutoButtonColor = false

    button.Parent = parent

    addCorner(button, 16)

    local buttonStroke = addStroke(
        button,
        Color3.fromRGB(85, 85, 95),
        0.6
    )

    -- OFF 脿 droite / ON 脿 gauche

    local status = Instance.new("TextLabel")

    status.Size = UDim2.new(0, 35, 1, 0)
    status.Position = UDim2.new(1, -39, 0, 0)

    status.BackgroundTransparency = 1
    status.Text = "OFF"

    status.TextColor3 = Color3.fromRGB(175, 175, 185)
    status.Font = Enum.Font.GothamBold
    status.TextSize = 10

    status.TextXAlignment = Enum.TextXAlignment.Center

    status.Parent = button

    local knob = Instance.new("Frame")

    knob.Size = UDim2.new(0, 24, 0, 24)
    knob.Position = UDim2.new(0, 4, 0.5, -12)

    knob.BackgroundColor3 = Color3.fromRGB(175, 175, 185)
    knob.BorderSizePixel = 0

    knob.Parent = button

    addCorner(knob, 12)

    local knobStroke = addStroke(
        knob,
        Color3.fromRGB(220, 220, 225),
        0.65
    )

    local state = false

    local function setState(value)

        state = value

        if state then

            button.BackgroundColor3 = COLORS.GreenDark

            knob.Position = UDim2.new(
                1,
                -28,
                0.5,
                -12
            )

            knob.BackgroundColor3 = COLORS.Green

            status.Position = UDim2.new(
                0,
                7,
                0,
                0
            )

            status.Text = "ON"
            status.TextColor3 = Color3.fromRGB(225, 255, 230)

            buttonStroke.Color = COLORS.Green
            buttonStroke.Transparency = 0.4

        else

            button.BackgroundColor3 = COLORS.Off

            knob.Position = UDim2.new(
                0,
                4,
                0.5,
                -12
            )

            knob.BackgroundColor3 = Color3.fromRGB(175, 175, 185)

            status.Position = UDim2.new(
                1,
                -39,
                0,
                0
            )

            status.Text = "OFF"
            status.TextColor3 = Color3.fromRGB(175, 175, 185)

            buttonStroke.Color = Color3.fromRGB(85, 85, 95)
            buttonStroke.Transparency = 0.6

        end

    end

    return button, setState
end

--==================================================
-- 16. FARM
--==================================================

local farmSection = createSection("Farm", 115)

createSectionTitle(
    farmSection,
    "FARM"
)

local btnAF, setAutoFarmVisual = createToggle(
    farmSection,
    "Auto Farm",
    38
)

--==================================================
-- 17. MOVEMENT
--==================================================

local moveSection = createSection(
    "Movement",
    150
)

createSectionTitle(
    moveSection,
    "MOVEMENT"
)

local labelWS = Instance.new("TextLabel")

labelWS.Size = UDim2.new(0, 220, 0, 25)
labelWS.Position = UDim2.new(0, 14, 0, 34)

labelWS.BackgroundTransparency = 1
labelWS.Text = "WalkSpeed: 16"
labelWS.TextColor3 = COLORS.Text

labelWS.Font = Enum.Font.Gotham
labelWS.TextSize = 14
labelWS.TextXAlignment = Enum.TextXAlignment.Left

labelWS.Parent = moveSection

local sliderWS = Instance.new("Frame")

sliderWS.Size = UDim2.new(0, 270, 0, 6)
sliderWS.Position = UDim2.new(0.5, -135, 0, 68)

sliderWS.BackgroundColor3 = COLORS.Slider
sliderWS.BorderSizePixel = 0

sliderWS.Parent = moveSection

addCorner(sliderWS, 6)

local fillWS = Instance.new("Frame")

fillWS.Size = UDim2.new(0, 0, 1, 0)

fillWS.BackgroundColor3 = COLORS.Accent
fillWS.BorderSizePixel = 0

fillWS.Parent = sliderWS

addCorner(fillWS, 6)

local dotWS = Instance.new("Frame")

dotWS.Size = UDim2.new(0, 18, 0, 18)
dotWS.Position = UDim2.new(0, -1, 0.5, -9)

dotWS.BackgroundColor3 = COLORS.Accent
dotWS.BorderSizePixel = 0

dotWS.Parent = sliderWS

addCorner(dotWS, 9)

-- JumpPower

local labelJP = Instance.new("TextLabel")

labelJP.Size = UDim2.new(0, 220, 0, 25)
labelJP.Position = UDim2.new(0, 14, 0, 91)

labelJP.BackgroundTransparency = 1
labelJP.Text = "JumpPower: 50"
labelJP.TextColor3 = COLORS.Text

labelJP.Font = Enum.Font.Gotham
labelJP.TextSize = 14
labelJP.TextXAlignment = Enum.TextXAlignment.Left

labelJP.Parent = moveSection

local sliderJP = Instance.new("Frame")

sliderJP.Size = UDim2.new(0, 270, 0, 6)
sliderJP.Position = UDim2.new(0.5, -135, 0, 125)

sliderJP.BackgroundColor3 = COLORS.Slider
sliderJP.BorderSizePixel = 0

sliderJP.Parent = moveSection

addCorner(sliderJP, 6)

local fillJP = Instance.new("Frame")

fillJP.Size = UDim2.new(0, 0, 1, 0)

fillJP.BackgroundColor3 = COLORS.Jump
fillJP.BorderSizePixel = 0

fillJP.Parent = sliderJP

addCorner(fillJP, 6)

local dotJP = Instance.new("Frame")

dotJP.Size = UDim2.new(0, 18, 0, 18)
dotJP.Position = UDim2.new(0, -1, 0.5, -9)

dotJP.BackgroundColor3 = COLORS.Jump
dotJP.BorderSizePixel = 0

dotJP.Parent = sliderJP

addCorner(dotJP, 9)

--==================================================
-- 18. MISC
--==================================================

local miscSection = createSection(
    "Misc",
    85
)

createSectionTitle(
    miscSection,
    "MISC"
)

local btnAA, setAntiAfkVisual = createToggle(
    miscSection,
    "Anti-AFK",
    34
)

--==================================================
-- 19. DRAG SYSTEM
--==================================================

local function makeDraggable(object, target)

    target = target or object

    local dragging = false
    local dragStart
    local startPosition

    object.InputBegan:Connect(function(input)

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

makeDraggable(header, frame)
makeDraggable(logo)

--==================================================
-- 20. SLIDER SYSTEM
--==================================================

local function setupSlider(
    back,
    dot,
    fill,
    min,
    max,
    callback
)

    local sliding = false

    local function update(input)

        local relative = math.clamp(
            (
                input.Position.X
                - back.AbsolutePosition.X
            )
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

        if not sliding then
            return
        end

        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then

            update(input)

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
    fillWS,
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
    fillJP,
    50,
    350,

    function(value)

        jumpPowerValue = value
        labelJP.Text = "JumpPower: " .. value

    end
)

--==================================================
-- 21. OPEN / CLOSE
--==================================================

logo.Activated:Connect(function()

    menuOpen = not menuOpen

    frame.Visible = menuOpen
    shadow.Visible = menuOpen

end)

close.Activated:Connect(function()

    menuOpen = false

    frame.Visible = false
    shadow.Visible = false

end)

--==================================================
-- 22. AUTO FARM BUTTON
--==================================================

btnAF.Activated:Connect(function()

    -- Emp锚che les doubles clics / clics rapides
    if autoFarmCooldown then
        return
    end

    autoFarmCooldown = true

    autoFarmActive = not autoFarmActive

    setAutoFarmVisual(autoFarmActive)

    task.delay(5, function()

        autoFarmCooldown = false

    end)

end)

--==================================================
-- 23. ANTI-AFK
--==================================================

local antiAfkConnection = nil
local antiAfkLoopRunning = false

local function startAntiAfk()

    if antiAfkLoopRunning then
        return
    end

    antiAfkLoopRunning = true

    -- D茅tection d'inactivit茅 Roblox

    if not antiAfkConnection then

        antiAfkConnection = player.Idled:Connect(function()

            if not antiAfkActive then
                return
            end

            pcall(function()

                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(
                    Vector2.new(0, 0)
                )

            end)

        end)

    end

    -- Activit茅 p茅riodique

    task.spawn(function()

        while antiAfkActive do

            task.wait(60)

            if not antiAfkActive then
                break
            end

            pcall(function()

                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(
                    Vector2.new(0, 0)
                )

            end)

            -- Saut toutes les 60 secondes pour garder le joueur actif
            pcall(function()

                local character = player.Character
                local humanoid = character and character:FindFirstChildOfClass("Humanoid")

                if humanoid then
                    humanoid.Jump = true
                end

            end)

        end

        antiAfkLoopRunning = false

    end)

end

local function stopAntiAfk()

    antiAfkLoopRunning = false

end

btnAA.Activated:Connect(function()

    -- Emp锚che les doubles clics / clics rapides
    if antiAfkCooldown then
        return
    end

    antiAfkCooldown = true

    antiAfkActive = not antiAfkActive

    setAntiAfkVisual(antiAfkActive)

    if antiAfkActive then

        startAntiAfk()

    else

        stopAntiAfk()

    end

    task.delay(5, function()
        antiAfkCooldown = false
    end)

end)

--==================================================
-- 24. MOVEMENT
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

            humanoid.WalkSpeed =
                walkSpeedValue

            humanoid.JumpPower =
                jumpPowerValue

        end

    end)

end)

--==================================================
-- 25. TELEPORT
--==================================================

local function teleportTo(position)

    pcall(function()

        local character = player.Character

        if not character then
            return
        end

        local root =
            character:FindFirstChild(
                "HumanoidRootPart"
            )

        if root then

            root.CFrame =
                CFrame.new(position)

        end

    end)

end

--==================================================
-- 26. AUTO FARM LOOP
--==================================================

task.spawn(function()

    while true do

        if autoFarmActive then

            for _, point in ipairs(farmPoints) do

                if not autoFarmActive then
                    break
                end

                teleportTo(
                    point.position
                )

                task.wait(
                    point.waitTime
                )

            end

        else

            task.wait(0.2)

        end

    end

end)

--==================================================
-- FIN
--==================================================
