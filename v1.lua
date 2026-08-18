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
    Background = Color3.fromRGB(10, 11, 14),
    Main = Color3.fromRGB(18, 19, 23),
    Header = Color3.fromRGB(22, 23, 28),

    Section = Color3.fromRGB(25, 26, 31),
    SectionHover = Color3.fromRGB(29, 30, 36),

    Border = Color3.fromRGB(65, 67, 76),

    Text = Color3.fromRGB(245, 246, 250),
    Secondary = Color3.fromRGB(155, 158, 170),
    Muted = Color3.fromRGB(90, 93, 103),

    Accent = Color3.fromRGB(115, 180, 255),
    AccentDark = Color3.fromRGB(65, 120, 190),

    Green = Color3.fromRGB(70, 205, 105),
    GreenDark = Color3.fromRGB(32, 95, 53),

    Off = Color3.fromRGB(45, 47, 54),
    OffKnob = Color3.fromRGB(155, 158, 168),

    Red = Color3.fromRGB(215, 65, 70),

    Slider = Color3.fromRGB(48, 50, 58),
    SliderBlue = Color3.fromRGB(105, 175, 255),
    SliderOrange = Color3.fromRGB(255, 190, 90)
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
    stroke.Color = color or COLORS.Border
    stroke.Transparency = transparency or 0.7
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
-- 8. PREMIUM FLOATING STONE BUTTON
--==================================================

local logo = Instance.new("TextButton")
logo.Name = "OpenButton"

logo.Size = UDim2.new(0, 62, 0, 62)
logo.Position = UDim2.new(0, 20, 0, 150)

logo.BackgroundColor3 = Color3.fromRGB(31, 32, 38)
logo.BorderSizePixel = 0

-- Pierre
logo.Text = "◆"
logo.TextColor3 = Color3.fromRGB(190, 195, 205)
logo.TextSize = 29
logo.Font = Enum.Font.GothamBold

logo.AutoButtonColor = false
logo.Parent = screenGui

addCorner(logo, 19)
addStroke(logo, Color3.fromRGB(105, 110, 125), 0.35, 1.5)

-- Petit reflet
local logoHighlight = Instance.new("Frame")
logoHighlight.Name = "Highlight"

logoHighlight.Size = UDim2.new(0, 18, 0, 5)
logoHighlight.Position = UDim2.new(0, 12, 0, 10)

logoHighlight.BackgroundColor3 = Color3.fromRGB(220, 225, 235)
logoHighlight.BackgroundTransparency = 0.8
logoHighlight.BorderSizePixel = 0
logoHighlight.Parent = logo

addCorner(logoHighlight, 5)

-- Animation du bouton
logo.MouseEnter:Connect(function()

    logo.BackgroundColor3 = Color3.fromRGB(42, 44, 52)
    logo.TextColor3 = Color3.fromRGB(225, 230, 240)

end)

logo.MouseLeave:Connect(function()

    logo.BackgroundColor3 = Color3.fromRGB(31, 32, 38)
    logo.TextColor3 = Color3.fromRGB(190, 195, 205)

end)

--==================================================
-- 9. MAIN FRAME
--==================================================

local frame = Instance.new("Frame")
frame.Name = "MainFrame"

frame.Size = UDim2.new(0, 365, 0, 400)
frame.Position = UDim2.new(0.5, -182, 0.5, -200)

frame.BackgroundColor3 = COLORS.Main
frame.BorderSizePixel = 0
frame.Visible = false
frame.ClipsDescendants = true

frame.Parent = screenGui

addCorner(frame, 20)
addStroke(frame, COLORS.Border, 0.55, 1)

--==================================================
-- 10. HEADER
--==================================================

local header = Instance.new("Frame")
header.Name = "Header"

header.Size = UDim2.new(1, 0, 0, 66)
header.BackgroundColor3 = COLORS.Header
header.BorderSizePixel = 0
header.Parent = frame

addCorner(header, 20)

local headerBottom = Instance.new("Frame")
headerBottom.Size = UDim2.new(1, 0, 0, 22)
headerBottom.Position = UDim2.new(0, 0, 1, -22)

headerBottom.BackgroundColor3 = COLORS.Header
headerBottom.BorderSizePixel = 0
headerBottom.Parent = header

