--==================================================
-- MINE ROCKS - PREMIUM UI / AUTOMATION
--==================================================

--==================================================
-- 1. SERVICES
--==================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
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

local COLORS = {
    Background = Color3.fromRGB(17, 17, 21),
    Panel = Color3.fromRGB(23, 23, 28),
    Section = Color3.fromRGB(30, 30, 36),
    SectionHover = Color3.fromRGB(35, 35, 42),

    Header = Color3.fromRGB(27, 27, 33),

    Text = Color3.fromRGB(248, 248, 250),
    Secondary = Color3.fromRGB(170, 170, 180),
    Muted = Color3.fromRGB(105, 105, 115),

    Accent = Color3.fromRGB(105, 190, 255),
    AccentDark = Color3.fromRGB(55, 125, 190),

    Green = Color3.fromRGB(65, 210, 105),
    GreenDark = Color3.fromRGB(35, 115, 62),

    Off = Color3.fromRGB(55, 55, 63),
    OffKnob = Color3.fromRGB(175, 175, 185),

    Red = Color3.fromRGB(215, 65, 65),

    Slider = Color3.fromRGB(52, 52, 61),
    Jump = Color3.fromRGB(255, 190, 90)
}

--==================================================
-- 7. UTILITY
--==================================================

local function corner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = parent
    return c
end

local function addStroke(parent, color, transparency, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color or Color3.new(1, 1, 1)
    s.Transparency = transparency or 0.7
    s.Thickness = thickness or 1
    s.Parent = parent
    return s
end

local function tween(object, time, properties)
    local info = TweenInfo.new(
        time,
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )

    local t = TweenService:Create(object, info, properties)
    t:Play()

    return t
end

--==================================================
-- 8. OPEN BUTTON SHADOW
--==================================================

local logoShadow = Instance.new("Frame")
logoShadow.Name = "OpenButtonShadow"
logoShadow.Size = UDim2.new(0, 66, 0, 66)
logoShadow.Position = UDim2.new(0, 19, 0, 151)
logoShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
logoShadow.BackgroundTransparency = 0.55
logoShadow.BorderSizePixel = 0
logoShadow.ZIndex = 1
logoShadow.Parent = screenGui

corner(logoShadow, 20)

--==================================================
-- 9. OPEN BUTTON
--==================================================

local logo = Instance.new("TextButton")
logo.Name = "OpenButton"
logo.Size = UDim2.new(0, 58, 0, 58)
logo.Position = UDim2.new(0, 23, 0, 155)
logo.BackgroundColor3 = Color3.fromRGB(38, 40, 48)
logo.BorderSizePixel = 0
logo.Text = "⚡"
logo.TextColor3 = Color3.fromRGB(225, 242, 255)
logo.TextSize = 31
logo.Font = Enum.Font.GothamBold
logo.AutoButtonColor = false
logo.ZIndex = 2
logo.Parent = screenGui

corner(logo, 17)

local logoStroke = addStroke(
    logo,
    COLORS.Accent,
    0.25,
    1.5
)

-- petit glow derrière l'éclair
local logoGlow = Instance.new("TextLabel")
logoGlow.Size = UDim2.new(1, 0, 1, 0)
logoGlow.Position = UDim2.new(0, 0, 0, 0)
logoGlow.BackgroundTransparency = 1
logoGlow.Text = "⚡"
logoGlow.TextColor3 = COLORS.Accent
logoGlow.TextTransparency = 0.75
logoGlow.TextSize = 34
logoGlow.Font = Enum.Font.GothamBold
logoGlow.ZIndex = 3
logoGlow.Parent = logo

local logoText = Instance.new("TextLabel")
logoText.Size = UDim2.new(1, 0, 1, 0)
logoText.Position = UDim2.new(0, 0, 0, 0)
logoText.BackgroundTransparency = 1
logoText.Text = "⚡"
logoText.TextColor3 = Color3.fromRGB(245, 250, 255)
logoText.TextSize = 30
logoText.Font = Enum.Font.GothamBold
logoText.ZIndex = 4
logoText.Parent = logo

--==================================================
-- 10. MAIN FRAME SHADOW
--==================================================

local shadow = Instance.new("Frame")
shadow.Name = "MainShadow"
shadow.Size = UDim2.new(0, 374, 0, 404)
shadow.Position = UDim2.new(0.5, -187, 0.5, -197)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.45
shadow.BorderSizePixel = 0
shadow.Visible = false
shadow.ZIndex = 1
shadow.Parent = screenGui

corner(shadow, 21)

--==================================================
-- 11. MAIN FRAME
--==================================================

local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 360, 0, 390)
frame.Position = UDim2.new(0.5, -180, 0.5, -195)
frame.BackgroundColor3 = COLORS.Panel
frame.BorderSizePixel = 0
frame.Visible = false
frame.ClipsDescendants = true
frame.ZIndex = 5
frame.Parent = screenGui

