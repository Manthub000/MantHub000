

-- 👑 MANT HUB V6 GOLD EDITION

-- Roblox Luau LocalScript

local Players = game:GetService("Players")

local RunService = game:GetService("RunService")

local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer

local playerGui = player:WaitForChild("PlayerGui")

-- Vervang 0 door je Roblox afbeeldings-ID

local BACKGROUND_ID = 0

local speed = 32

local speedOn = false

local autoChase = false

local autoPass = false

local running = true

local originalSpeed = nil

local lastUpdate = 0

-- Oud menu vervangen

local old = playerGui:FindFirstChild("MantGold")

if old then old:Destroy() end

-- MENU

local gui = Instance.new("ScreenGui")

gui.Name = "MantGold"

gui.ResetOnSpawn = false

gui.Parent = playerGui

local frame = Instance.new("Frame")

frame.Size = UDim2.fromOffset(280, 340)

frame.Position = UDim2.new(0.5, -140, 0.25, 0)

frame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)

frame.BorderSizePixel = 0

frame.Active = true

frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius =

    UDim.new(0, 14)

local border = Instance.new("UIStroke")

border.Color = Color3.fromRGB(255, 195, 65)

border.Thickness = 2

border.Parent = frame

-- GOUDEN ACHTERGROND

local background = Instance.new("ImageLabel")

background.Size = UDim2.fromScale(1, 1)

background.BackgroundTransparency = 1

background.Image = BACKGROUND_ID ~= 0

    and ("rbxassetid://" .. BACKGROUND_ID)

    or ""

background.ImageTransparency = 0.35

background.ScaleType = Enum.ScaleType.Crop

background.Parent = frame

Instance.new("UICorner", background).CornerRadius =

    UDim.new(0, 14)

local function makeButton(text, y)

    local button = Instance.new("TextButton")

    button.Size = UDim2.new(1, -24, 0, 42)

    button.Position = UDim2.fromOffset(12, y)

    button.BackgroundColor3 = Color3.fromRGB(35, 29, 16)

    button.TextColor3 = Color3.fromRGB(255, 210, 100)

    button.TextSize = 15

    button.Font = Enum.Font.GothamBold

    button.Text = text

    button.Parent = frame

    Instance.new("UICorner", button).CornerRadius =

        UDim.new(0, 9)

    local stroke = Instance.new("UIStroke")

    stroke.Color = Color3.fromRGB(185, 135, 50)

    stroke.Thickness = 1

    stroke.Parent = button

    return button

end

local title = Instance.new("TextLabel")

title.Size = UDim2.new(1, -50, 0, 55)

title.Position = UDim2.fromOffset(8, 0)

title.BackgroundTransparency = 1

title.Text = "👑 MANT HUB V6"

title.TextColor3 = Color3.fromRGB(255, 205, 80)

title.Font = Enum.Font.GothamBlack

title.TextSize = 22

title.Parent = frame

local close = Instance.new("TextButton")

close.Size = UDim2.fromOffset(30, 30)

close.Position = UDim2.new(1, -37, 0, 12)

close.Text = "X"

close.BackgroundColor3 = Color3.fromRGB(100, 35, 30)

close.TextColor3 = Color3.new(1, 1, 1)

close.Parent = frame

local chaseBtn = makeButton("🎯 AUTO CHASE: OFF", 66)

local passBtn = makeButton("💣 AUTO PASS ASSIST: OFF", 119)

local speedBtn = makeButton("⚡ SPEED 32: OFF", 172)

local status = Instance.new("TextLabel")

status.Size = UDim2.new(1, -24, 0, 60)

status.Position = UDim2.fromOffset(12, 231)

status.BackgroundTransparency = 1

status.TextColor3 = Color3.fromRGB(255, 215, 120)

status.TextSize = 14

status.TextWrapped = true

status.Font = Enum.Font.GothamBold

status.Text = "👑 MANT GOLD READY"

status.Parent = frame

local footer = Instance.new("TextLabel")

footer.Size = UDim2.new(1, 0, 0, 27)

footer.Position = UDim2.fromOffset(0, 304)

footer.BackgroundTransparency = 1

footer.TextColor3 = Color3.fromRGB(180, 145, 70)

