

-- 👑 MANT HUB V7 TEST

local Players = game:GetService("Players")

local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")

gui.Name = "MantHubTest"

gui.ResetOnSpawn = false

gui.Parent = player:WaitForChild("PlayerGui")

local title = Instance.new("TextLabel")

title.Size = UDim2.fromOffset(260, 100)

title.Position = UDim2.new(0.5, -130, 0.4, 0)

title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

title.TextColor3 = Color3.fromRGB(255, 210, 70)

title.TextScaled = true

title.Text = "👑 MANT HUB WERKT!"

title.Parent = gui

Instance.new("UICorner", title).CornerRadius =

    UDim.new(0, 15)