corner(frame, 18)

addStroke(
    frame,
    Color3.fromRGB(85, 90, 105),
    0.55,
    1
)

--==================================================
-- 12. HEADER
--==================================================

local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 62)
header.BackgroundColor3 = COLORS.Header
header.BorderSizePixel = 0
header.ZIndex = 6
header.Parent = frame

corner(header, 18)

local headerBottom = Instance.new("Frame")
headerBottom.Size = UDim2.new(1, 0, 0, 20)
headerBottom.Position = UDim2.new(0, 0, 1, -20)
headerBottom.BackgroundColor3 = COLORS.Header
headerBottom.BorderSizePixel = 0
headerBottom.ZIndex = 6
headerBottom.Parent = header

-- petite ligne lumineuse
local headerLine = Instance.new("Frame")
headerLine.Size = UDim2.new(1, -32, 0, 1)
headerLine.Position = UDim2.new(0, 16, 1, -1)
headerLine.BackgroundColor3 = COLORS.Accent
headerLine.BackgroundTransparency = 0.65
headerLine.BorderSizePixel = 0
headerLine.ZIndex = 7
headerLine.Parent = header

--==================================================
-- 13. TITLE
--==================================================

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -100, 0, 28)
title.Position = UDim2.new(0, 18, 0, 7)
title.BackgroundTransparency = 1
title.Text = "Mine Rocks"
title.TextColor3 = COLORS.Text
title.Font = Enum.Font.GothamBold
title.TextSize = 19
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 7
title.Parent = header

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -100, 0, 16)
subtitle.Position = UDim2.new(0, 19, 0, 35)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Premium Design"
subtitle.TextColor3 = COLORS.Secondary
subtitle.Font = Enum.Font.GothamMedium
subtitle.TextSize = 9
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.ZIndex = 7
subtitle.Parent = header

--==================================================
-- 14. CLOSE BUTTON
--==================================================

local close = Instance.new("TextButton")
close.Name = "Close"
close.Size = UDim2.new(0, 34, 0, 34)
close.Position = UDim2.new(1, -47, 0, 14)
close.BackgroundColor3 = Color3.fromRGB(42, 42, 49)
close.BorderSizePixel = 0
close.Text = "×"
close.TextColor3 = COLORS.Secondary
close.TextSize = 22
close.Font = Enum.Font.GothamBold
close.AutoButtonColor = false
close.ZIndex = 8
close.Parent = header

corner(close, 11)

local closeStroke = addStroke(
    close,
    Color3.fromRGB(90, 90, 100),
    0.55,
    1
)

close.MouseEnter:Connect(function()
    tween(close, 0.15, {
        BackgroundColor3 = COLORS.Red,
        TextColor3 = Color3.new(1,1,1)
    })

    closeStroke.Transparency = 0.2
end)

close.MouseLeave:Connect(function()
    tween(close, 0.15, {
        BackgroundColor3 = Color3.fromRGB(42,42,49),
        TextColor3 = COLORS.Secondary
    })

    closeStroke.Transparency = 0.55
end)

--==================================================
-- 15. SCROLL
--==================================================

local scroll = Instance.new("ScrollingFrame")
scroll.Name = "Content"
scroll.Size = UDim2.new(1, -20, 1, -74)
scroll.Position = UDim2.new(0, 10, 0, 68)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 3
scroll.ScrollBarImageColor3 = COLORS.Accent
scroll.ScrollBarImageTransparency = 0.35
scroll.CanvasSize = UDim2.new(0, 0, 0, 430)
scroll.ZIndex = 6
scroll.Parent = frame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 10)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scroll

--==================================================
-- 16. SECTION CREATOR
--==================================================

