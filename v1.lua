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

-- Cooldown des boutons
local toggleCooldown = 5

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
    Background = Color3.fromRGB(12, 13, 16),
    Panel = Color3.fromRGB(18, 19, 23),
    Section = Color3.fromRGB(23, 24, 29),

    Header = Color3.fromRGB(20, 21, 26),

    Text = Color3.fromRGB(245, 246, 248),
    Secondary = Color3.fromRGB(150, 153, 162),
    Muted = Color3.fromRGB(90, 93, 102),

    Border = Color3.fromRGB(55, 57, 66),

    Accent = Color3.fromRGB(120, 180, 255),

    ToggleOff = Color3.fromRGB(45, 47, 54),
    ToggleOffBorder = Color3.fromRGB(75, 78, 88),

    ToggleOn = Color3.fromRGB(35, 115, 65),
    ToggleOnBorder = Color3.fromRGB(70, 200, 105),
    ToggleOnText = Color3.fromRGB(115, 235, 145),

    Stone = Color3.fromRGB(68, 72, 82),
    StoneLight = Color3.fromRGB(105, 110, 122),

    Red = Color3.fromRGB(185, 55, 65),

    Slider = Color3.fromRGB(45, 47, 55),
    SliderBlue = Color3.fromRGB(95, 165, 255),
    SliderOrange = Color3.fromRGB(255, 190, 90)
}

--==================================================
-- 7. UTILITY
--==================================================

local function addCorner(parent, radius)

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = parent

    return c
end

local function addStroke(parent, color, transparency, thickness)

    local s = Instance.new("UIStroke")

    s.Color = color or Color3.new(1, 1, 1)
    s.Transparency = transparency or 0.5
    s.Thickness = thickness or 1

    s.Parent = parent

    return s
end

--==================================================
-- 8. OPEN BUTTON
--==================================================

local logo = Instance.new("TextButton")

logo.Name = "OpenButton"
logo.Size = UDim2.new(0, 58, 0, 58)
logo.Position = UDim2.new(0, 22, 0, 150)

logo.BackgroundColor3 = COLORS.Stone

logo.Text = "◆"
logo.TextColor3 = COLORS.StoneLight
logo.TextSize = 27
logo.Font = Enum.Font.GothamBold

logo.AutoButtonColor = false
logo.BorderSizePixel = 0

logo.Parent = screenGui

addCorner(logo, 17)

addStroke(
    logo,
    Color3.fromRGB(125, 130, 145),
    0.35,
    1.5
)

local logoHighlight = Instance.new("Frame")

logoHighlight.Size = UDim2.new(0, 18, 0, 5)
logoHighlight.Position = UDim2.new(0, 12, 0, 10)

logoHighlight.BackgroundColor3 =
    Color3.fromRGB(145, 150, 165)

logoHighlight.BackgroundTransparency = 0.65

logoHighlight.BorderSizePixel = 0
logoHighlight.Parent = logo

addCorner(logoHighlight, 5)

--==================================================
-- 9. MAIN FRAME
--==================================================

local frame = Instance.new("Frame")

frame.Name = "MainFrame"

frame.Size = UDim2.new(0, 360, 0, 380)

frame.Position =
    UDim2.new(0.5, -180, 0.5, -190)

frame.BackgroundColor3 =
    COLORS.Background

frame.BorderSizePixel = 0

frame.Visible = false

frame.Parent = screenGui

addCorner(frame, 18)

addStroke(
    frame,
    COLORS.Border,
    0.25,
    1
)

--==================================================
-- 10. HEADER
--==================================================

local header = Instance.new("Frame")

header.Name = "Header"

header.Size =
    UDim2.new(1, 0, 0, 58)

header.BackgroundColor3 =
    COLORS.Header

header.BorderSizePixel = 0

header.Parent = frame

addCorner(header, 18)

local headerBottom = Instance.new("Frame")

headerBottom.Size =
    UDim2.new(1, 0, 0, 20)

headerBottom.Position =
    UDim2.new(0, 0, 1, -20)

headerBottom.BackgroundColor3 =
    COLORS.Header

headerBottom.BorderSizePixel = 0

headerBottom.Parent = header

--==================================================
-- TITLE
--==================================================

