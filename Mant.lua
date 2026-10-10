

-- MANT HUB (Emir) V10 GOLD EDITION

-- LocalScript voor je eigen Roblox-game

local Players = game:GetService("Players")

local RunService = game:GetService("RunService")

local Lighting = game:GetService("Lighting")

local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer

local pg = player:WaitForChild("PlayerGui")

local old = pg:FindFirstChild("MantEmirV10")

if old then old:Destroy() end

local GOLD = Color3.fromRGB(255, 205, 75)

local DARK = Color3.fromRGB(13, 13, 17)

local PANEL = Color3.fromRGB(38, 33, 23)

local speed = 32

local speedOn = false

local espOn = false

local namesOn = false

local brightOn = false

local autoDestination = nil

local running = true

local minimized = false

local oldBrightness = Lighting.Brightness

local oldClock = Lighting.ClockTime

local originalHumanoid = nil

local originalSpeed = nil

local activeTrack = nil

local visuals = {}

local connections = {}

-- Vul je eigen geldige animation-ID's in

local animations = {

    Ninja = "",

    Robot = "",

    Zombie = "",

    Levitation = "",

    Superhero = "",

    Stylish = "",

    Vampire = "",

    Bubbly = "",

    Toy = "",

    Cartoony = ""

}

local function getParts()

    local char = player.Character

    local hum = char and

        char:FindFirstChildOfClass("Humanoid")

    local root = char and

        char:FindFirstChild("HumanoidRootPart")

    return char, hum, root

end

local gui = Instance.new("ScreenGui")

gui.Name = "MantEmirV10"

gui.ResetOnSpawn = false

gui.DisplayOrder = 100

gui.Parent = pg

local function round(object, amount)

    local c = Instance.new("UICorner")

    c.CornerRadius = UDim.new(0, amount or 9)

    c.Parent = object

end

local function makePanel(size, position)

    local frame = Instance.new("Frame")

    frame.Size = size

    frame.Position = position

    frame.BackgroundColor3 = DARK

    frame.BorderSizePixel = 0

    frame.Active = true

    frame.Parent = gui

    round(frame, 13)

    local stroke = Instance.new("UIStroke")

    stroke.Color = GOLD

    stroke.Thickness = 2

    stroke.Parent = frame

    return frame

end

local main = makePanel(

    UDim2.fromOffset(270, 355),

    UDim2.new(0.03, 0, 0.19, 0)

)

local quick = makePanel(

    UDim2.fromOffset(125, 315),

    UDim2.new(1, -135, 0.22, 0)

)

local function text(parent, value, height, size)

    local label = Instance.new("TextLabel")

    label.Size = UDim2.new(1, -12, 0, height)

    label.BackgroundTransparency = 1

    label.Text = value

    label.TextColor3 = GOLD

    label.TextSize = size or 14

    label.Font = Enum.Font.GothamBold

    label.TextWrapped = true

    label.Parent = parent

    return label

end

local title = text(main, "MANT HUB", 50, 30)

title.Position = UDim2.fromOffset(6, 5)

title.Font = Enum.Font.GothamBlack

local author = text(main, "(Emir) GOLD EDITION", 23, 13)

author.Position = UDim2.fromOffset(6, 53)

local status = text(main, "👑 MANT READY", 33, 12)

status.Position = UDim2.fromOffset(6, 315)

local tabs = Instance.new("Frame")

tabs.Size = UDim2.new(1, -12, 0, 34)

tabs.Position = UDim2.fromOffset(6, 83)

tabs.BackgroundTransparency = 1

tabs.Parent = main

local tabLayout = Instance.new("UIListLayout")

tabLayout.FillDirection = Enum.FillDirection.Horizontal

tabLayout.Padding = UDim.new(0, 3)

tabLayout.Parent = tabs

local pages = {}

local selectedPage = nil

local function switchPage(page)

    selectedPage = page

    for _, p in pairs(pages) do

        p.Visible = p == page

    end

end