local function createSection(name, height)

    local section = Instance.new("Frame")
    section.Name = name
    section.Size = UDim2.new(0, 320, 0, height)
    section.BackgroundColor3 = COLORS.Section
    section.BorderSizePixel = 0
    section.ZIndex = 7
    section.Parent = scroll

    corner(section, 14)

    addStroke(
        section,
        Color3.fromRGB(75, 78, 90),
        0.72,
        1
    )

    return section
end

--==================================================
-- 17. SECTION TITLE
--==================================================

local function createSectionTitle(parent, text)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 150, 0, 20)
    label.Position = UDim2.new(0, 14, 0, 8)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = COLORS.Secondary
    label.Font = Enum.Font.GothamBold
    label.TextSize = 10
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 8
    label.Parent = parent

    return label
end

--==================================================
-- 18. MODERN TOGGLE
--==================================================

local function createToggle(parent, text, y)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 170, 0, 34)
    label.Position = UDim2.new(0, 14, 0, y)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = COLORS.Text
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 8
    label.Parent = parent

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 76, 0, 32)
    button.Position = UDim2.new(1, -90, 0, y + 1)
    button.BackgroundColor3 = COLORS.Off
    button.BorderSizePixel = 0
    button.Text = ""
    button.AutoButtonColor = false
    button.ZIndex = 9
    button.Parent = parent

    corner(button, 16)

    local buttonStroke = addStroke(
        button,
        Color3.fromRGB(95, 95, 105),
        0.55,
        1
    )

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 24, 0, 24)
    knob.Position = UDim2.new(0, 4, 0.5, -12)
    knob.BackgroundColor3 = COLORS.OffKnob
    knob.BorderSizePixel = 0
    knob.ZIndex = 10
    knob.Parent = button

    corner(knob, 12)

    local knobStroke = addStroke(
        knob,
        Color3.fromRGB(220, 220, 225),
        0.65,
        1
    )

    local state = false

    local function setState(value)

        state = value

        if state then

            tween(button, 0.2, {
                BackgroundColor3 = COLORS.GreenDark
            })

            tween(knob, 0.2, {
                Position = UDim2.new(1, -28, 0.5, -12),
                BackgroundColor3 = COLORS.Green
            })

            buttonStroke.Color = COLORS.Green
            buttonStroke.Transparency = 0.25

            knobStroke.Color = Color3.fromRGB(150, 255, 175)
            knobStroke.Transparency = 0.25

        else

            tween(button, 0.2, {
                BackgroundColor3 = COLORS.Off
            })

            tween(knob, 0.2, {
                Position = UDim2.new(0, 4, 0.5, -12),
                BackgroundColor3 = COLORS.OffKnob
            })

            buttonStroke.Color = Color3.fromRGB(95, 95, 105)
            buttonStroke.Transparency = 0.55

            knobStroke.Color = Color3.fromRGB(220, 220, 225)
            knobStroke.Transparency = 0.65

        end
    end

    button.MouseEnter:Connect(function()

        if not state then
            tween(button, 0.12, {
                BackgroundColor3 = Color3.fromRGB(65,65,74)
            })
        end

    end)

    button.MouseLeave:Connect(function()

        if not state then
            tween(button, 0.12, {
                BackgroundColor3 = COLORS.Off
            })
        end

    end)

    button.Activated:Connect(function()
        setState(not state)
    end)

    return button, setState
end

--==================================================
-- 19. FARM
--==================================================

local farmSection = createSection("Farm", 85)

createSectionTitle(
    farmSection,
    "FARM"
)

local btnAF, setAutoFarmVisual = createToggle(
    farmSection,
    "Auto Farm",
    36
)

btnAF.Activated:Connect(function()

    autoFarmActive = not autoFarmActive

    setAutoFarmVisual(autoFarmActive)

end)

--==================================================
-- 20. MOVEMENT
--==================================================

local moveSection = createSection("Movement", 150)

createSectionTitle(
    moveSection,
    "MOVEMENT"
)

-- WALK SPEED

local labelWS = Instance.new("TextLabel")
labelWS.Size = UDim2.new(0, 220, 0, 25)
labelWS.Position = UDim2.new(0, 14, 0, 33)
labelWS.BackgroundTransparency = 1
labelWS.Text = "WalkSpeed: 16"
labelWS.TextColor3 = COLORS.Text
labelWS.Font = Enum.Font.GothamMedium
labelWS.TextSize = 14
labelWS.TextXAlignment = Enum.TextXAlignment.Left
labelWS.ZIndex = 8
labelWS.Parent = moveSection