local title = Instance.new("TextLabel")

title.Size =
    UDim2.new(0, 220, 0, 27)

title.Position =
    UDim2.new(0, 18, 0, 7)

title.BackgroundTransparency = 1

title.Text = "Mine Rocks"

title.TextColor3 =
    COLORS.Text

title.Font =
    Enum.Font.GothamBold

title.TextSize = 18

title.TextXAlignment =
    Enum.TextXAlignment.Left

title.Parent = header

--==================================================
-- SUBTITLE
--==================================================

local subtitle = Instance.new("TextLabel")

subtitle.Size =
    UDim2.new(0, 220, 0, 17)

subtitle.Position =
    UDim2.new(0, 19, 0, 33)

subtitle.BackgroundTransparency = 1

subtitle.Text = "Premium Design"

subtitle.TextColor3 =
    COLORS.Secondary

subtitle.Font =
    Enum.Font.Gotham

subtitle.TextSize = 9

subtitle.TextXAlignment =
    Enum.TextXAlignment.Left

subtitle.Parent = header

--==================================================
-- CLOSE BUTTON
--==================================================

local close = Instance.new("TextButton")

close.Size =
    UDim2.new(0, 32, 0, 32)

close.Position =
    UDim2.new(1, -44, 0, 12)

close.BackgroundColor3 =
    Color3.fromRGB(38, 39, 46)

close.Text = "×"

close.TextColor3 =
    COLORS.Secondary

close.TextSize = 22

close.Font =
    Enum.Font.GothamBold

close.AutoButtonColor = false

close.BorderSizePixel = 0

close.Parent = header

addCorner(close, 10)

--==================================================
-- 11. SCROLL
--==================================================

local scroll = Instance.new("ScrollingFrame")

scroll.Name = "Content"

scroll.Size =
    UDim2.new(1, -20, 1, -72)

scroll.Position =
    UDim2.new(0, 10, 0, 64)

scroll.BackgroundTransparency = 1

scroll.BorderSizePixel = 0

scroll.ScrollBarThickness = 3

scroll.ScrollBarImageColor3 =
    COLORS.Accent

scroll.ScrollBarImageTransparency = 0.45

scroll.CanvasSize =
    UDim2.new(0, 0, 0, 450)

scroll.Parent = frame

local layout = Instance.new("UIListLayout")

layout.Padding =
    UDim.new(0, 10)

layout.HorizontalAlignment =
    Enum.HorizontalAlignment.Center

layout.SortOrder =
    Enum.SortOrder.LayoutOrder

layout.Parent = scroll

--==================================================
-- 12. SECTION CREATOR
--==================================================

local function createSection(name, height)

    local section = Instance.new("Frame")

    section.Name = name

    section.Size =
        UDim2.new(0, 320, 0, height)

    section.BackgroundColor3 =
        COLORS.Section

    section.BorderSizePixel = 0

    section.Parent = scroll

    addCorner(section, 14)

    addStroke(
        section,
        COLORS.Border,
        0.65,
        1
    )

    return section
end

--==================================================
-- SECTION TITLE
--==================================================

local function createSectionTitle(parent, text)

    local label = Instance.new("TextLabel")

    label.Size =
        UDim2.new(0, 200, 0, 20)

    label.Position =
        UDim2.new(0, 14, 0, 8)

    label.BackgroundTransparency = 1

    label.Text = text

    label.TextColor3 =
        COLORS.Secondary

    label.Font =
        Enum.Font.GothamBold

    label.TextSize = 10

    label.TextXAlignment =
        Enum.TextXAlignment.Left

    label.Parent = parent

    return label
end

--==================================================
-- 13. TOGGLE CREATOR
--==================================================

