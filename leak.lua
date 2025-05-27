local TweenService = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WatchDogs"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local StatusFrame = Instance.new("Frame")
StatusFrame.Size = UDim2.new(0, 220, 0, 140)
StatusFrame.Position = UDim2.new(1, -230, 0, 0)
StatusFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
StatusFrame.BackgroundTransparency = 0.1
StatusFrame.Parent = ScreenGui

local StatusBorder = Instance.new("UIStroke")
StatusBorder.Color = Color3.fromRGB(0, 170, 255)
StatusBorder.Thickness = 1.5
StatusBorder.Transparency = 0.3
StatusBorder.Parent = StatusFrame

local StatusGradient = Instance.new("UIGradient")
StatusGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 15))
})
StatusGradient.Rotation = 45
StatusGradient.Parent = StatusFrame

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 10)
StatusCorner.Parent = StatusFrame

local StatusTitle = Instance.new("TextLabel")
StatusTitle.Size = UDim2.new(1, 0, 0, 30)
StatusTitle.Position = UDim2.new(0, 0, 0, 0)
StatusTitle.BackgroundTransparency = 1
StatusTitle.Text = "Leak Scan"
StatusTitle.TextColor3 = Color3.fromRGB(0, 200, 255)
StatusTitle.TextSize = 20
StatusTitle.Font = Enum.Font.GothamBlack
StatusTitle.TextXAlignment = Enum.TextXAlignment.Center
StatusTitle.Parent = StatusFrame

local MessageLabel = Instance.new("TextLabel")
MessageLabel.Size = UDim2.new(1, -20, 0, 60)
MessageLabel.Position = UDim2.new(0, 10, 0, 40)
MessageLabel.BackgroundTransparency = 1
MessageLabel.Text = "Due to high usage and script abuse, access now costs $5 Lifetime."
MessageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
MessageLabel.TextSize = 14
MessageLabel.Font = Enum.Font.Gotham
MessageLabel.TextWrapped = true
MessageLabel.TextXAlignment = Enum.TextXAlignment.Center
MessageLabel.TextYAlignment = Enum.TextYAlignment.Top
MessageLabel.Parent = StatusFrame

local LinkButton = Instance.new("TextButton")
LinkButton.Size = UDim2.new(1, -20, 0, 30)
LinkButton.Position = UDim2.new(0, 10, 0, 100)
LinkButton.BackgroundTransparency = 1
LinkButton.Text = "Buy at stalkie.net"
LinkButton.TextColor3 = Color3.fromRGB(0, 200, 255)
LinkButton.TextSize = 16
LinkButton.Font = Enum.Font.Gotham
LinkButton.TextXAlignment = Enum.TextXAlignment.Center
LinkButton.TextYAlignment = Enum.TextYAlignment.Center
LinkButton.AutoButtonColor = false
LinkButton.Parent = StatusFrame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -40, 0, 5)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = StatusFrame

LinkButton.MouseButton1Click:Connect(function()
    setclipboard("https://stalkie.net")
    TweenService:Create(LinkButton, TweenInfo.new(0.2), { TextColor3 = Color3.fromRGB(0, 255, 100) }):Play()
    task.delay(0.2, function()
        TweenService:Create(LinkButton, TweenInfo.new(1.8), { TextColor3 = Color3.fromRGB(0, 200, 255) }):Play()
    end)
end)

LinkButton.MouseEnter:Connect(function()
    TweenService:Create(LinkButton, TweenInfo.new(0.2), { TextColor3 = Color3.fromRGB(135, 206, 250) }):Play()
end)
LinkButton.MouseLeave:Connect(function()
    TweenService:Create(LinkButton, TweenInfo.new(0.2), { TextColor3 = Color3.fromRGB(0, 200, 255) }):Play()
end)

CloseButton.MouseButton1Click:Connect(function()
    local tweenInfo = TweenInfo.new(0.2)
    TweenService:Create(StatusFrame, tweenInfo, { BackgroundTransparency = 1 }):Play()
    TweenService:Create(StatusTitle, tweenInfo, { TextTransparency = 1 }):Play()
    TweenService:Create(MessageLabel, tweenInfo, { TextTransparency = 1 }):Play()
    TweenService:Create(LinkButton, tweenInfo, { TextTransparency = 1 }):Play()
    TweenService:Create(CloseButton, tweenInfo, { TextTransparency = 1 }):Play()
    TweenService:Create(StatusBorder, tweenInfo, { Transparency = 1 }):Play()
    task.delay(0.2, function()
        ScreenGui:Destroy()
    end)
end)

local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
TweenService:Create(StatusFrame, tweenInfo, { BackgroundTransparency = 0.1 }):Play()
TweenService:Create(StatusTitle, tweenInfo, { TextTransparency = 0 }):Play()
TweenService:Create(MessageLabel, tweenInfo, { TextTransparency = 0 }):Play()
TweenService:Create(LinkButton, tweenInfo, { TextTransparency = 0 }):Play()
TweenService:Create(CloseButton, tweenInfo, { TextTransparency = 0 }):Play()
TweenService:Create(StatusBorder, tweenInfo, { Transparency = 0.3 }):Play()
