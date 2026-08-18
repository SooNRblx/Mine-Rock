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
-- 5. SCREEN GUI
--==================================================

local screenGui = Instance.new("ScreenGui")

screenGui.Name = "MagicEvolutionGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

screenGui.Parent = playerGui

--==================================================
-- 6. COLORS
--==================================================

local backgroundColor =
    Color3.fromRGB(17, 17, 21)

local panelColor =
    Color3.fromRGB(22, 22, 27)

local sectionColor =
    Color3.fromRGB(28, 28, 34)

local headerColor =
    Color3.fromRGB(24, 24, 29)

local textColor =
    Color3.fromRGB(245, 245, 248)

local secondaryText =
    Color3.fromRGB(155, 155, 165)

local mutedText =
    Color3.fromRGB(100, 100, 110)

local offColor =
    Color3.fromRGB(52, 52, 60)

local onColor =
    Color3.fromRGB(30, 105, 52)

local onBrightColor =
    Color3.fromRGB(75, 215, 105)

local redColor =
    Color3.fromRGB(190, 55, 55)

local blueColor =
    Color3.fromRGB(100, 180, 255)

local orangeColor =
    Color3.fromRGB(255, 200, 100)

--==================================================
-- 7. UTILITY
--==================================================

local function createCorner(parent, radius)

    local corner = Instance.new("UICorner")

    corner.CornerRadius =
        UDim.new(0, radius)

    corner.Parent = parent

    return corner

end

local function createStroke(parent, color, transparency)

    local stroke = Instance.new("UIStroke")

    stroke.Thickness = 1
    stroke.Color =
        color or Color3.fromRGB(255,255,255)

    stroke.Transparency =
        transparency or 0.5

    stroke.Parent = parent

    return stroke

end

--==================================================
-- 8. OPEN BUTTON
--==================================================

local logo = Instance.new("TextButton")

logo.Name = "OpenButton"

logo.Size =
    UDim2.new(0, 60, 0, 60)

logo.Position =
    UDim2.new(0, 20, 0, 150)

logo.BackgroundColor3 =
    Color3.fromRGB(32, 32, 38)

logo.Text = "◆"

logo.TextColor3 =
    Color3.fromRGB(210, 215, 225)

logo.TextSize = 28

logo.Font =
    Enum.Font.GothamBold

logo.AutoButtonColor = false

logo.BorderSizePixel = 0

logo.Parent = screenGui

createCorner(logo, 18)

createStroke(
    logo,
    Color3.fromRGB(100, 180, 255),
    0.45
)

-- petit reflet
local logoGradient = Instance.new("UIGradient")

logoGradient.Rotation = 135

logoGradient.Color = ColorSequence.new({

    ColorSequenceKeypoint.new(
        0,
        Color3.fromRGB(48, 48, 56)
    ),

    ColorSequenceKeypoint.new(
        1,
        Color3.fromRGB(25, 25, 30)
    )

})

logoGradient.Parent = logo

--==================================================
-- 9. MAIN FRAME
--==================================================

local frame = Instance.new("Frame")

frame.Name = "MainFrame"

frame.Size =
    UDim2.new(0, 360, 0, 380)

frame.Position =
    UDim2.new(0.5, -180, 0.5, -190)

frame.BackgroundColor3 =
    backgroundColor

frame.BorderSizePixel = 0

frame.Visible = false

frame.Parent = screenGui

createCorner(frame, 18)

createStroke(
    frame,
    Color3.fromRGB(75, 75, 88),
    0.35
)

--==================================================
-- 10. HEADER
--==================================================

local header = Instance.new("Frame")

header.Name = "Header"

header.Size =
    UDim2.new(1, 0, 0, 58)

header.Position =
    UDim2.new(0, 0, 0, 0)

header.BackgroundColor3 =
    headerColor

header.BorderSizePixel = 0

header.Parent = frame

createCorner(header, 18)

local headerBottom = Instance.new("Frame")

headerBottom.Size =
    UDim2.new(1, 0, 0, 20)

headerBottom.Position =
    UDim2.new(0, 0, 1, -20)

headerBottom.BackgroundColor3 =
    headerColor

headerBottom.BorderSizePixel = 0

headerBottom.Parent = header

--==================================================
-- 11. TITLE
--==================================================

local title = Instance.new("TextLabel")

title.Size =
    UDim2.new(0, 200, 0, 28)

title.Position =
    UDim2.new(0, 18, 0, 7)

title.BackgroundTransparency = 1

title.Text = "Mine Rocks"

title.TextColor3 =
    textColor

title.Font =
    Enum.Font.GothamBold

title.TextSize = 19

title.TextXAlignment =
    Enum.TextXAlignment.Left

title.Parent = header

local subtitle = Instance.new("TextLabel")

subtitle.Size =
    UDim2.new(0, 200, 0, 16)

subtitle.Position =
    UDim2.new(0, 19, 0, 34)