local function createToggle(parent, text, y)

    local label = Instance.new("TextLabel")

    label.Size =
        UDim2.new(0, 170, 0, 34)

    label.Position =
        UDim2.new(0, 14, 0, y)

    label.BackgroundTransparency = 1

    label.Text = text

    label.TextColor3 =
        COLORS.Text

    label.Font =
        Enum.Font.GothamMedium

    label.TextSize = 14

    label.TextXAlignment =
        Enum.TextXAlignment.Left

    label.Parent = parent

    --==================================================
    -- TOGGLE BUTTON
    --==================================================

    local button = Instance.new("TextButton")

    button.Size =
        UDim2.new(0, 82, 0, 32)

    button.Position =
        UDim2.new(1, -96, 0, y + 1)

    button.BackgroundColor3 =
        COLORS.ToggleOff

    button.Text = ""

    button.AutoButtonColor = false

    button.BorderSizePixel = 0

    button.Parent = parent

    addCorner(button, 16)

    local buttonStroke = addStroke(
        button,
        COLORS.ToggleOffBorder,
        0.45,
        1
    )

    --==================================================
    -- ON TEXT - LEFT
    --==================================================

    local onText = Instance.new("TextLabel")

    onText.Size =
        UDim2.new(0, 35, 1, 0)

    onText.Position =
        UDim2.new(0, 7, 0, 0)

    onText.BackgroundTransparency = 1

    onText.Text = "ON"

    onText.TextColor3 =
        Color3.fromRGB(100, 105, 112)

    onText.Font =
        Enum.Font.GothamBold

    onText.TextSize = 10

    onText.TextXAlignment =
        Enum.TextXAlignment.Left

    onText.Parent = button

    --==================================================
    -- OFF TEXT - RIGHT
    --==================================================

    local offText = Instance.new("TextLabel")

    offText.Size =
        UDim2.new(0, 35, 1, 0)

    offText.Position =
        UDim2.new(1, -42, 0, 0)

    offText.BackgroundTransparency = 1

    offText.Text = "OFF"

    offText.TextColor3 =
        Color3.fromRGB(235, 237, 240)

    offText.Font =
        Enum.Font.GothamBold

    offText.TextSize = 10

    offText.TextXAlignment =
        Enum.TextXAlignment.Right

    offText.Parent = button

    --==================================================
    -- KNOB
    --==================================================

    local knob = Instance.new("Frame")

    knob.Size =
        UDim2.new(0, 24, 0, 24)

    knob.Position =
        UDim2.new(0, 4, 0.5, -12)

    knob.BackgroundColor3 =
        Color3.fromRGB(185, 188, 195)

    knob.BorderSizePixel = 0

    knob.Parent = button

    addCorner(knob, 12)

    --==================================================
    -- VISUAL STATE
    --==================================================

    local function setVisual(state)

        if state then

            -- ON
            -- rond à droite

            knob.Position =
                UDim2.new(
                    1,
                    -28,
                    0.5,
                    -12
                )

            button.BackgroundColor3 =
                COLORS.ToggleOn

            buttonStroke.Color =
                COLORS.ToggleOnBorder

            buttonStroke.Transparency = 0.35

            knob.BackgroundColor3 =
                COLORS.ToggleOnBorder

            onText.TextColor3 =
                COLORS.ToggleOnText

            offText.TextColor3 =
                Color3.fromRGB(100, 105, 112)

        else

            -- OFF
            -- rond à gauche

            knob.Position =
                UDim2.new(
                    0,
                    4,
                    0.5,
                    -12
                )

            button.BackgroundColor3 =
                COLORS.ToggleOff

            buttonStroke.Color =
                COLORS.ToggleOffBorder

            buttonStroke.Transparency = 0.45

            knob.BackgroundColor3 =
                Color3.fromRGB(185, 188, 195)

            onText.TextColor3 =
                Color3.fromRGB(100, 105, 112)

            offText.TextColor3 =
                Color3.fromRGB(235, 237, 240)

        end
    end

    setVisual(false)

    -- IMPORTANT :
    -- Le bouton NE change plus son état ici.
    -- Le script principal contrôle l'état.

    return button, setVisual
end

--==================================================
-- 14. FARM SECTION
--==================================================

local farmSection =
    createSection("Farm", 100)

createSectionTitle(
    farmSection,
    "FARM"
)

local btnAF, setAutoFarmVisual =
    createToggle(
        farmSection,
        "Auto Farm",
        38
    )

--==================================================
-- AUTO FARM CLICK
--==================================================

local autoFarmButtonLocked = false