-- Petite ligne premium
local headerLine = Instance.new("Frame")
headerLine.Size = UDim2.new(1, -28, 0, 1)
headerLine.Position = UDim2.new(0, 14, 1, -1)

headerLine.BackgroundColor3 = COLORS.Border
headerLine.BackgroundTransparency = 0.45
headerLine.BorderSizePixel = 0
headerLine.Parent = header

--==================================================
-- TITLE
--==================================================

local title = Instance.new("TextLabel")

title.Size = UDim2.new(0, 220, 0, 28)
title.Position = UDim2.new(0, 20, 0, 9)

title.BackgroundTransparency = 1
title.Text = "Mine Rocks"

title.TextColor3 = COLORS.Text
title.Font = Enum.Font.GothamBold
title.TextSize = 20

title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

--==================================================
-- SUBTITLE
--==================================================

local subtitle = Instance.new("TextLabel")

subtitle.Size = UDim2.new(0, 220, 0, 18)
subtitle.Position = UDim2.new(0, 21, 0, 37)

subtitle.BackgroundTransparency = 1
subtitle.Text = "Premium Design"

subtitle.TextColor3 = COLORS.Secondary
subtitle.Font = Enum.Font.GothamMedium
subtitle.TextSize = 10

subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = header

--==================================================
-- CLOSE BUTTON
--==================================================

local close = Instance.new("TextButton")

close.Size = UDim2.new(0, 34, 0, 34)
close.Position = UDim2.new(1, -48, 0, 16)

close.BackgroundColor3 = Color3.fromRGB(37, 38, 44)
close.BorderSizePixel = 0

close.Text = "×"
close.TextColor3 = COLORS.Secondary
close.TextSize = 23
close.Font = Enum.Font.GothamMedium

close.AutoButtonColor = false
close.Parent = header

addCorner(close, 11)

close.MouseEnter:Connect(function()

    close.BackgroundColor3 = COLORS.Red
    close.TextColor3 = Color3.new(1, 1, 1)

end)

close.MouseLeave:Connect(function()

    close.BackgroundColor3 = Color3.fromRGB(37, 38, 44)
    close.TextColor3 = COLORS.Secondary

end)

--==================================================
-- 11. SCROLL
--==================================================

local scroll = Instance.new("ScrollingFrame")

scroll.Name = "Content"

scroll.Size = UDim2.new(1, -20, 1, -82)
scroll.Position = UDim2.new(0, 10, 0, 72)

scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0

scroll.ScrollBarThickness = 3
scroll.ScrollBarImageColor3 = Color3.fromRGB(90, 94, 105)
scroll.ScrollBarImageTransparency = 0.35

scroll.CanvasSize = UDim2.new(0, 0, 0, 410)

scroll.Parent = frame

local layout = Instance.new("UIListLayout")

layout.Padding = UDim.new(0, 11)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.SortOrder = Enum.SortOrder.LayoutOrder

layout.Parent = scroll

--==================================================
-- 12. SECTION CREATOR
--==================================================

local function createSection(name, height)

    local section = Instance.new("Frame")

    section.Name = name

    section.Size = UDim2.new(0, 325, 0, height)

    section.BackgroundColor3 = COLORS.Section
    section.BorderSizePixel = 0

    section.Parent = scroll

    addCorner(section, 15)
    addStroke(section, COLORS.Border, 0.78, 1)

    return section
end

--==================================================
-- SECTION TITLE
--==================================================

local function createSectionTitle(parent, text)

    local label = Instance.new("TextLabel")

    label.Size = UDim2.new(0, 200, 0, 20)
    label.Position = UDim2.new(0, 15, 0, 9)

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
-- PREMIUM TOGGLE
--==================================================

