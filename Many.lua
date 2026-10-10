

-- 👑 MANT HUB V5

-- Speed 32 Menu

local Players = game:GetService("Players")

local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")

gui.Name = "MantHub"

gui.ResetOnSpawn = false

gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")

frame.Size = UDim2.fromOffset(260, 180)

frame.Position = UDim2.new(0.5, -130, 0.3, 0)

frame.BackgroundColor3 = Color3.fromRGB(25, 20, 40)

frame.Active = true

frame.Draggable = true

frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius =

    UDim.new(0, 15)

local title = Instance.new("TextLabel")

title.Size = UDim2.new(1, 0, 0, 55)

title.BackgroundTransparency = 1

title.Text = "👑 MANT HUB V5"

title.TextColor3 = Color3.fromRGB(200, 150, 255)

title.TextScaled = true

title.Font = Enum.Font.GothamBold

title.Parent = frame

local speedButton = Instance.new("TextButton")

speedButton.Size = UDim2.new(1, -20, 0, 50)

speedButton.Position = UDim2.fromOffset(10, 70)

speedButton.Text = "⚡ SPEED 32: OFF"

speedButton.Parent = frame

local active = false

speedButton.MouseButton1Click:Connect(function()

    active = not active

    local character = player.Character

    local humanoid = character and

        character:FindFirstChildOfClass("Humanoid")

    if humanoid then

        humanoid.WalkSpeed = active and 32 or 16

    end

    speedButton.Text = active

        and "⚡ SPEED 32: ON"

        or "⚡ SPEED 32: OFF"

end)