btnAF.Activated:Connect(function()

    -- Empêche les doubles clics
    if autoFarmButtonLocked then
        return
    end

    autoFarmButtonLocked = true

    -- Une seule inversion
    autoFarmActive = not autoFarmActive

    -- Mise à jour visuelle
    setAutoFarmVisual(autoFarmActive)

    -- Cooldown de 5 secondes
    task.delay(toggleCooldown, function()

        autoFarmButtonLocked = false

    end)

end)

--==================================================
-- 15. MOVEMENT SECTION
--==================================================

local moveSection =
    createSection("Movement", 150)

createSectionTitle(
    moveSection,
    "MOVEMENT"
)

--==================================================
-- WALKSPEED
--==================================================

local labelWS = Instance.new("TextLabel")

labelWS.Size =
    UDim2.new(0, 220, 0, 25)

labelWS.Position =
    UDim2.new(0, 14, 0, 34)

labelWS.BackgroundTransparency = 1

labelWS.Text =
    "WalkSpeed: 16"

labelWS.TextColor3 =
    COLORS.Text

labelWS.Font =
    Enum.Font.Gotham

labelWS.TextSize = 14

labelWS.TextXAlignment =
    Enum.TextXAlignment.Left

labelWS.Parent = moveSection

local sliderWS = Instance.new("Frame")

sliderWS.Size =
    UDim2.new(0, 270, 0, 6)

sliderWS.Position =
    UDim2.new(0.5, -135, 0, 68)

sliderWS.BackgroundColor3 =
    COLORS.Slider

sliderWS.BorderSizePixel = 0

sliderWS.Parent = moveSection

addCorner(sliderWS, 5)

local dotWS = Instance.new("Frame")

dotWS.Size =
    UDim2.new(0, 18, 0, 18)

dotWS.Position =
    UDim2.new(0, -1, 0.5, -9)

dotWS.BackgroundColor3 =
    COLORS.SliderBlue

dotWS.BorderSizePixel = 0

dotWS.Parent = sliderWS

addCorner(dotWS, 10)

--==================================================
-- JUMPPOWER
--==================================================

local labelJP = Instance.new("TextLabel")

labelJP.Size =
    UDim2.new(0, 220, 0, 25)

labelJP.Position =
    UDim2.new(0, 14, 0, 91)

labelJP.BackgroundTransparency = 1

labelJP.Text =
    "JumpPower: 50"

labelJP.TextColor3 =
    COLORS.Text

labelJP.Font =
    Enum.Font.Gotham

labelJP.TextSize = 14

labelJP.TextXAlignment =
    Enum.TextXAlignment.Left

labelJP.Parent = moveSection

local sliderJP = Instance.new("Frame")

sliderJP.Size =
    UDim2.new(0, 270, 0, 6)

sliderJP.Position =
    UDim2.new(0.5, -135, 0, 125)

sliderJP.BackgroundColor3 =
    COLORS.Slider

sliderJP.BorderSizePixel = 0

sliderJP.Parent = moveSection

addCorner(sliderJP, 5)

local dotJP = Instance.new("Frame")

dotJP.Size =
    UDim2.new(0, 18, 0, 18)

dotJP.Position =
    UDim2.new(0, -1, 0.5, -9)

dotJP.BackgroundColor3 =
    COLORS.SliderOrange

dotJP.BorderSizePixel = 0

dotJP.Parent = sliderJP

addCorner(dotJP, 10)

--==================================================
-- 16. MISC
--==================================================

local miscSection =
    createSection("Misc", 100)

createSectionTitle(
    miscSection,
    "MISC"
)

local btnAA, setAntiAfkVisual =
    createToggle(
        miscSection,
        "Anti-AFK",
        38
    )

--==================================================
-- ANTI-AFK CLICK
--==================================================

local antiAfkButtonLocked = false

btnAA.Activated:Connect(function()

    if antiAfkButtonLocked then
        return
    end

    antiAfkButtonLocked = true

    antiAfkActive = not antiAfkActive

    setAntiAfkVisual(
        antiAfkActive
    )

    task.delay(toggleCooldown, function()

        antiAfkButtonLocked = false

    end)

end)

--==================================================
-- 17. DRAG SYSTEM
--==================================================

