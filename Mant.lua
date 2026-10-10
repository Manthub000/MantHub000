

-- 🎭 MANT HUB (Emir) ANIMATIONS

local Players = game:GetService("Players")

local player = Players.LocalPlayer

local packs = {

    "Ninja",

    "Robot",

    "Zombie",

    "Levitation",

    "Superhero",

    "Stylish",

    "Vampire",

    "Bubbly",

    "Toy",

    "Cartoony"

}

local animations = {}

-- Vul geldige, toegestane animation-ID's in

-- Bijvoorbeeld:

-- animations["Ninja"] = "rbxassetid://JOUW_ID"

local frame = Instance.new("ScrollingFrame")

frame.Name = "Animations"

frame.Size = UDim2.fromOffset(220, 300)

frame.Position = UDim2.new(0.5, -110, 0.2, 0)

frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

frame.ScrollBarThickness = 4

frame.AutomaticCanvasSize = Enum.AutomaticSize.Y

frame.CanvasSize = UDim2.fromOffset(0, 0)

frame.Parent = gui

local layout = Instance.new("UIListLayout")

layout.Padding = UDim.new(0, 5)

layout.Parent = frame

local activeTrack

local function playPack(name)

    local id = animations[name]

    if not id then

        warn("Geen Animation ID voor " .. name)

        return

    end

    local character = player.Character

    local humanoid = character and

        character:FindFirstChildOfClass("Humanoid")

    if not humanoid then return end

    local animator = humanoid:FindFirstChildOfClass("Animator")

    if not animator then return end

    if activeTrack then

        activeTrack:Stop()

        activeTrack:Destroy()

    end

    local animation = Instance.new("Animation")

    animation.AnimationId = id

    activeTrack = animator:LoadAnimation(animation)

    activeTrack:Play()

    animation:Destroy()

end

for _, name in ipairs(packs) do

    local button = Instance.new("TextButton")

    button.Size = UDim2.new(1, -10, 0, 36)

    button.BackgroundColor3 = Color3.fromRGB(45, 35, 18)

    button.TextColor3 = Color3.fromRGB(255, 210, 90)

    button.Text = "🎭 " .. name

    button.Font = Enum.Font.GothamBold

    button.TextSize = 14

    button.Parent = frame

    button.MouseButton1Click:Connect(function()

        playPack(name)

    end)

end

local reset = Instance.new("TextButton")

reset.Size = UDim2.new(1, -10, 0, 36)

reset.Text = "🔄 RESET ANIMATION"

reset.BackgroundColor3 = Color3.fromRGB(90, 35, 35)

reset.TextColor3 = Color3.new(1, 1, 1)

reset.Parent = frame

reset.MouseButton1Click:Connect(function()

    if activeTrack then

        activeTrack:Stop()

        activeTrack:Destroy()

        activeTrack = nil

    end

end)