local sliderWS = Instance.new("Frame")
sliderWS.Size = UDim2.new(0, 270, 0, 6)
sliderWS.Position = UDim2.new(0.5, -135, 0, 66)
sliderWS.BackgroundColor3 = COLORS.Slider
sliderWS.BorderSizePixel = 0
sliderWS.ZIndex = 8
sliderWS.Parent = moveSection

corner(sliderWS, 5)

local fillWS = Instance.new("Frame")
fillWS.Size = UDim2.new(0, 0, 1, 0)
fillWS.BackgroundColor3 = COLORS.Accent
fillWS.BorderSizePixel = 0
fillWS.ZIndex = 9
fillWS.Parent = sliderWS

corner(fillWS, 5)

local dotWS = Instance.new("Frame")
dotWS.Size = UDim2.new(0, 18, 0, 18)
dotWS.Position = UDim2.new(0, -1, 0.5, -9)
dotWS.BackgroundColor3 = Color3.fromRGB(235, 247, 255)
dotWS.BorderSizePixel = 0
dotWS.ZIndex = 10
dotWS.Parent = sliderWS

corner(dotWS, 10)

addStroke(
    dotWS,
    COLORS.Accent,
    0.2,
    1
)

-- JUMP POWER

local labelJP = Instance.new("TextLabel")
labelJP.Size = UDim2.new(0, 220, 0, 25)
labelJP.Position = UDim2.new(0, 14, 0, 91)
labelJP.BackgroundTransparency = 1
labelJP.Text = "JumpPower: 50"
labelJP.TextColor3 = COLORS.Text
labelJP.Font = Enum.Font.GothamMedium
labelJP.TextSize = 14
labelJP.TextXAlignment = Enum.TextXAlignment.Left
labelJP.ZIndex = 8
labelJP.Parent = moveSection

local sliderJP = Instance.new("Frame")
sliderJP.Size = UDim2.new(0, 270, 0, 6)
sliderJP.Position = UDim2.new(0.5, -135, 0, 124)
sliderJP.BackgroundColor3 = COLORS.Slider
sliderJP.BorderSizePixel = 0
sliderJP.ZIndex = 8
sliderJP.Parent = moveSection

corner(sliderJP, 5)

local fillJP = Instance.new("Frame")
fillJP.Size = UDim2.new(0, 0, 1, 0)
fillJP.BackgroundColor3 = COLORS.Jump
fillJP.BorderSizePixel = 0
fillJP.ZIndex = 9
fillJP.Parent = sliderJP

corner(fillJP, 5)

local dotJP = Instance.new("Frame")
dotJP.Size = UDim2.new(0, 18, 0, 18)
dotJP.Position = UDim2.new(0, -1, 0.5, -9)
dotJP.BackgroundColor3 = Color3.fromRGB(255, 245, 225)
dotJP.BorderSizePixel = 0
dotJP.ZIndex = 10
dotJP.Parent = sliderJP

corner(dotJP, 10)

addStroke(
    dotJP,
    COLORS.Jump,
    0.2,
    1
)

--==================================================
-- 21. MISC
--==================================================

local miscSection = createSection("Misc", 85)

createSectionTitle(
    miscSection,
    "MISC"
)

local btnAA, setAntiAfkVisual = createToggle(
    miscSection,
    "Anti-AFK",
    36
)

btnAA.Activated:Connect(function()

    antiAfkActive = not antiAfkActive

    setAntiAfkVisual(antiAfkActive)

end)

--==================================================
-- 22. DRAG SYSTEM
--==================================================

local function makeDraggable(obj, target, shadowObject)

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

            if shadowObject then

                shadowObject.Position = UDim2.new(
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

-- Header = déplace menu + ombre
makeDraggable(header, frame, shadow)

-- Bouton = déplace bouton + SON ombre
makeDraggable(logo, logo, logoShadow)

--==================================================
-- 23. SLIDER SYSTEM
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
-- 24. OPEN / CLOSE
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
-- 25. MOVEMENT
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
-- 26. TELEPORT
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
            root.CFrame = CFrame.new(position)
        end

    end)

end

--==================================================
-- 27. AUTO FARM LOOP
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
-- 28. ANTI-AFK
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