footer.Text = "MANT HUB • GOLD EDITION"

footer.TextSize = 11

footer.Parent = frame

local function getHumanoid()

    local char = player.Character

    return char and char:FindFirstChildOfClass("Humanoid")

end

local function applySpeed()

    local hum = getHumanoid()

    if not hum then return end

    if speedOn then

        if originalSpeed == nil then

            originalSpeed = hum.WalkSpeed

        end

        hum.WalkSpeed = speed

    elseif originalSpeed ~= nil then

        hum.WalkSpeed = originalSpeed

        originalSpeed = nil

    end

end

local function nearest(root)

    local nearestRoot = nil

    local nearestName = nil

    local closest = 100

    for _, other in ipairs(Players:GetPlayers()) do

        if other ~= player and other.Character then

            local target =

                other.Character:FindFirstChild("HumanoidRootPart")

            local hum =

                other.Character:FindFirstChildOfClass("Humanoid")

            if target and hum and hum.Health > 0 then

                local distance =

                    (root.Position - target.Position).Magnitude

                if distance < closest then

                    closest = distance

                    nearestRoot = target

                    nearestName = other.DisplayName

                end

            end

        end

    end

    return nearestRoot, nearestName

end

local function setButton(button, enabled, name)

    button.Text = name .. (enabled and ": ON" or ": OFF")

    button.BackgroundColor3 = enabled

        and Color3.fromRGB(85, 65, 22)

        or Color3.fromRGB(35, 29, 16)

end

chaseBtn.MouseButton1Click:Connect(function()

    autoChase = not autoChase

    setButton(chaseBtn, autoChase, "🎯 AUTO CHASE")

end)

passBtn.MouseButton1Click:Connect(function()

    autoPass = not autoPass

    setButton(passBtn, autoPass, "💣 AUTO PASS ASSIST")

end)

speedBtn.MouseButton1Click:Connect(function()

    speedOn = not speedOn

    setButton(speedBtn, speedOn, "⚡ SPEED 32")

    applySpeed()

end)

-- AUTOMATISCHE ACHTERVOLGING

local heartbeat

heartbeat = RunService.Heartbeat:Connect(function()

    if not running then return end

    if os.clock() - lastUpdate < 0.25 then return end

    lastUpdate = os.clock()

    if speedOn then

        applySpeed()

    end

    if not autoChase and not autoPass then

        status.Text = "👑 MANT GOLD READY"

        return

    end

    local char = player.Character

    if not char then return end

    local root = char:FindFirstChild("HumanoidRootPart")

    local hum = getHumanoid()

    if not root or not hum or hum.Health <= 0 then

        return

    end

    local target, name = nearest(root)

    if target then

        hum:MoveTo(target.Position)

        status.Text = "🎯 Doelwit: " .. name

    else

        status.Text = "🔎 Geen speler dichtbij"

    end

end)

local respawnConnection =

    player.CharacterAdded:Connect(function()

        originalSpeed = nil

        task.wait(0.5)

        if running then applySpeed() end

    end)

-- MENU VERSLEPEN

local dragging = false

local dragInput

local dragStart

local startPos

title.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.Touch

        or input.UserInputType == Enum.UserInputType.MouseButton1 then

        dragging = true

        dragInput = input

        dragStart = input.Position

        startPos = frame.Position

    end

end)

local moveConnection =

    UIS.InputChanged:Connect(function(input)

        if dragging and

            (input == dragInput or

            input.UserInputType ==

                Enum.UserInputType.MouseMovement) then

            local delta = input.Position - dragStart

            frame.Position = UDim2.new(

                startPos.X.Scale,

                startPos.X.Offset + delta.X,

                startPos.Y.Scale,

                startPos.Y.Offset + delta.Y

            )

        end

    end)

local endConnection =

    UIS.InputEnded:Connect(function(input)

        if input == dragInput or

            input.UserInputType ==

                Enum.UserInputType.MouseButton1 then

            dragging = false

        end

    end)

close.MouseButton1Click:Connect(function()

    running = false

    speedOn = false

    applySpeed()

    heartbeat:Disconnect()

    respawnConnection:Disconnect()

    moveConnection:Disconnect()

    endConnection:Disconnect()

    gui:Destroy()

end)

