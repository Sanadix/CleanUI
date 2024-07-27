local MACOSLibrary = {}
MACOSLibrary.__index = MACOSLibrary

function MACOSLibrary.new()
    local self = setmetatable({}, MACOSLibrary)
    self.Frame = Instance.new("Frame")
    self.Frame.BackgroundColor3 = Color3.new(1, 1, 1)
    self.Frame.BorderColor3 = Color3.new(0.8, 0.8, 0.8)
    self.Frame.Size = UDim2.new(0, 300, 0, 200)

    return self
end

function MACOSLibrary:addButton(text, callback)
    local Button = Instance.new("TextButton")
    Button.Parent = self.Frame
    Button.BackgroundColor3 = Color3.new(0.9, 0.9, 0.9)
    Button.BorderColor3 = Color3.new(0.8, 0.8, 0.8)
    Button.Size = UDim2.new(0, 100, 0, 30)
    Button.Position = UDim2.new(0, 10, 0, 10)
    Button.Text = text
    Button.Font = Enum.Font.SourceSans
    Button.FontSize = Enum.FontSize.Size14
    Button.TextColor3 = Color3.new(0, 0, 0)

    Button.MouseButton1Click:Connect(callback)

    return Button
end

function MACOSLibrary:addSlider(min, max, callback)
    local Slider = Instance.new("Frame")
    Slider.Parent = self.Frame
    Slider.BackgroundColor3 = Color3.new(0.9, 0.9, 0.9)
    Slider.BorderColor3 = Color3.new(0.8, 0.8, 0.8)
    Slider.Size = UDim2.new(0, 200, 0, 20)
    Slider.Position = UDim2.new(0, 10, 0, 50)

    local SliderBar = Instance.new("Frame")
    SliderBar.Parent = Slider
    SliderBar.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
    SliderBar.BorderColor3 = Color3.new(0.8, 0.8, 0.8)
    SliderBar.Size = UDim2.new(0, 0, 0, 20)
    SliderBar.Position = UDim2.new(0, 0, 0, 0)

    local SliderValue = Instance.new("TextLabel")
    SliderValue.Parent = Slider
    SliderValue.BackgroundColor3 = Color3.new(1, 1, 1)
    SliderValue.BorderColor3 = Color3.new(0.8, 0.8, 0.8)
    SliderValue.Size = UDim2.new(0, 50, 0, 20)
    SliderValue.Position = UDim2.new(0, 150, 0, 0)
    SliderValue.Font = Enum.Font.SourceSans
    SliderValue.FontSize = Enum.FontSize.Size14
    SliderValue.TextColor3 = Color3.new(0, 0, 0)

    local value = min
    SliderValue.Text = tostring(value)

    Slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mouseX = input.Position.X
            local sliderWidth = Slider.AbsoluteSize.X
            local sliderMinX = Slider.AbsolutePosition.X
            local sliderMaxX = sliderMinX + sliderWidth

            value = math.clamp((mouseX - sliderMinX) / sliderWidth * (max - min) + min, min, max)
            SliderValue.Text = tostring(math.floor(value))

            callback(value)
        end
    end)

    return Slider
end

function MACOSLibrary:addDropdown(options, callback)
    local Dropdown = Instance.new("Frame")
    Dropdown.Parent = self.Frame
    Dropdown.BackgroundColor3 = Color3.new(0.9, 0.9, 0.9)
    Dropdown.BorderColor3 = Color3.new(0.8, 0.8, 0.8)
    Dropdown.Size = UDim2.new(0, 150, 0, 30)
    Dropdown.Position = UDim2.new(0, 10, 0, 90)

    local DropdownButton = Instance.new("TextButton")
    DropdownButton.Parent = Dropdown
    DropdownButton.BackgroundColor3 = Color3.new(0.9, 0.9, 0.9)
    DropdownButton.BorderColor3 = Color3.new(0.8, 0.8, 0.8)
    DropdownButton.Size = UDim2.new(0, 150, 0, 30)
    DropdownButton.Text = options[1]
    DropdownButton.Font = Enum.Font.SourceSans
    DropdownButton.FontSize = Enum.FontSize.Size14
    DropdownButton.TextColor3 = Color3.new(0, 0, 0)

    local DropdownMenu = Instance.new("Frame")
    DropdownMenu.Parent = Dropdown
    DropdownMenu.BackgroundColor3 = Color3.new(1, 1, 1)
    DropdownMenu.BorderColor3 = Color3.new(0.8, 0.8, 0.8)
    DropdownMenu.Size = UDim2.new(0, 150, 0, #options * 30)
    DropdownMenu.Position = UDim2.new(0, 0, 0, 30)
    DropdownMenu.Visible = false

    for i, option in pairs(options) do
        local OptionButton = Instance.new("TextButton")
        OptionButton.Parent = DropdownMenu
        OptionButton.BackgroundColor3 = Color3.new(0.9, 0.9, 0.9)
        OptionButton.BorderColor3 = Color3.new(0.8, 0.8, 0.8)
        OptionButton.Size = UDim2.new(0, 150, 0, 30)
        OptionButton.Position = UDim2.new(0, 0, 0, (i - 1) * 30)
        OptionButton.Text = option
        OptionButton.Font = Enum.Font.SourceSans
        OptionButton.FontSize = Enum.FontSize.Size14
        OptionButton.TextColor3 = Color3.new(0, 0, 0)

        OptionButton.MouseButton1Click:Connect(function()
            DropdownButton.Text = option
            DropdownMenu.Visible = false
            callback(option)
        end)
    end

    DropdownButton.MouseButton1Click:Connect(function()
        DropdownMenu.Visible = not DropdownMenu.Visible
    end)

    return Dropdown
end

return MACOSLibrary
