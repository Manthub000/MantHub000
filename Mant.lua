

-- 👑 MANT HUB V8 GOLD EDITION

-- Mobile GUI | Roblox Luau

local Players = game:GetService("Players")

local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("MantHubV8")

if old then old:Destroy() end

local chase = false

local passAssist = false

local speedOn = false

local showHitbox = false

local speed = 32

local lastUpdate = 0

local connections = {}

local visuals = {}

-- GUI

local gui = Instance.new("ScreenGui")

gui.Name = "MantHubV8"

gui.ResetOnSpawn = false

gui.Parent = playerGui

local frame = Instance.new("Frame")

frame.Size = UDim2.fromOffset(280, 345)

frame.Position = UDim2.new(0.5, -140, 0.3, 0)

frame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)

frame.Active = true

frame.Draggable = true

frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius =

    UDim.new(0, 14)

local border = Instance.new("UIStroke")

border.Color = Color3.fromRGB(255, 205, 80)

border.Thickness = 2

border.Parent = frame

local function makeButton(text, y)

    local b = Instance.new("TextButton")

    b.Size = UDim2.new(1, -24, 0, 42)

    b.Position = UDim2.fromOffset(12, y)

    b.BackgroundColor3 = Color3.fromRGB(45, 35, 17)

    b.TextColor3 = Color3.fromRGB(255, 210, 90)

    b.Font = Enum.Font.GothamBold

    b.TextSize = 15

    b.Text = text

    b.Parent = frame

    Instance.new("UICorner", b).CornerRadius =

        UDim.new(0, 9)

    return b

end

local title = Instance.new("TextLabel")

title.Size = UDim2.new(1, 0, 0, 50)

title.BackgroundTransparency = 1

title.Text = "👑 MANT HUB V8"

title.TextColor3 = Color3.fromRGB(255, 210, 80)

title.Font = Enum.Font.GothamBlack

title.TextSize = 22

title.Parent = frame

local chaseBtn = makeButton("🎯 AUTO CHASE: OFF", 55)

local passBtn = makeButton("💣 AUTO PASS ASSIST: OFF", 105)

local speedBtn = makeButton("⚡ SPEED 32: OFF", 155)

local hitBtn = makeButton("👀 SHOW HITBOX: OFF", 205)

local closeBtn = makeButton("❌ CLOSE", 285)

local status = Instance.new("TextLabel")

status.Size = UDim2.new(1, -20, 0, 28)

status.Position = UDim2.fromOffset(10, 252)

status.BackgroundTransparency = 1

status.TextColor3 = Color3.fromRGB(255, 210, 90)

status.TextSize = 13

status.Text = "👑 MANT HUB READY"

status.Parent = frame

local function getHumanoid(p)

    local char = p.Character

    if not char then return nil end

    local hum = char:FindFirstChildOfClass("Humanoid")

    local root = char:FindFirstChild("HumanoidRootPart")

    if hum and root and hum.Health > 0 then

        return hum, root

    end

end

local originalHumanoid = nil

local originalSpeed = nil

local function applySpeed()

    local hum = getHumanoid(player)

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

        originalHumanoid = nil

        originalSpeed = nil

    end

end

local function nearestPlayer(root)

    local closestRoot = nil

    local closestName = nil

    local shortest = 100

    for _, other in ipairs(Players:GetPlayers()) do

        if other ~= player then

            local hum, target = getHumanoid(other)

            if hum and target then

                local distance =

                    (root.Position - target.Position).Magnitude

                if distance < shortest then

                    shortest = distance

                    closestRoot = target

                    closestName = other.DisplayName

                end

            end

        end

    end

    return closestRoot, closestName

end

local function clearVisuals()

    for _, visual in ipairs(visuals) do

        visual:Destroy()

    end

    table.clear(visuals)

end

local function updateVisuals()

    clearVisuals()

    if not showHitbox then return end

    for _, other in ipairs(Players:GetPlayers()) do

        if other ~= player then

            local hum, root = getHumanoid(other)

            if hum and root then

                local sphere =

                    Instance.new("SphereHandleAdornment")

                sphere.Adornee = root

                sphere.Size = Vector3.new(6, 6, 6)

                sphere.Color3 =

                    Color3.fromRGB(255, 200, 50)

                sphere.Transparency = 0.7

                sphere.AlwaysOnTop = false

                sphere.Parent = gui

                table.insert(visuals, sphere)

            end

        end

    end

end

local function toggleButton(button, enabled, text)

    button.Text = text .. (enabled and ": ON" or ": OFF")

    button.BackgroundColor3 = enabled

        and Color3.fromRGB(105, 75, 25)

        or Color3.fromRGB(45, 35, 17)

end

chaseBtn.MouseButton1Click:Connect(function()

    chase = not chase

    toggleButton(chaseBtn, chase, "🎯 AUTO CHASE")

end)

passBtn.MouseButton1Click:Connect(function()

    passAssist = not passAssist

    toggleButton(passBtn, passAssist, "💣 AUTO PASS ASSIST")

end)

speedBtn.MouseButton1Click:Connect(function()

    speedOn = not speedOn

    toggleButton(speedBtn, speedOn, "⚡ SPEED 32")

    applySpeed()

end)

hitBtn.MouseButton1Click:Connect(function()

    showHitbox = not showHitbox

    toggleButton(hitBtn, showHitbox, "👀 SHOW HITBOX")

    updateVisuals()

end)

table.insert(connections,

    RunService.Heartbeat:Connect(function()

        if os.clock() - lastUpdate < 0.3 then return end

        lastUpdate = os.clock()

        if speedOn then

            applySpeed()

        end

        if not chase and not passAssist then

            status.Text = "👑 MANT HUB READY"

            return

        end

        local hum, root = getHumanoid(player)

        if not hum then return end

        local target, name = nearestPlayer(root)

        if target then

            hum:MoveTo(target.Position)

            status.Text = "🎯 Target: " .. name

        else

            status.Text = "🔎 Geen speler dichtbij"

        end

    end)

)

table.insert(connections,

    player.CharacterAdded:Connect(function()

        originalHumanoid = nil

        originalSpeed = nil

        task.wait(0.5)

        if gui.Parent then applySpeed() end

    end)

)

closeBtn.MouseButton1Click:Connect(function()

    speedOn = false

    applySpeed()

    clearVisuals()

    for _, connection in ipairs(connections) do

        connection:Disconnect()

    end

    gui:Destroy()

end)
