

-- 👑 MANT HUB V7 GOLD EDITION

-- Mobiel menu

local Players = game:GetService("Players")

local RS = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

local remote = RS:WaitForChild("MantV7Event")

local hitboxOn = false

local showHitbox = false

local speedOn = false

local HITBOX_SIZE = 20

local gui = Instance.new("ScreenGui")

gui.Name = "MantHubV7"

gui.ResetOnSpawn = false

gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")

frame.Size = UDim2.fromOffset(275, 290)

frame.Position = UDim2.new(0.5, -137, 0.25, 0)

frame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)

frame.Active = true

frame.Draggable = true

frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius =

    UDim.new(0, 14)

local stroke = Instance.new("UIStroke")

stroke.Color = Color3.fromRGB(255, 200, 75)

stroke.Thickness = 2

stroke.Parent = frame

local title = Instance.new("TextLabel")

title.Size = UDim2.new(1, -45, 0, 45)

title.Position = UDim2.fromOffset(8, 4)

title.BackgroundTransparency = 1

title.Text = "👑 MANT HUB V7"

title.TextColor3 = Color3.fromRGB(255, 210, 90)

title.Font = Enum.Font.GothamBold

title.TextSize = 21

title.Parent = frame

local function button(text, y)

    local b = Instance.new("TextButton")

    b.Size = UDim2.new(1, -24, 0, 42)

    b.Position = UDim2.fromOffset(12, y)

    b.BackgroundColor3 = Color3.fromRGB(44, 36, 18)

    b.TextColor3 = Color3.fromRGB(255, 220, 130)

    b.Font = Enum.Font.GothamBold

    b.TextSize = 15

    b.Text = text

    b.Parent = frame

    Instance.new("UICorner", b).CornerRadius =

        UDim.new(0, 9)

    return b

end

local hitBtn = button("🎯 HITBOX: OFF", 55)

local showBtn = button("👀 SHOW HITBOX: OFF", 105)

local speedBtn = button("⚡ SPEED 32: OFF", 155)

local closeBtn = button("❌ CLOSE", 230)

local info = Instance.new("TextLabel")

info.Size = UDim2.new(1, -16, 0, 25)

info.Position = UDim2.fromOffset(8, 203)

info.BackgroundTransparency = 1

info.TextColor3 = Color3.fromRGB(245, 201, 80)

info.Text = "💛 Hitbox Size: 20 studs"

info.TextSize = 14

info.Parent = frame

local closeButton = Instance.new("TextButton")

closeButton.Size = UDim2.fromOffset(28, 28)

closeButton.Position = UDim2.new(1, -35, 0, 9)

closeButton.Text = "X"

closeButton.TextColor3 = Color3.new(1, 1, 1)

closeButton.BackgroundColor3 = Color3.fromRGB(120, 40, 40)

closeButton.Parent = frame

local visuals = {}

local function clearVisuals()

    for _, visual in pairs(visuals) do

        visual:Destroy()

    end

    table.clear(visuals)

end

local function updateVisuals()

    clearVisuals()

    if not showHitbox then return end

    for _, p in ipairs(Players:GetPlayers()) do

        if p ~= player and p.Character then

            local root =

                p.Character:FindFirstChild("HumanoidRootPart")

            if root then

                local sphere = Instance.new("SphereHandleAdornment")

                sphere.Name = "MantHitboxVisual"

                sphere.Adornee = root

                sphere.Size = Vector3.new(

                    HITBOX_SIZE,

                    HITBOX_SIZE,

                    HITBOX_SIZE

                )

                sphere.Color3 = Color3.fromRGB(255, 200, 50)

                sphere.Transparency = 0.8

                sphere.AlwaysOnTop = false

                sphere.ZIndex = 1

                sphere.Parent = gui

                visuals[p] = sphere

            end

        end

    end

end

hitBtn.MouseButton1Click:Connect(function()

    hitboxOn = not hitboxOn

    hitBtn.Text = hitboxOn

        and "🎯 HITBOX: ON"

        or "🎯 HITBOX: OFF"

    remote:FireServer("Hitbox", hitboxOn)

end)

showBtn.MouseButton1Click:Connect(function()

    showHitbox = not showHitbox

    showBtn.Text = showHitbox

        and "👀 SHOW HITBOX: ON"

        or "👀 SHOW HITBOX: OFF"

    updateVisuals()

end)

speedBtn.MouseButton1Click:Connect(function()

    speedOn = not speedOn

    speedBtn.Text = speedOn

        and "⚡ SPEED 32: ON"

        or "⚡ SPEED 32: OFF"

    remote:FireServer("Speed", speedOn)

end)

local connections = {}

table.insert(connections,

    Players.PlayerAdded:Connect(updateVisuals)

)

table.insert(connections,

    Players.PlayerRemoving:Connect(function()

        task.defer(updateVisuals)

    end)

)

table.insert(connections,

    player.CharacterAdded:Connect(function()

        task.wait(0.5)

        remote:FireServer("Hitbox", hitboxOn)

        remote:FireServer("Speed", speedOn)

    end)

)

local function close()

    remote:FireServer("Hitbox", false)

    remote:FireServer("Speed", false)

    clearVisuals()

    for _, c in ipairs(connections) do

        c:Disconnect()

    end

    gui:Destroy()

end

closeBtn.MouseButton1Click:Connect(close)

closeButton.MouseButton1Click:Connect(close)
