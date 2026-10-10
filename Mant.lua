

-- 👑 MANT HUB | ADAPT STYLE

-- Zwart-gouden mobiele GUI

-- Voor je eigen Roblox-game

local Players = game:GetService("Players")

local Lighting = game:GetService("Lighting")

local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer

local pg = player:WaitForChild("PlayerGui")

local old = pg:FindFirstChild("MantAdapt")

if old then old:Destroy() end

local speed = 32

local carrySpeed = 24

local fullbright = false

local highlighted = false

local highlights = {}

local savedBrightness = Lighting.Brightness

local savedClock = Lighting.ClockTime

local GOLD = Color3.fromRGB(255, 201, 75)

local BLACK = Color3.fromRGB(12, 12, 17)

local PANEL = Color3.fromRGB(25, 25, 32)

local gui = Instance.new("ScreenGui")

gui.Name = "MantAdapt"

gui.ResetOnSpawn = false

gui.Parent = pg

local function round(obj, amount)

    local corner = Instance.new("UICorner")

    corner.CornerRadius = UDim.new(0, amount)

    corner.Parent = obj

end

local function panel(parent, size, position)

    local f = Instance.new("Frame")

    f.Size = size

    f.Position = position

    f.BackgroundColor3 = BLACK

    f.Active = true

    f.Parent = parent

    round(f, 12)

    local border = Instance.new("UIStroke")

    border.Color = GOLD

    border.Thickness = 1.5

    border.Parent = f

    return f

end

local main = panel(

    gui,

    UDim2.fromOffset(300, 365),

    UDim2.new(0.04, 0, 0.22, 0)

)

local title = Instance.new("TextLabel")

title.Size = UDim2.new(1, -45, 0, 70)

title.BackgroundTransparency = 1

title.Text = "MANT"

title.TextSize = 47

title.Font = Enum.Font.GothamBlack

title.TextColor3 = GOLD

title.Parent = main

local function button(parent, name, y, callback)

    local b = Instance.new("TextButton")

    b.Size = UDim2.new(1, -20, 0, 36)

    b.Position = UDim2.fromOffset(10, y)

    b.Text = name

    b.TextSize = 13

    b.Font = Enum.Font.GothamBold

    b.TextColor3 = GOLD

    b.BackgroundColor3 = PANEL

    b.Parent = parent

    round(b, 8)

    b.MouseButton1Click:Connect(function()

        callback(b)

    end)

    return b

end

local function humanoid()

    local char = player.Character

    return char and

        char:FindFirstChildOfClass("Humanoid")

end

local function applySpeed()

    local hum = humanoid()

    if hum then

        hum.WalkSpeed = speed

    end

end

local speedLabel = Instance.new("TextLabel")

speedLabel.Size = UDim2.new(1, 0, 0, 25)

speedLabel.Position = UDim2.fromOffset(0, 72)

speedLabel.BackgroundTransparency = 1

speedLabel.Text = "SPEED CONFIGURATION"

speedLabel.TextColor3 = GOLD

speedLabel.TextSize = 12

speedLabel.Parent = main

button(main, "NORMAL SPEED: 32", 105, function(b)

    speed = math.min(100, speed + 4)

    applySpeed()

    b.Text = "NORMAL SPEED: " .. speed

end)

button(main, "SPEED RESET", 147, function()

    speed = 16

    applySpeed()

end)

button(main, "CARRY SPEED: 24", 189, function(b)

    carrySpeed = math.min(100, carrySpeed + 4)

    b.Text = "CARRY SPEED: " .. carrySpeed

end)

button(main, "FULLBRIGHT: OFF", 231, function(b)

    fullbright = not fullbright

    b.Text = fullbright

        and "FULLBRIGHT: ON"

        or "FULLBRIGHT: OFF"

    Lighting.Brightness = fullbright

        and 3 or savedBrightness

    Lighting.ClockTime = fullbright

        and 14 or savedClock

end)

local status = Instance.new("TextLabel")

status.Size = UDim2.new(1, -16, 0, 32)

status.Position = UDim2.fromOffset(8, 275)

status.BackgroundTransparency = 1

status.TextColor3 = GOLD

status.TextSize = 12

status.Text = "👑 MANT HUB READY"

status.Parent = main

-- Snelknoppen rechts

local right = panel(

    gui,

    UDim2.fromOffset(130, 310),

    UDim2.new(1, -145, 0.25, 0)

)

local function notify(message)

    status.Text = message

end

button(right, "AUTO STEAL", 10, function()

    notify("Auto Steal: servercode nodig")

end)

button(right, "AUTO RIGHT", 54, function()

    notify("Auto Right: nog niet gekoppeld")

end)

button(right, "AUTO LEFT", 98, function()

    notify("Auto Left: nog niet gekoppeld")

end)

button(right, "PLAYER ESP", 142, function(b)

    highlighted = not highlighted

    b.Text = highlighted

        and "ESP: ON" or "PLAYER ESP"

    for _, h in ipairs(highlights) do

        h:Destroy()

    end

    table.clear(highlights)

    if highlighted then

        for _, p in ipairs(Players:GetPlayers()) do

            if p ~= player and p.Character then

                local h = Instance.new("Highlight")

                h.FillColor = GOLD

                h.OutlineColor = GOLD

                h.FillTransparency = 0.75

                h.Adornee = p.Character

                h.Parent = gui

                table.insert(highlights, h)

            end

        end

    end

end)

button(right, "SPEED 32", 186, function()

    speed = 32

    applySpeed()

    notify("Speed ingesteld op 32")

end)

button(right, "TP DOWN", 230, function()

    notify("TP Down: nog niet gekoppeld")

end)

button(right, "HIDE MENU", 274, function()

    main.Visible = false

    right.Visible = false

end)

-- Heropen-knop

local open = Instance.new("TextButton")

open.Size = UDim2.fromOffset(110, 35)

open.Position = UDim2.fromOffset(10, 80)

open.BackgroundColor3 = BLACK

open.TextColor3 = GOLD

open.Text = "👑 MANT"

open.Font = Enum.Font.GothamBold

open.Parent = gui

round(open, 9)

open.MouseButton1Click:Connect(function()

    main.Visible = not main.Visible

    right.Visible = main.Visible

end)

-- Versleepbaar op mobiel

local function draggable(f, handle)

    local dragging = false

    local start

    local origin

    handle.InputBegan:Connect(function(input)

        if input.UserInputType ==

            Enum.UserInputType.Touch or

            input.UserInputType ==

            Enum.UserInputType.MouseButton1 then

            dragging = true

            start = input.Position

            origin = f.Position

            local connection

            connection = input.Changed:Connect(function()

                if input.UserInputState ==

                    Enum.UserInputState.End then

                    dragging = false

                    connection:Disconnect()

                end

            end)

        end

    end)

    UIS.InputChanged:Connect(function(input)

        if dragging and (

            input.UserInputType ==

                Enum.UserInputType.Touch or

            input.UserInputType ==

                Enum.UserInputType.MouseMovement

        ) then

            local delta = input.Position - start

            f.Position = UDim2.new(

                origin.X.Scale,

                origin.X.Offset + delta.X,

                origin.Y.Scale,

                origin.Y.Offset + delta.Y

            )

        end

    end)

end

draggable(main, title)

draggable(right, right)

player.CharacterAdded:Connect(function()

    task.wait(0.5)

    applySpeed()

end)