local function createToggle(parent, text, y)

    local label = Instance.new("TextLabel")

    label.Size = UDim2.new(0, 180, 0, 34)
    label.Position = UDim2.new(0, 15, 0, y)

    label.BackgroundTransparency = 1
    label.Text = text

    label.TextColor3 = COLORS.Text
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 14

    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent

    -- Conteneur
    local button = Instance.new("TextButton")

    button.Size = UDim2.new(0, 72, 0, 30)
    button.Position = UDim2.new(1, -87, 0, y + 2)

    button.BackgroundColor3 = COLORS.Off
    button.BorderSizePixel = 0

    button.Text = ""
    button.AutoButtonColor = false

    button.Parent = parent

    addCorner(button, 15)

    local buttonStroke =
        addStroke(button, Color3.fromRGB(75, 78, 88), 0.55, 1)

    -- ON / OFF petit texte
    local stateText = Instance.new("TextLabel")

    stateText.Size = UDim2.new(1, -30, 1, 0)
    stateText.Position = UDim2.new(0, 25, 0, 0)

    stateText.BackgroundTransparency = 1

    stateText.Text = "OFF"
    stateText.TextColor3 = COLORS.Secondary

    stateText.Font = Enum.Font.GothamBold
    stateText.TextSize = 9

    stateText.Parent = button

    -- Curseur
    local knob = Instance.new("Frame")

    knob.Size = UDim2.new(0, 22, 0, 22)
    knob.Position = UDim2.new(0, 4, 0.5, -11)

    knob.BackgroundColor3 = COLORS.OffKnob
    knob.BorderSizePixel = 0

    knob.Parent = button

    addCorner(knob, 11)

    local knobStroke =
        addStroke(knob, Color3.fromRGB(220, 220, 225), 0.65, 1)

    local state = false

    local function setState(value)

        state = value

        if state then

            button.BackgroundColor3 = COLORS.GreenDark

            knob.Position =
                UDim2.new(1, -26, 0.5, -11)

            knob.BackgroundColor3 = COLORS.Green

            stateText.Text = "ON"
            stateText.TextColor3 = Color3.fromRGB(210, 255, 220)

            buttonStroke.Color = COLORS.Green
            buttonStroke.Transparency = 0.35

            knobStroke.Color = COLORS.Green
            knobStroke.Transparency = 0.35

        else

            button.BackgroundColor3 = COLORS.Off

            knob.Position =
                UDim2.new(0, 4, 0.5, -11)

            knob.BackgroundColor3 = COLORS.OffKnob

            stateText.Text = "OFF"
            stateText.TextColor3 = COLORS.Secondary

            buttonStroke.Color =
                Color3.fromRGB(75, 78, 88)

            buttonStroke.Transparency = 0.55

            knobStroke.Color =
                Color3.fromRGB(220, 220, 225)

            knobStroke.Transparency = 0.65

        end
    end

    return button, setState
end

--==================================================
-- 13. FARM
--==================================================

local farmSection = createSection("Farm", 78)

createSectionTitle(farmSection, "FARM")

local btnAF, setAutoFarmVisual =
    createToggle(
        farmSection,
        "Auto Farm",
        32
    )

--==================================================
-- 14. MOVEMENT
--==================================================

local moveSection = createSection("Movement", 154)

createSectionTitle(moveSection, "MOVEMENT")

-- WALKSPEED

local labelWS = Instance.new("TextLabel")

labelWS.Size = UDim2.new(0, 220, 0, 25)
labelWS.Position = UDim2.new(0, 15, 0, 32)

labelWS.BackgroundTransparency = 1

labelWS.Text = "WalkSpeed: 16"
labelWS.TextColor3 = COLORS.Text

labelWS.Font = Enum.Font.GothamMedium
labelWS.TextSize = 14

labelWS.TextXAlignment = Enum.TextXAlignment.Left
labelWS.Parent = moveSection

local sliderWS = Instance.new("Frame")

sliderWS.Size = UDim2.new(0, 270, 0, 6)
sliderWS.Position = UDim2.new(0.5, -135, 0, 64)

sliderWS.BackgroundColor3 = COLORS.Slider
sliderWS.BorderSizePixel = 0

sliderWS.Parent = moveSection

addCorner(sliderWS, 6)

local fillWS = Instance.new("Frame")

fillWS.Size = UDim2.new(0, 0, 1, 0)

fillWS.BackgroundColor3 = COLORS.SliderBlue
fillWS.BorderSizePixel = 0

fillWS.Parent = sliderWS

addCorner(fillWS, 6)

local dotWS = Instance.new("Frame")

dotWS.Size = UDim2.new(0, 18, 0, 18)
dotWS.Position = UDim2.new(0, -9, 0.5, -9)

dotWS.BackgroundColor3 = Color3.fromRGB(235, 242, 255)
dotWS.BorderSizePixel = 0