local function makePage(name)

    local page = Instance.new("ScrollingFrame")

    page.Size = UDim2.new(1, -16, 0, 185)

    page.Position = UDim2.fromOffset(8, 124)

    page.BackgroundTransparency = 1

    page.AutomaticCanvasSize = Enum.AutomaticSize.Y

    page.CanvasSize = UDim2.fromOffset(0, 0)

    page.ScrollBarThickness = 3

    page.ScrollBarImageColor3 = GOLD

    page.Visible = false

    page.Parent = main

    local layout = Instance.new("UIListLayout")

    layout.Padding = UDim.new(0, 6)

    layout.Parent = page

    pages[name] = page

    local tab = Instance.new("TextButton")

    tab.Size = UDim2.new(0.25, -3, 1, 0)

    tab.BackgroundColor3 = PANEL

    tab.TextColor3 = GOLD

    tab.TextSize = 10

    tab.Font = Enum.Font.GothamBold

    tab.Text = name

    tab.Parent = tabs

    round(tab, 6)

    tab.MouseButton1Click:Connect(function()

        switchPage(page)

    end)

    return page

end

local movement = makePage("MOVE")

local visual = makePage("VISUAL")

local animPage = makePage("ANIMS")

local tools = makePage("TOOLS")

switchPage(movement)

local function makeButton(parent, value, callback)

    local b = Instance.new("TextButton")

    b.Size = UDim2.new(1, -8, 0, 37)

    b.BackgroundColor3 = PANEL

    b.TextColor3 = GOLD

    b.Font = Enum.Font.GothamBold

    b.TextSize = 12

    b.TextWrapped = true

    b.Text = value

    b.Parent = parent

    round(b)

    b.MouseButton1Click:Connect(function()

        callback(b)

    end)

    return b

end

-- Snelknoppen rechts

local quickScroll = Instance.new("ScrollingFrame")

quickScroll.Size = UDim2.new(1, -12, 1, -12)

quickScroll.Position = UDim2.fromOffset(6, 6)

quickScroll.BackgroundTransparency = 1

quickScroll.ScrollBarThickness = 2

quickScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

quickScroll.CanvasSize = UDim2.fromOffset(0, 0)

quickScroll.Parent = quick

local quickLayout = Instance.new("UIListLayout")

quickLayout.Padding = UDim.new(0, 7)

quickLayout.Parent = quickScroll

local function applySpeed()

    local _, hum = getParts()

    if not hum then return end

    if speedOn then

        if originalHumanoid ~= hum then

            originalHumanoid = hum

            originalSpeed = hum.WalkSpeed

        end

        hum.WalkSpeed = speed

    elseif originalHumanoid == hum and originalSpeed then

        hum.WalkSpeed = originalSpeed

        originalSpeed = nil

    end

end

local function teleport(name)

    local destination = workspace:FindFirstChild(name, true)

    local _, _, root = getParts()

    if not destination or not destination:IsA("BasePart") then

        status.Text = "Missing: " .. name

        return

    end

    if root then

        root.CFrame = destination.CFrame +

            Vector3.new(0, 4, 0)

        status.Text = "TP: " .. name

    end

end

local function clearVisuals()

    for _, v in ipairs(visuals) do

        v:Destroy()

    end

    table.clear(visuals)

end

local function updateESP()

    clearVisuals()

    for _, other in ipairs(Players:GetPlayers()) do

        if other ~= player and other.Character then

            local char = other.Character

            local head = char:FindFirstChild("Head")

            if espOn then

                local highlight = Instance.new("Highlight")

                highlight.Adornee = char

                highlight.FillColor = GOLD

                highlight.OutlineColor = GOLD

                highlight.FillTransparency = 0.75

                highlight.Parent = gui

                table.insert(visuals, highlight)

            end

            if namesOn and head then

                local billboard = Instance.new("BillboardGui")

                billboard.Adornee = head

                billboard.Size = UDim2.fromOffset(155, 30)

                billboard.StudsOffset =

                    Vector3.new(0, 3, 0)

                billboard.AlwaysOnTop = true

                billboard.Parent = gui

                local name = text(

                    billboard,

                    other.DisplayName,

                    30, 14

                )

                name.Size = UDim2.fromScale(1, 1)

                table.insert(visuals, billboard)

            end

        end

    end

end

-- MOVE

makeButton(movement, "⚡ SPEED ON/OFF", function(b)

    speedOn = not speedOn

    b.Text = speedOn and "⚡ SPEED ON" or "⚡ SPEED OFF"

    applySpeed()

end)

makeButton(movement, "⚡ SPEED +", function(b)

    speed = math.min(100, speed + 4)

    b.Text = "⚡ SPEED: " .. speed

    applySpeed()

end)