subtitle.BackgroundTransparency = 1

subtitle.Text = "Premium Design"

subtitle.TextColor3 =
    secondaryText

subtitle.Font =
    Enum.Font.Gotham

subtitle.TextSize = 9

subtitle.TextXAlignment =
    Enum.TextXAlignment.Left

subtitle.Parent = header

--==================================================
-- 12. CLOSE BUTTON
--==================================================

local close = Instance.new("TextButton")

close.Size =
    UDim2.new(0, 32, 0, 32)

close.Position =
    UDim2.new(1, -44, 0, 12)

close.Text = "×"

close.TextColor3 =
    Color3.fromRGB(255,255,255)

close.TextSize = 22

close.Font =
    Enum.Font.GothamBold

close.BackgroundColor3 =
    redColor

close.AutoButtonColor = false

close.BorderSizePixel = 0

close.Parent = header

createCorner(close, 10)

--==================================================
-- 13. SCROLL
--==================================================

local scroll = Instance.new("ScrollingFrame")

scroll.Name = "Content"

scroll.Size =
    UDim2.new(1, -20, 1, -72)

scroll.Position =
    UDim2.new(0, 10, 0, 62)

scroll.BackgroundTransparency = 1

scroll.BorderSizePixel = 0

scroll.ScrollBarThickness = 3

scroll.ScrollBarImageColor3 =
    Color3.fromRGB(100,100,110)

scroll.ScrollBarImageTransparency = 0.35

scroll.CanvasSize =
    UDim2.new(0, 0, 0, 470)

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
-- 14. SECTION CREATOR
--==================================================

local function createSection(name, height)

    local section = Instance.new("Frame")

    section.Name = name

    section.Size =
        UDim2.new(0, 320, 0, height)

    section.BackgroundColor3 =
        sectionColor

    section.BorderSizePixel = 0

    section.Parent = scroll

    createCorner(section, 14)

    createStroke(
        section,
        Color3.fromRGB(70,70,82),
        0.72
    )

    return section

end

local function createSectionTitle(parent, text)

    local label = Instance.new("TextLabel")

    label.Size =
        UDim2.new(0, 150, 0, 20)

    label.Position =
        UDim2.new(0, 14, 0, 8)

    label.BackgroundTransparency = 1

    label.Text = text

    label.TextColor3 =
        secondaryText

    label.Font =
        Enum.Font.GothamBold

    label.TextSize = 10

    label.TextXAlignment =
        Enum.TextXAlignment.Left

    label.Parent = parent

    return label

end

--==================================================
-- 15. TOGGLE CREATOR
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
        textColor

    label.Font =
        Enum.Font.GothamMedium

    label.TextSize = 15

    label.TextXAlignment =
        Enum.TextXAlignment.Left

    label.Parent = parent

    -- BUTTON

    local button = Instance.new("TextButton")

    button.Size =
        UDim2.new(0, 82, 0, 32)

    button.Position =
        UDim2.new(1, -96, 0, y + 1)

    button.Text = ""

    button.TextColor3 =
        Color3.fromRGB(255,255,255)

    button.BackgroundColor3 =
        offColor

    button.AutoButtonColor = false

    button.BorderSizePixel = 0

    button.Parent = parent

    createCorner(button, 16)

    local buttonStroke =
        createStroke(
            button,
            Color3.fromRGB(95,95,105),
            0.45
        )

    -- TEXTE ON/OFF

    local stateLabel = Instance.new("TextLabel")

    stateLabel.Size =
        UDim2.new(0, 42, 1, 0)

    stateLabel.Position =
        UDim2.new(0, 5, 0, 0)

    stateLabel.BackgroundTransparency = 1

    stateLabel.Text = "OFF"

    stateLabel.TextColor3 =
        Color3.fromRGB(205,205,215)

    stateLabel.Font =
        Enum.Font.GothamBold

    stateLabel.TextSize = 10

    stateLabel.TextXAlignment =
        Enum.TextXAlignment.Center

    stateLabel.ZIndex = 2

    stateLabel.Parent = button

    -- PETIT ROND

    local knob = Instance.new("Frame")

    knob.Size =
        UDim2.new(0, 22, 0, 22)

    knob.Position =
        UDim2.new(0, 5, 0.5, -11)

    knob.BackgroundColor3 =
        Color3.fromRGB(175,175,185)

    knob.BorderSizePixel = 0

    knob.ZIndex = 3

    knob.Parent = button

    createCorner(knob, 11)

    createStroke(
        knob,
        Color3.fromRGB(235,235,240),
        0.35
    )

    -- UPDATE VISUEL

    local function updateVisual(state)

        if state then

            button.BackgroundColor3 =
                onColor

            buttonStroke.Color =
                onBrightColor

            buttonStroke.Transparency =
                0.35

            stateLabel.Text =
                "ON"

            stateLabel.TextColor3 =
                Color3.fromRGB(235,255,240)

            knob.BackgroundColor3 =
                onBrightColor

            knob.Position =
                UDim2.new(
                    1,
                    -27,
                    0.5,
                    -11
                )

        else

            button.BackgroundColor3 =
                offColor

            buttonStroke.Color =
                Color3.fromRGB(95,95,105)

            buttonStroke.Transparency =
                0.45

            stateLabel.Text =
                "OFF"

            stateLabel.TextColor3 =
                Color3.fromRGB(205,205,215)

            knob.BackgroundColor3 =
                Color3.fromRGB(175,175,185)

            knob.Position =
                UDim2.new(
                    0,
                    5,
                    0.5,
                    -11
                )

        end

    end

    return button, updateVisual

