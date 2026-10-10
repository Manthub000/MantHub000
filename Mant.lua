

-- MANT HUB (Emir) GOLD EDITION

-- LocalScript: StarterPlayerScripts

local Players = game:GetService("Players")

local Lighting = game:GetService("Lighting")

local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local pg = player:WaitForChild("PlayerGui")

local old = pg:FindFirstChild("MantHubEmir")

if old then old:Destroy() end

local GOLD = Color3.fromRGB(255, 205, 80)

local DARK = Color3.fromRGB(12, 12, 16)

local PANEL = Color3.fromRGB(35, 31, 25)

local speed = 32

local speedOn = false

local espOn = false

local brightOn = false

local autoTarget = nil

local running = true

local originalHumanoid = nil

local originalSpeed = nil

local visuals = {}

local connections = {}

local activeTrack = nil

-- Vul hier jouw toegestane Animation ID's in

local animationIds = {

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

local gui = Instance.new("ScreenGui")

gui.Name = "MantHubEmir"

gui.ResetOnSpawn = false

gui.Parent = pg

local function round(obj)

    local c = Instance.new("UICorner")

    c.CornerRadius = UDim.new(0, 9)

    c.Parent = obj

end

local function panel(size, pos)

    local f = Instance.new("Frame")

    f.Size = size

    f.Position = pos

    f.BackgroundColor3 = DARK

    f.BorderSizePixel = 0

    f.Active = true

    f.Parent = gui

    round(f)

    local border = Instance.new("UIStroke")

    border.Color = GOLD

    border.Thickness = 1.5

    border.Parent = f

    return f

end

local main = panel(

    UDim2.fromOffset(285, 370),

    UDim2.new(0.04, 0, 0.2, 0)

)

local quick = panel(

    UDim2.fromOffset(125, 320),

    UDim2.new(1, -135, 0.23, 0)

)

local function label(parent, value, size)

    local l = Instance.new("TextLabel")

    l.Size = UDim2.new(1, -12, 0, 37)

    l.BackgroundTransparency = 1

    l.Text = value

    l.TextColor3 = GOLD

    l.TextSize = size or 14

    l.Font = Enum.Font.GothamBold

    l.Parent = parent

    return l

end

local title = label(main, "MANT HUB (Emir)", 23)

title.Position = UDim2.fromOffset(6, 5)

local tabs = Instance.new("Frame")

tabs.Size = UDim2.new(1, -12, 0, 35)

tabs.Position = UDim2.fromOffset(6, 49)

tabs.BackgroundTransparency = 1

tabs.Parent = main

local tabsLayout = Instance.new("UIListLayout")

tabsLayout.FillDirection = Enum.FillDirection.Horizontal

tabsLayout.Padding = UDim.new(0, 3)

tabsLayout.Parent = tabs

local pages = {}

local function makePage(name)

    local page = Instance.new("ScrollingFrame")

    page.Size = UDim2.new(1, -16, 1, -130)

    page.Position = UDim2.fromOffset(8, 91)

    page.BackgroundTransparency = 1

    page.ScrollBarThickness = 3

    page.ScrollBarImageColor3 = GOLD

    page.CanvasSize = UDim2.fromOffset(0, 0)

    page.AutomaticCanvasSize = Enum.AutomaticSize.Y

    page.Visible = false

    page.Parent = main

    local layout = Instance.new("UIListLayout")

    layout.Padding = UDim.new(0, 6)

    layout.Parent = page

    pages[name] = page

    local tab = Instance.new("TextButton")

    tab.Size = UDim2.new(0.25, -3, 1, 0)

    tab.Text = name

    tab.TextSize = 10

    tab.Font = Enum.Font.GothamBold

    tab.BackgroundColor3 = PANEL

    tab.TextColor3 = GOLD

    tab.Parent = tabs

    round(tab)

    tab.MouseButton1Click:Connect(function()

        for _, p in pairs(pages) do

            p.Visible = false

        end

        page.Visible = true

    end)

    return page

end

local movePage = makePage("MOVE")

local visualPage = makePage("VISUAL")

local animPage = makePage("ANIMS")

local toolsPage = makePage("TOOLS")

movePage.Visible = true

local function button(parent, text, callback)

    local b = Instance.new("TextButton")

    b.Size = UDim2.new(1, -8, 0, 36)

    b.BackgroundColor3 = PANEL

    b.TextColor3 = GOLD

    b.TextSize = 12

    b.TextWrapped = true

    b.Font = Enum.Font.GothamBold

    b.Text = text

    b.Parent = parent

    round(b)

    b.MouseButton1Click:Connect(function()

        callback(b)

    end)

    return b

end

local status = label(main, "MANT READY", 12)

status.Position = UDim2.fromOffset(6, 330)

local function getParts()

    local char = player.Character

    local hum = char and

        char:FindFirstChildOfClass("Humanoid")

    local root = char and

        char:FindFirstChild("HumanoidRootPart")

    return char, hum, root

end

local function applySpeed()

    local _, hum = getParts()

    if not hum then return end

    if speedOn then

        if originalHumanoid ~= hum then

            originalHumanoid = hum

            originalSpeed = hum.WalkSpeed

        end

        hum.WalkSpeed = speed

    elseif originalHumanoid == hum

        and originalSpeed ~= nil then

        hum.WalkSpeed = originalSpeed

        originalSpeed = nil

    end

end

-- MOVE

button(movePage, "SPEED: OFF", function(b)

    speedOn = not speedOn

    b.Text = speedOn and "SPEED: ON" or "SPEED: OFF"

    applySpeed()

end)

button(movePage, "SPEED +", function(b)

    speed = math.min(100, speed + 4)

    b.Text = "SPEED + | " .. speed

    applySpeed()

end)

button(movePage, "SPEED -", function(b)

    speed = math.max(16, speed - 4)

    b.Text = "SPEED - | " .. speed

    applySpeed()

end)

-- TELEPORTS

local function teleport(name)

    local destination = workspace:FindFirstChild(name)

    local _, _, root = getParts()

    if not destination

        or not destination:IsA("BasePart") then

        status.Text = "Maak eerst " .. name

        return

    end

    if root then

        root.CFrame =

            destination.CFrame + Vector3.new(0, 4, 0)

    end

end

button(movePage, "TP DOWN", function()

    teleport("MantDown")

end)

button(movePage, "TP BAT", function()

    teleport("MantBat")

end)

button(movePage, "TP HOME", function()

    teleport("MantHome")

end)

-- VISUALS

local function clearESP()

    for _, item in ipairs(visuals) do

        item:Destroy()

    end

    table.clear(visuals)

end

local function refreshESP()

    clearESP()

    if not espOn then return end

    for _, other in ipairs(Players:GetPlayers()) do

        if other ~= player and other.Character then

            local h = Instance.new("Highlight")

            h.FillColor = GOLD

            h.OutlineColor = GOLD

            h.FillTransparency = 0.8

            h.Adornee = other.Character

            h.Parent = gui

            table.insert(visuals, h)

        end

    end

end

button(visualPage, "PLAYER ESP: OFF", function(b)

    espOn = not espOn

    b.Text = espOn

        and "PLAYER ESP: ON"

        or "PLAYER ESP: OFF"

    refreshESP()

end)

local oldBrightness = Lighting.Brightness

local oldClock = Lighting.ClockTime

button(visualPage, "FULLBRIGHT: OFF", function(b)

    brightOn = not brightOn

    b.Text = brightOn

        and "FULLBRIGHT: ON"

        or "FULLBRIGHT: OFF"

    Lighting.Brightness = brightOn

        and 3 or oldBrightness

    Lighting.ClockTime = brightOn

        and 14 or oldClock

end)

-- ANIMATIONS

local function playAnimation(name)

    local id = animationIds[name]

    if not id or id == "" then

        status.Text = "Animation ID nodig: " .. name

        return

    end

    local _, hum = getParts()

    if not hum then return end

    local animator = hum:FindFirstChildOfClass("Animator")

    if not animator then return end

    if activeTrack then

        activeTrack:Stop()

        activeTrack:Destroy()

    end

    local anim = Instance.new("Animation")

    anim.AnimationId = "rbxassetid://" .. id

    local ok, track = pcall(function()

        return animator:LoadAnimation(anim)

    end)

    anim:Destroy()

    if ok and track then

        activeTrack = track

        activeTrack:Play()

        status.Text = "Playing: " .. name

    else

        status.Text = "Animation kon niet laden"

    end

end

for _, name in ipairs({

    "Ninja", "Robot", "Zombie", "Levitation",

    "Superhero", "Stylish", "Vampire",

    "Bubbly", "Toy", "Cartoony"

}) do

    button(animPage, name, function()

        playAnimation(name)

    end)

end

button(animPage, "RESET ANIMATION", function()

    if activeTrack then

        activeTrack:Stop()

        activeTrack:Destroy()

        activeTrack = nil

    end

end)

-- TOOLS

button(toolsPage, "AUTO LEFT", function()

    status.Text = "MantLeft: marker nodig"

end)

button(toolsPage, "AUTO RIGHT", function()

    status.Text = "MantRight: marker nodig"

end)

button(toolsPage, "AUTO STEAL", function()

    status.Text = "Auto Steal: servercode nodig"

end)

-- QUICK PANEL

button(quick, "TP DOWN", function()

    teleport("MantDown")

end)

button(quick, "TP BAT", function()

    teleport("MantBat")

end)

button(quick, "SPEED 32", function()

    speed = 32

    speedOn = true

    applySpeed()

end)

button(quick, "PLAYER ESP", function()

    espOn = not espOn

    refreshESP()

end)

button(quick, "HIDE", function()

    main.Visible = false

    quick.Visible = false

end)

local reopen = Instance.new("TextButton")

reopen.Size = UDim2.fromOffset(125, 34)

reopen.Position = UDim2.fromOffset(10, 65)

reopen.BackgroundColor3 = DARK

reopen.TextColor3 = GOLD

reopen.Text = "👑 MANT (Emir)"

reopen.Font = Enum.Font.GothamBold

reopen.TextSize = 12

reopen.Parent = gui

round(reopen)

reopen.MouseButton1Click:Connect(function()

    main.Visible = not main.Visible

    quick.Visible = main.Visible

end)

-- Updates

table.insert(connections,

    player.CharacterAdded:Connect(function()

        originalHumanoid = nil

        originalSpeed = nil

        task.wait(0.5)

        if running then

            applySpeed()

            refreshESP()

        end

    end)

)

table.insert(connections,

    RunService.Heartbeat:Connect(function()

        if running and speedOn then

            applySpeed()

        end

    end)

)

-- CLEAN CLOSE

button(toolsPage, "CLOSE HUB", function()

    running = false

    speedOn = false

    applySpeed()

    clearESP()

    if activeTrack then

        activeTrack:Stop()

        activeTrack:Destroy()

    end

    Lighting.Brightness = oldBrightness

    Lighting.ClockTime = oldClock

    for _, c in ipairs(connections) do

        c:Disconnect()

    end

    gui:Destroy()

end)