makeButton(movement, "⚡ SPEED -", function(b)

    speed = math.max(16, speed - 4)

    b.Text = "⚡ SPEED: " .. speed

    applySpeed()

end)

makeButton(movement, "💨 DASH", function()

    local _, hum, root = getParts()

    if hum and root and hum.MoveDirection.Magnitude > 0 then

        root:ApplyImpulse(

            hum.MoveDirection * root.AssemblyMass * 55

        )

    end

end)

makeButton(movement, "🌍 TP DOWN", function()

    teleport("MantDown")

end)

makeButton(movement, "🏠 TP HOME", function()

    teleport("MantHome")

end)

-- VISUAL

makeButton(visual, "👀 PLAYER ESP", function(b)

    espOn = not espOn

    b.Text = "👀 ESP: " .. (espOn and "ON" or "OFF")

    updateESP()

end)

makeButton(visual, "🏷️ PLAYER NAMES", function(b)

    namesOn = not namesOn

    b.Text = "🏷️ NAMES: " ..

        (namesOn and "ON" or "OFF")

    updateESP()

end)

makeButton(visual, "💡 FULLBRIGHT", function(b)

    brightOn = not brightOn

    Lighting.Brightness =

        brightOn and 3 or oldBrightness

    Lighting.ClockTime =

        brightOn and 14 or oldClock

    b.Text = "💡 FULLBRIGHT: " ..

        (brightOn and "ON" or "OFF")

end)

local fpsText = text(visual, "FPS: --", 35, 15)

-- ANIMATIONS

local function playAnimation(name)

    local id = animations[name]

    if not id or id == "" then

        status.Text = name .. ": ID nodig"

        return

    end

    local _, hum = getParts()

    if not hum then return end

    local animator = hum:FindFirstChildOfClass("Animator")

    if not animator then return end

    if activeTrack then

        activeTrack:Stop()

        activeTrack:Destroy()

        activeTrack = nil

    end

    local animation = Instance.new("Animation")

    animation.AnimationId = "rbxassetid://" .. id

    local ok, result = pcall(function()

        return animator:LoadAnimation(animation)

    end)

    animation:Destroy()

    if ok then

        activeTrack = result

        activeTrack:Play()

        status.Text = "🎭 " .. name

    else

        status.Text = "Animation load failed"

    end

end

for _, name in ipairs({

    "Ninja", "Robot", "Zombie",

    "Levitation", "Superhero",

    "Stylish", "Vampire",

    "Bubbly", "Toy", "Cartoony"

}) do

    makeButton(animPage, "🎭 " .. name, function()

        playAnimation(name)

    end)

end

makeButton(animPage, "🔄 RESET", function()

    if activeTrack then

        activeTrack:Stop()

        activeTrack:Destroy()

        activeTrack = nil

    end

end)

-- TOOLS

local function setAuto(name)

    autoDestination =

        autoDestination == name and nil or name

    status.Text = autoDestination or "AUTO OFF"

end

makeButton(tools, "⬅️ AUTO LEFT", function()

    setAuto("MantLeft")

end)

makeButton(tools, "➡️ AUTO RIGHT", function()

    setAuto("MantRight")

end)

makeButton(tools, "⛔ STOP AUTO", function()

    autoDestination = nil

    status.Text = "AUTO STOPPED"

end)

makeButton(tools, "🧠 AUTO STEAL INFO", function()

    status.Text = "Game servercode nodig"

end)

-- QUICK BUTTONS

makeButton(quickScroll, "TP DOWN", function()

    teleport("MantDown")

end)

makeButton(quickScroll, "TP BAT", function()

    teleport("MantBat")

end)

makeButton(quickScroll, "AUTO LEFT", function()

    setAuto("MantLeft")

end)

makeButton(quickScroll, "AUTO RIGHT", function()

    setAuto("MantRight")

end)

makeButton(quickScroll, "SPEED 32", function()

    speed = 32

    speedOn = true

    applySpeed()

end)

makeButton(quickScroll, "PLAYER ESP", function()

    espOn = not espOn

    updateESP()

end)

-- HIDE / OPEN

local open = Instance.new("TextButton")

open.Size = UDim2.fromOffset(135, 36)