end

--==================================================
-- 16. FARM
--==================================================

local farmSection =
    createSection("Farm", 85)

createSectionTitle(
    farmSection,
    "FARM"
)

local btnAF, setAutoFarmVisual =
    createToggle(
        farmSection,
        "Auto Farm",
        34
    )

--==================================================
-- 17. MOVEMENT
--==================================================

local moveSection =
    createSection("Movement", 150)

createSectionTitle(
    moveSection,
    "MOVEMENT"
)

-- WALKSPEED

local labelWS = Instance.new("TextLabel")

labelWS.Size =
    UDim2.new(0, 220, 0, 25)

labelWS.Position =
    UDim2.new(0, 14, 0, 34)

labelWS.BackgroundTransparency = 1

labelWS.Text =
    "WalkSpeed: 16"

labelWS.TextColor3 =
    textColor

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
    Color3.fromRGB(55,55,62)

sliderWS.BorderSizePixel = 0

sliderWS.Parent = moveSection

createCorner(sliderWS, 6)

local dotWS = Instance.new("Frame")

dotWS.Size =
    UDim2.new(0, 18, 0, 18)

dotWS.Position =
    UDim2.new(0, -1, 0.5, -9)

dotWS.BackgroundColor3 =
    blueColor

dotWS.BorderSizePixel = 0

dotWS.Parent = sliderWS

createCorner(dotWS, 10)

-- JUMPPOWER

local labelJP = Instance.new("TextLabel")

labelJP.Size =
    UDim2.new(0, 220, 0, 25)

labelJP.Position =
    UDim2.new(0, 14, 0, 91)

labelJP.BackgroundTransparency = 1

labelJP.Text =
    "JumpPower: 50"

labelJP.TextColor3 =
    textColor

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
    Color3.fromRGB(55,55,62)

sliderJP.BorderSizePixel = 0

sliderJP.Parent = moveSection

createCorner(sliderJP, 6)

local dotJP = Instance.new("Frame")

dotJP.Size =
    UDim2.new(0, 18, 0, 18)

dotJP.Position =
    UDim2.new(0, -1, 0.5, -9)

dotJP.BackgroundColor3 =
    orangeColor

dotJP.BorderSizePixel = 0

dotJP.Parent = sliderJP

createCorner(dotJP, 10)

--==================================================
-- 18. MISC
--==================================================

local miscSection =
    createSection("Misc", 85)

createSectionTitle(
    miscSection,
    "MISC"
)

local btnAA, setAntiAfkVisual =
    createToggle(
        miscSection,
        "Anti-AFK",
        34
    )

--==================================================
-- 19. DRAG SYSTEM
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
makeDraggable(header, frame)

-- Bouton pierre déplaçable
makeDraggable(logo)

--==================================================
-- 20. SLIDER SYSTEM
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

        local relative =
            math.clamp(
                (
                    input.Position.X
                    - back.AbsolutePosition.X
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
                min
                +
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

setupSlider(
    sliderWS,
    dotWS,
    16,
    250,

    function(value)

        walkSpeedValue =
            value

        labelWS.Text =
            "WalkSpeed: "
            .. value

    end
)

setupSlider(
    sliderJP,
    dotJP,
    50,
    350,

    function(value)

        jumpPowerValue =
            value

        labelJP.Text =
            "JumpPower: "
            .. value

    end
)

--==================================================
-- 21. OPEN / CLOSE
--==================================================

logo.Activated:Connect(function()

    frame.Visible =
        not frame.Visible

end)

close.Activated:Connect(function()

    frame.Visible = false

end)

--==================================================
-- 22. AUTO FARM BUTTON
--==================================================

btnAF.Activated:Connect(function()

    autoFarmActive =
        not autoFarmActive

    setAutoFarmVisual(
        autoFarmActive
    )

end)

--==================================================
-- 23. ANTI-AFK BUTTON
--==================================================

btnAA.Activated:Connect(function()

    antiAfkActive =
        not antiAfkActive

    setAntiAfkVisual(
        antiAfkActive
    )

end)

--==================================================
-- 24. MOVEMENT
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
-- 25. TELEPORT FUNCTION
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
-- 27. ANTI-AFK
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