local function makeDraggable(obj, target)

    target = target or obj

    local dragging = false

    local dragStart
    local startPosition

    obj.InputBegan:Connect(function(input)

        if input.UserInputType ==
            Enum.UserInputType.MouseButton1

            or input.UserInputType ==
            Enum.UserInputType.Touch then

            dragging = true

            dragStart =
                input.Position

            startPosition =
                target.Position

        end

    end)

    UserInputService.InputChanged:Connect(function(input)

        if not dragging then
            return
        end

        if input.UserInputType ==
            Enum.UserInputType.MouseMovement

            or input.UserInputType ==
            Enum.UserInputType.Touch then

            local delta =
                input.Position - dragStart

            target.Position =
                UDim2.new(
                    startPosition.X.Scale,
                    startPosition.X.Offset + delta.X,

                    startPosition.Y.Scale,
                    startPosition.Y.Offset + delta.Y
                )

        end

    end)

    UserInputService.InputEnded:Connect(function(input)

        if input.UserInputType ==
            Enum.UserInputType.MouseButton1

            or input.UserInputType ==
            Enum.UserInputType.Touch then

            dragging = false

        end

    end)

end

-- Menu déplaçable
makeDraggable(
    header,
    frame
)

-- Pierre déplaçable
makeDraggable(
    logo
)

--==================================================
-- 18. SLIDER SYSTEM
--==================================================

local function setupSlider(
    back,
    dot,
    min,
    max,
    callback
)

    local sliding = false

    local function update(input)

        local relative = math.clamp(

            (
                input.Position.X
                -
                back.AbsolutePosition.X
            )
            /
            back.AbsoluteSize.X,

            0,
            1
        )

        dot.Position =
            UDim2.new(
                relative,
                -9,
                0.5,
                -9
            )

        local value =
            math.floor(
                min +
                relative *
                (max - min)
            )

        callback(value)

    end

    back.InputBegan:Connect(function(input)

        if input.UserInputType ==
            Enum.UserInputType.MouseButton1

            or input.UserInputType ==
            Enum.UserInputType.Touch then

            sliding = true

            scroll.ScrollingEnabled =
                false

            update(input)

        end

    end)

    UserInputService.InputChanged:Connect(function(input)

        if sliding then

            if input.UserInputType ==
                Enum.UserInputType.MouseMovement

                or input.UserInputType ==
                Enum.UserInputType.Touch then

                update(input)

            end

        end

    end)

    UserInputService.InputEnded:Connect(function(input)

        if input.UserInputType ==
            Enum.UserInputType.MouseButton1

            or input.UserInputType ==
            Enum.UserInputType.Touch then

            sliding = false

            scroll.ScrollingEnabled =
                true

        end

    end)

end

--==================================================
-- WALKSPEED SLIDER
--==================================================

setupSlider(
    sliderWS,
    dotWS,
    16,
    250,

    function(value)

        walkSpeedValue = value

        labelWS.Text =
            "WalkSpeed: " .. value

    end
)

--==================================================
-- JUMPPOWER SLIDER
--==================================================

setupSlider(
    sliderJP,
    dotJP,
    50,
    350,

    function(value)

        jumpPowerValue = value

        labelJP.Text =
            "JumpPower: " .. value

    end
)

--==================================================
-- 19. OPEN / CLOSE MENU
--==================================================

logo.Activated:Connect(function()

    menuOpen = not menuOpen

    frame.Visible =
        menuOpen

end)

close.Activated:Connect(function()

    menuOpen = false

    frame.Visible = false

end)

--==================================================
-- 20. MOVEMENT LOOP
--==================================================

RunService.Stepped:Connect(function()

    pcall(function()

        local character =
            player.Character

        if not character then
            return
        end

        local humanoid =
            character:FindFirstChildOfClass(
                "Humanoid"
            )

        if humanoid then

            humanoid.WalkSpeed =
                walkSpeedValue

            humanoid.JumpPower =
                jumpPowerValue

        end

    end)

end)

--==================================================
-- 21. TELEPORT FUNCTION
--==================================================

local function teleportTo(position)

    pcall(function()

        local character =
            player.Character

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
-- 22. AUTO FARM LOOP
--==================================================

task.spawn(function()

    while true do

        if autoFarmActive then

            for _, point in ipairs(
                farmPoints
            ) do

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
-- 23. ANTI-AFK
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