dotWS.Parent = sliderWS

addCorner(dotWS, 9)

addStroke(dotWS, COLORS.SliderBlue, 0.25, 1)

-- JUMPPOWER

local labelJP = Instance.new("TextLabel")

labelJP.Size = UDim2.new(0, 220, 0, 25)
labelJP.Position = UDim2.new(0, 15, 0, 91)

labelJP.BackgroundTransparency = 1

labelJP.Text = "JumpPower: 50"
labelJP.TextColor3 = COLORS.Text

labelJP.Font = Enum.Font.GothamMedium
labelJP.TextSize = 14

labelJP.TextXAlignment = Enum.TextXAlignment.Left
labelJP.Parent = moveSection

local sliderJP = Instance.new("Frame")

sliderJP.Size = UDim2.new(0, 270, 0, 6)
sliderJP.Position = UDim2.new(0.5, -135, 0, 123)

sliderJP.BackgroundColor3 = COLORS.Slider
sliderJP.BorderSizePixel = 0

sliderJP.Parent = moveSection

addCorner(sliderJP, 6)

local fillJP = Instance.new("Frame")

fillJP.Size = UDim2.new(0, 0, 1, 0)

fillJP.BackgroundColor3 = COLORS.SliderOrange
fillJP.BorderSizePixel = 0

fillJP.Parent = sliderJP

addCorner(fillJP, 6)

local dotJP = Instance.new("Frame")

dotJP.Size = UDim2.new(0, 18, 0, 18)
dotJP.Position = UDim2.new(0, -9, 0.5, -9)

dotJP.BackgroundColor3 = Color3.fromRGB(255, 245, 225)
dotJP.BorderSizePixel = 0

dotJP.Parent = sliderJP

addCorner(dotJP, 9)

addStroke(dotJP, COLORS.SliderOrange, 0.25, 1)

--==================================================
-- 15. MISC
--==================================================

local miscSection = createSection("Misc", 78)

createSectionTitle(miscSection, "MISC")

local btnAA, setAntiAfkVisual =
    createToggle(
        miscSection,
        "Anti-AFK",
        32
    )

--==================================================
-- 16. DRAG SYSTEM
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

            local delta =
                input.Position - dragStart

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

-- Fenêtre déplaçable
makeDraggable(header, frame)

-- Pierre entièrement déplaçable
makeDraggable(logo)

--==================================================
-- 17. SLIDER SYSTEM
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
-- WALK SPEED SLIDER
--==================================================

setupSlider(
    sliderWS,
    dotWS,
    fillWS,
    16,
    250,

    function(value)

        walkSpeedValue = value

        labelWS.Text =
            "WalkSpeed: " .. value

    end
)

--==================================================
-- JUMP POWER SLIDER
--==================================================

setupSlider(
    sliderJP,
    dotJP,
    fillJP,
    50,
    350,

    function(value)

        jumpPowerValue = value

        labelJP.Text =
            "JumpPower: " .. value

    end
)

--==================================================
-- 18. MENU
--==================================================

logo.Activated:Connect(function()

    frame.Visible = not frame.Visible

end)

close.Activated:Connect(function()

    frame.Visible = false

end)

--==================================================
-- 19. AUTO FARM
--==================================================

-- Anti double-clic
local autoFarmDebounce = false

btnAF.Activated:Connect(function()

    if autoFarmDebounce then
        return
    end

    autoFarmDebounce = true

    autoFarmActive = not autoFarmActive

    setAutoFarmVisual(autoFarmActive)

    task.delay(0.15, function()

        autoFarmDebounce = false

    end)

end)

--==================================================
-- 20. ANTI-AFK
--==================================================

local antiAfkDebounce = false

btnAA.Activated:Connect(function()

    if antiAfkDebounce then
        return
    end

    antiAfkDebounce = true

    antiAfkActive = not antiAfkActive

    setAntiAfkVisual(antiAfkActive)

    task.delay(0.15, function()

        antiAfkDebounce = false

    end)

end)

--==================================================
-- 21. MOVEMENT
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
-- 22. TELEPORT
--==================================================

local function teleportTo(position)

    pcall(function()

        local character =
            player.Character

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
-- 23. AUTO FARM LOOP
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
-- 24. ANTI-AFK
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