open.Position = UDim2.fromOffset(8, 70)

open.BackgroundColor3 = DARK

open.TextColor3 = GOLD

open.Text = "👑 MANT (Emir)"

open.Font = Enum.Font.GothamBold

open.Parent = gui

round(open)

local function setVisible(value)

    main.Visible = value

    quick.Visible = value

end

makeButton(quickScroll, "HIDE HUB", function()

    setVisible(false)

end)

open.MouseButton1Click:Connect(function()

    setVisible(not main.Visible)

end)

-- MINIMIZE

local mini = Instance.new("TextButton")

mini.Size = UDim2.fromOffset(25, 25)

mini.Position = UDim2.new(1, -33, 0, 10)

mini.Text = "−"

mini.TextColor3 = GOLD

mini.BackgroundColor3 = PANEL

mini.Parent = main

round(mini)

mini.MouseButton1Click:Connect(function()

    minimized = not minimized

    tabs.Visible = not minimized

    status.Visible = not minimized

    main.Size = minimized

        and UDim2.fromOffset(270, 80)

        or UDim2.fromOffset(270, 355)

    if minimized then

        for _, page in pairs(pages) do

            page.Visible = false

        end

    else

        switchPage(selectedPage)

    end

end)

-- VERSLEEPBAAR

local function makeDraggable(frame, handle)

    local dragging = false

    local inputStart

    local positionStart

    local activeInput

    local began = handle.InputBegan:Connect(function(input)

        if input.UserInputType ==

            Enum.UserInputType.Touch or

            input.UserInputType ==

            Enum.UserInputType.MouseButton1 then

            dragging = true

            activeInput = input

            inputStart = input.Position

            positionStart = frame.Position

        end

    end)

    local changed = UIS.InputChanged:Connect(function(input)

        if dragging and (

            input == activeInput or

            input.UserInputType ==

                Enum.UserInputType.MouseMovement

        ) then

            local delta = input.Position - inputStart

            frame.Position = UDim2.new(

                positionStart.X.Scale,

                positionStart.X.Offset + delta.X,

                positionStart.Y.Scale,

                positionStart.Y.Offset + delta.Y

            )

        end

    end)

    local ended = UIS.InputEnded:Connect(function(input)

        if input == activeInput then

            dragging = false

        end

    end)

    table.insert(connections, began)

    table.insert(connections, changed)

    table.insert(connections, ended)

end

makeDraggable(main, title)

-- UPDATES

local updateTime = 0

local frames = 0

local fpsTime = 0

table.insert(connections,

    RunService.Heartbeat:Connect(function(dt)

        if not running then return end

        frames += 1

        fpsTime += dt

        if fpsTime >= 1 then

            fpsText.Text = "📊 FPS: " ..

                math.floor(frames / fpsTime)

            frames = 0

            fpsTime = 0

        end

        if os.clock() - updateTime < 0.25 then

            return

        end

        updateTime = os.clock()

        if speedOn then

            applySpeed()

        end

        if autoDestination then

            local part = workspace:FindFirstChild(

                autoDestination, true

            )

            local _, hum = getParts()

            if part and part:IsA("BasePart") and hum then

                hum:MoveTo(part.Position)

            else

                status.Text = "Missing: " .. autoDestination

                autoDestination = nil

            end

        end

    end)

)

table.insert(connections,

    Players.PlayerAdded:Connect(function()

        if espOn or namesOn then

            task.defer(updateESP)

        end

    end)

)

table.insert(connections,

    Players.PlayerRemoving:Connect(function()

        if espOn or namesOn then

            task.defer(updateESP)

        end

    end)

)

table.insert(connections,

    player.CharacterAdded:Connect(function()

        originalHumanoid = nil

        originalSpeed = nil

        task.wait(0.5)

        if running then applySpeed() end

    end)

)

local function cleanup()

    if not running then return end

    running = false

    speedOn = false

    applySpeed()

    clearVisuals()

    if activeTrack then

        activeTrack:Stop()

        activeTrack:Destroy()

    end

    Lighting.Brightness = oldBrightness

    Lighting.ClockTime = oldClock

    for _, connection in ipairs(connections) do

        connection:Disconnect()

    end

end

gui.Destroying:Connect(cleanup)

makeButton(tools, "❌ CLOSE HUB", function()

    gui:Destroy()

end)
