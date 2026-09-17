--!strict
--[[
    antigravttyUI.lua (NovaGlass Remake - Device-Aware Adaptive Scaling)
    - Automatically detects user device (Phone, Tablet, Desktop, Console)
    - Dynamically scales GUI via UIScale to perfectly fit the user's specific screen
    - Auto-adapts to mobile screen orientation changes (portrait <-> landscape)
    - Strict boundary clamping preventing the GUI from ever going above the screen
    - Enlarged high-contrast typography for optimal readability across all displays
    - Layout protection preventing slider and toggle controls from overlapping text
    - 100% compatibility with all original methods, props, and callbacks
]]--

local Library = {}
Library.__index = Library

Library.Assets = {
    Shadow          = "rbxassetid://1316045217",
    Minimize        = "rbxassetid://13857987062",
    Hide            = "rbxassetid://99432006374500",
    Close           = "rbxassetid://15082305656",
    Resize          = "rbxassetid://15082210525",
    Chevron         = "rbxassetid://14937709869",
    Arrow           = "rbxassetid://14923748517",
    Button          = "rbxassetid://89839278613299",
    ButtonIcon      = "rbxassetid://89839278613299",
    Search          = "rbxassetid://13847222481",
    Textbox         = "rbxassetid://13868675087",
    GlowDot         = "rbxassetid://105506802034513",
    ImageLogo       = "rbxassetid://111362591084511",
    FloatingToggle  = "rbxassetid://89839278613299",
    Discord         = "rbxassetid://119690296342461",
    Theme           = "rbxassetid://10734950309",
    Home            = "rbxassetid://10723405374",
    User            = "rbxassetid://10747373176",
    Key             = "rbxassetid://10709790644",
    Clock           = "rbxassetid://10709791437",
    Check           = "rbxassetid://10709790644",
    Globe           = "rbxassetid://10734887376",
    Chat            = "rbxassetid://10734887852",
    Gear            = "rbxassetid://10734950309",
    Sliders         = "rbxassetid://10734950020",
    Terminal        = "rbxassetid://10734951847",
    Background      = "rbxassetid://82941526973068",
    AutoHubBg       = "rbxassetid://82941526973068",
    AutoHubIcon     = "autohub_icon.png",
}

Library.Themes = {
    CyberNeon = {
        Background    = Color3.fromRGB(13, 14, 21),
        Sidebar       = Color3.fromRGB(10, 11, 17),
        Surface       = Color3.fromRGB(20, 22, 33),
        SurfaceHover  = Color3.fromRGB(27, 30, 45),
        Stroke        = Color3.fromRGB(168, 85, 247),
        StrokeSoft    = Color3.fromRGB(40, 44, 65),
        Text          = Color3.fromRGB(245, 247, 250),
        Muted         = Color3.fromRGB(145, 155, 175),
        Accent        = Color3.fromRGB(168, 85, 247),
        AccentHover   = Color3.fromRGB(192, 132, 252),
        AccentSoft    = Color3.fromRGB(38, 24, 58),
        Success       = Color3.fromRGB(34, 197, 94),
        Warning       = Color3.fromRGB(245, 158, 11),
        Danger        = Color3.fromRGB(239, 68, 68),
    },
    SkyBlue = {
        Background    = Color3.fromRGB(11, 17, 28),
        Sidebar       = Color3.fromRGB(9, 13, 22),
        Surface       = Color3.fromRGB(17, 27, 44),
        SurfaceHover  = Color3.fromRGB(24, 38, 62),
        Stroke        = Color3.fromRGB(14, 165, 233),
        StrokeSoft    = Color3.fromRGB(32, 48, 75),
        Text          = Color3.fromRGB(240, 246, 255),
        Muted         = Color3.fromRGB(140, 165, 195),
        Accent        = Color3.fromRGB(14, 165, 233),
        AccentHover   = Color3.fromRGB(56, 189, 248),
        AccentSoft    = Color3.fromRGB(16, 42, 70),
        Success       = Color3.fromRGB(16, 185, 129),
        Warning       = Color3.fromRGB(245, 158, 11),
        Danger        = Color3.fromRGB(244, 63, 94),
    },
    DeepAzure = {
        Background    = Color3.fromRGB(10, 13, 23),
        Sidebar       = Color3.fromRGB(8, 10, 18),
        Surface       = Color3.fromRGB(16, 22, 38),
        SurfaceHover  = Color3.fromRGB(22, 31, 54),
        Stroke        = Color3.fromRGB(59, 130, 246),
        StrokeSoft    = Color3.fromRGB(28, 40, 68),
        Text          = Color3.fromRGB(245, 248, 255),
        Muted         = Color3.fromRGB(135, 155, 190),
        Accent        = Color3.fromRGB(59, 130, 246),
        AccentHover   = Color3.fromRGB(96, 165, 250),
        AccentSoft    = Color3.fromRGB(18, 36, 72),
        Success       = Color3.fromRGB(34, 197, 94),
        Warning       = Color3.fromRGB(251, 191, 36),
        Danger        = Color3.fromRGB(239, 68, 68),
    }
}

local THEME_ORDER = { "CyberNeon", "SkyBlue", "DeepAzure" }

local function resolveTheme(themeInput: any): { [string]: Color3 }
    local base = Library.Themes.CyberNeon
    local resolved = {}
    for k, v in pairs(base) do
        resolved[k] = v
    end

    if type(themeInput) == "string" and Library.Themes[themeInput] then
        for k, v in pairs(Library.Themes[themeInput]) do
            resolved[k] = v
        end
    elseif type(themeInput) == "table" then
        for k, v in pairs(themeInput) do
            resolved[k] = v
        end
    end

    return resolved
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local function getTopInset(): number
    local topInset = 36
    pcall(function()
        topInset = GuiService:GetGuiInset().Y
    end)
    return math.max(topInset, 0)
end

-- Comprehensive Device Type Detection
local function detectDeviceType(): string
    if GuiService:IsTenFootInterface() then
        return "Console"
    end
    local camera = workspace.CurrentCamera
    local vp = (camera and camera.ViewportSize) or Vector2.new(1920, 1080)
    local minDim = math.min(vp.X, vp.Y)
    local maxDim = math.max(vp.X, vp.Y)
    local isTouch = UserInputService.TouchEnabled

    if isTouch and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled then
        if minDim >= 580 and maxDim >= 880 then
            return "Tablet"
        else
            return "Phone"
        end
    elseif isTouch then
        if minDim < 520 then
            return "Phone"
        elseif minDim < 720 then
            return "Tablet"
        else
            return "Desktop"
        end
    else
        return "Desktop"
    end
end

-- Device-Specific Scale Calculation
local function calculateDeviceScale(deviceType: string, vp: Vector2, topInset: number): number
    local availableHeight = math.max(vp.Y - topInset - 24, 200)
    local availableWidth = math.max(vp.X - 32, 300)
    
    local baseW = 800
    local baseH = 540

    if deviceType == "Phone" then
        -- On phones, scale down so the UI fits the screen comfortably with room around it
        local fitX = availableWidth / (baseW * 1.05)
        local fitY = availableHeight / (baseH * 1.05)
        return math.clamp(math.min(fitX, fitY), 0.50, 0.76)
    elseif deviceType == "Tablet" then
        -- On tablets, provide a balanced medium scale
        local fitX = availableWidth / (baseW * 1.1)
        local fitY = availableHeight / (baseH * 1.1)
        return math.clamp(math.min(fitX, fitY), 0.72, 0.95)
    elseif deviceType == "Console" then
        -- 10-foot distance TV experience
        return 1.20
    else
        -- Desktop: scale according to resolution
        if vp.Y >= 1440 then
            -- 1440p / 4K monitors: scale up slightly for high-DPI readability
            return math.clamp(vp.Y / 1200, 1.0, 1.30)
        elseif vp.Y <= 720 or vp.X <= 1280 then
            -- Small laptop or small windowed mode
            local fitX = availableWidth / (baseW * 1.08)
            local fitY = availableHeight / (baseH * 1.08)
            return math.clamp(math.min(fitX, fitY), 0.75, 1.0)
        else
            -- Standard 1080p Desktop: 1.0 native
            return 1.0
        end
    end
end

local function tween(object: Instance, time: number, goal: { [string]: any }, style: Enum.EasingStyle?, direction: Enum.EasingDirection?)
    local info = TweenInfo.new(time, style or Enum.EasingStyle.Quart, direction or Enum.EasingDirection.Out)
    local anim = TweenService:Create(object, info, goal)
    anim:Play()
    return anim
end

local function make(className: string, props: { [string]: any }?, children: { Instance }?): any
    local object = Instance.new(className)
    if props then
        for key, value in pairs(props) do
            (object :: any)[key] = value
        end
    end
    if children then
        for _, child in ipairs(children) do
            child.Parent = object
        end
    end
    return object
end

local function corner(parent: Instance, radius: number)
    return make("UICorner", {
        CornerRadius = UDim.new(0, radius),
        Parent = parent,
    })
end

local function stroke(parent: Instance, color: Color3, thickness: number?, transparency: number?)
    return make("UIStroke", {
        Color = color,
        Thickness = thickness or 1,
        Transparency = transparency or 0.65,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = parent,
    })
end

local function padding(parent: Instance, left: number, top: number, right: number, bottom: number)
    return make("UIPadding", {
        PaddingLeft = UDim.new(0, left),
        PaddingTop = UDim.new(0, top),
        PaddingRight = UDim.new(0, right),
        PaddingBottom = UDim.new(0, bottom),
        Parent = parent,
    })
end

local function list(parent: Instance, paddingSize: number, direction: Enum.FillDirection?)
    return make("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, paddingSize),
        FillDirection = direction or Enum.FillDirection.Vertical,
        Parent = parent,
    })
end

local function normalizeAsset(image: any): string
    if type(image) == "number" then
        return "rbxassetid://" .. tostring(image)
    end
    if type(image) == "string" then
        if image == "" then return "" end
        if image:find("rbxassetid://") or image:find("rbxthumb://") or image:find("http") then
            return image
        end
        if Library.Assets[image] then
            return Library.Assets[image]
        end
        -- Support local exploit asset loaders (getcustomasset / getsynasset)
        local getCustom = (typeof(getcustomasset) == "function" and getcustomasset)
            or (typeof(getsynasset) == "function" and getsynasset)
        if getCustom then
            local isFileFn = (typeof(isfile) == "function" and isfile)
            if (isFileFn and isFileFn(image)) or image:find("%.png$") or image:find("%.jpg$") or image:find("%.jpeg$") then
                local ok, asset = pcall(getCustom, image)
                if ok and asset and asset ~= "" then return asset end
            end
        end
        if tonumber(image) then
            return "rbxassetid://" .. image
        end
        -- Fallback if local image file wasn't found
        if image:find("%.png$") or image:find("%.jpg$") then
            return Library.Assets.ImageLogo or "rbxassetid://111362591084511"
        end
        return image
    end
    return ""
end

local function createDefaultBorderSequence(theme: { [string]: Color3 }): ColorSequence
    return ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, theme.Accent),
        ColorSequenceKeypoint.new(0.25, Color3.fromRGB(168, 85, 247)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(56, 189, 248)),
        ColorSequenceKeypoint.new(0.75, theme.Stroke),
        ColorSequenceKeypoint.new(1.00, theme.Accent),
    })
end

local function getParentGui()
    if gethui then
        local ok, h = pcall(gethui)
        if ok and h then return h end
    end
    local ok, parent = pcall(function() return CoreGui end)
    if ok and parent then return parent end
    return LocalPlayer:WaitForChild("PlayerGui")
end

local function updateCanvas(scroll: ScrollingFrame, layout: UIListLayout, extra: number?)
    local function refresh()
        scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + (extra or 24))
    end
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(refresh)
    refresh()
end

local function addRipple(button: GuiButton, color: Color3)
    button.ClipsDescendants = true
    button.MouseButton1Down:Connect(function(x, y)
        local ripple = make("Frame", {
            Name = "Ripple",
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromOffset(x - button.AbsolutePosition.X, y - button.AbsolutePosition.Y),
            Size = UDim2.fromOffset(0, 0),
            BackgroundColor3 = color,
            BackgroundTransparency = 0.65,
            BorderSizePixel = 0,
            ZIndex = button.ZIndex + 2,
            Parent = button,
        })
        corner(ripple, 100)
        local size = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 2.2
        tween(ripple, 0.45, {
            Size = UDim2.fromOffset(size, size),
            BackgroundTransparency = 1,
        }, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        task.delay(0.48, function()
            if ripple then ripple:Destroy() end
        end)
    end)
end

-- Clamp Window so it cannot go above the screen or off the viewport
local function clampWindowPosition(target: GuiObject, uiScale: UIScale?)
    local camera = workspace.CurrentCamera
    local vp = (camera and camera.ViewportSize) or Vector2.new(1920, 1080)
    local scale = uiScale and uiScale.Scale or 1
    local topInset = getTopInset()

    local halfH = (target.AbsoluteSize.Y * scale) / 2
    local halfW = (target.AbsoluteSize.X * scale) / 2

    local minOffsetY = (topInset + halfH - (vp.Y * 0.5)) / scale
    local maxOffsetY = ((vp.Y * 0.5) - halfH) / scale
    if minOffsetY > maxOffsetY then
        maxOffsetY = minOffsetY
    end

    local minOffsetX = (halfW - (vp.X * 0.5)) / scale
    local maxOffsetX = ((vp.X * 0.5) - halfW) / scale
    if minOffsetX > maxOffsetX then
        minOffsetX = 0
        maxOffsetX = 0
    end

    local currentOffsetY = target.Position.Y.Offset
    local currentOffsetX = target.Position.X.Offset

    local clampedY = math.clamp(currentOffsetY, minOffsetY, maxOffsetY)
    local clampedX = math.clamp(currentOffsetX, minOffsetX, maxOffsetX)

    target.Position = UDim2.new(0.5, clampedX, 0.5, clampedY)
end

local function bindDrag(handle: GuiObject, target: GuiObject, uiScale: UIScale?)
    local dragging = false
    local dragInput: InputObject? = nil
    local dragStart: Vector3? = nil
    local startPosition: UDim2? = nil

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPosition = target.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput and dragStart and startPosition then
            local delta = input.Position - dragStart
            local scale = (uiScale and uiScale.Scale) or 1
            local camera = workspace.CurrentCamera
            local vp = (camera and camera.ViewportSize) or Vector2.new(1920, 1080)
            local topInset = getTopInset()

            local rawOffsetX = startPosition.X.Offset + (delta.X / scale)
            local rawOffsetY = startPosition.Y.Offset + (delta.Y / scale)

            -- Keep GUI strictly from going above the screen:
            local halfH = (target.AbsoluteSize.Y * scale) / 2
            local minOffsetY = (topInset + halfH - (vp.Y * 0.5)) / scale
            local maxOffsetY = ((vp.Y * 0.5) - halfH) / scale
            if minOffsetY > maxOffsetY then
                maxOffsetY = minOffsetY
            end

            local clampedY = math.clamp(rawOffsetY, minOffsetY, maxOffsetY)

            target.Position = UDim2.new(
                startPosition.X.Scale,
                rawOffsetX,
                startPosition.Y.Scale,
                clampedY
            )
        end
    end)
end

local function bindResize(handle: GuiObject, target: GuiObject, minSize: Vector2, uiScale: UIScale?)
    local resizing = false
    local resizeInput: InputObject? = nil
    local startPos: Vector2? = nil
    local startSize: UDim2? = nil

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizing = true
            startPos = Vector2.new(input.Position.X, input.Position.Y)
            startSize = target.Size
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    resizing = false
                end
            end)
        end
    end)

    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            resizeInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if resizing and input == resizeInput and startPos and startSize then
            local scale = (uiScale and uiScale.Scale) or 1
            local currentPos = Vector2.new(input.Position.X, input.Position.Y)
            local delta = (currentPos - startPos) / scale
            local newX = math.max(minSize.X, startSize.X.Offset + delta.X)
            local newY = math.max(minSize.Y, startSize.Y.Offset + delta.Y)
            target.Size = UDim2.fromOffset(newX, newY)
            clampWindowPosition(target, uiScale)
        end
    end)
end

local function createIcon(parent: Instance, image: any, size: number, color: Color3, transparency: number?)
    local asset = normalizeAsset(image)
    return make("ImageLabel", {
        Name = "Icon",
        Size = UDim2.fromOffset(size, size),
        BackgroundTransparency = 1,
        Image = asset,
        ImageColor3 = color,
        ImageTransparency = transparency or 0,
        ScaleType = Enum.ScaleType.Fit,
        Visible = asset ~= "",
        Parent = parent,
    })
end

local function createText(parent: Instance, name: string, text: string, size: number, color: Color3, bold: boolean?, order: number?)
    return make("TextLabel", {
        Name = name,
        Text = text,
        Font = bold and Enum.Font.GothamBold or Enum.Font.GothamMedium,
        TextSize = size,
        TextColor3 = color,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        TextWrapped = true,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = order or 1,
        Parent = parent,
    })
end

-- Core Row Component: Clean layout with reserved width for right controls to prevent text collision
local function createCoreRow(self: any, parent: Instance, title: string, desc: string?, image: any?, height: number?, rightReservedWidth: number?)
    local iconAsset = normalizeAsset(image or "")
    local hasIcon = iconAsset ~= ""
    local leftInset = hasIcon and 48 or 14
    local reservedRight = rightReservedWidth or 130
    local hasDesc = desc and desc ~= ""
    local actualHeight = height or (hasDesc and 68 or 52)

    local row = make("TextButton", {
        Name = "CoreRow",
        Text = "",
        AutoButtonColor = false,
        Size = UDim2.new(1, 0, 0, actualHeight),
        BackgroundColor3 = self.Theme.Surface,
        BackgroundTransparency = 0.25,
        BorderSizePixel = 0,
        LayoutOrder = 10,
        Parent = parent,
    })
    row.ClipsDescendants = true
    corner(row, 10)
    local rowStroke = stroke(row, self.Theme.StrokeSoft, 1, 0.7)

    local leftIndicator = make("Frame", {
        Name = "LeftIndicator",
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 0, 0.5, 0),
        Size = UDim2.new(0, 3, 0.45, 0),
        BackgroundColor3 = self.Theme.Accent,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Parent = row,
    })
    corner(leftIndicator, 2)

    local iconWrap = make("Frame", {
        Name = "IconWrap",
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 10, 0.5, 0),
        Size = UDim2.fromOffset(30, 30),
        BackgroundColor3 = self.Theme.Sidebar,
        BackgroundTransparency = 0.3,
        BorderSizePixel = 0,
        Visible = hasIcon,
        Parent = row,
    })
    corner(iconWrap, 7)
    local iconWrapStroke = stroke(iconWrap, self.Theme.StrokeSoft, 1, 0.8)

    local icon = createIcon(iconWrap, iconAsset, 16, self.Theme.Accent, 0)
    icon.AnchorPoint = Vector2.new(0.5, 0.5)
    icon.Position = UDim2.fromScale(0.5, 0.5)

    -- textWrap uses reservedRight with ample space so title never breaks awkwardly
    local textWrap = make("Frame", {
        Name = "TextWrap",
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, leftInset, 0.5, 0),
        Size = UDim2.new(1, -leftInset - reservedRight, 1, -8),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Parent = row,
    })
    local tLayout = list(textWrap, 2)
    tLayout.VerticalAlignment = Enum.VerticalAlignment.Center

    -- Title: single-line GothamBold with TextTruncate so it never breaks into "Server" / "Code"
    make("TextLabel", {
        Name = "Title",
        Text = title,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = self.Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        TextTruncate = Enum.TextTruncate.AtEnd,
        TextWrapped = false,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 18),
        LayoutOrder = 1,
        Parent = textWrap,
    })

    if hasDesc then
        make("TextLabel", {
            Name = "Desc",
            Text = desc :: string,
            Font = Enum.Font.GothamMedium,
            TextSize = 12,
            TextColor3 = self.Theme.Muted,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextWrapped = true,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 26),
            LayoutOrder = 2,
            Parent = textWrap,
        })
    end

    row.MouseEnter:Connect(function()
        tween(row, 0.2, { BackgroundColor3 = self.Theme.SurfaceHover, BackgroundTransparency = 0.1 })
        tween(rowStroke, 0.2, { Color = self.Theme.Accent, Transparency = 0.4 })
        tween(leftIndicator, 0.2, { BackgroundTransparency = 0, Size = UDim2.new(0, 3, 0.65, 0) })
        if hasIcon then
            tween(iconWrapStroke, 0.2, { Color = self.Theme.Accent, Transparency = 0.5 })
        end
    end)
    row.MouseLeave:Connect(function()
        tween(row, 0.2, { BackgroundColor3 = self.Theme.Surface, BackgroundTransparency = 0.25 })
        tween(rowStroke, 0.2, { Color = self.Theme.StrokeSoft, Transparency = 0.7 })
        tween(leftIndicator, 0.2, { BackgroundTransparency = 1, Size = UDim2.new(0, 3, 0.45, 0) })
        if hasIcon then
            tween(iconWrapStroke, 0.2, { Color = self.Theme.StrokeSoft, Transparency = 0.8 })
        end
    end)

    return row
end

local function createPageApi(window: any, scroll: ScrollingFrame)
    local api = {}

    local function checkPremium(props: { [string]: any }?): boolean
        if props and props.IsPrem == false then
            window:Notify({
                Title = "Premium Required",
                Desc = "Please activate prem",
                Duration = 3,
            })
            return false
        end
        return true
    end

    function api:Section(props: { [string]: any })
        props = props or {}
        local section = make("Frame", {
            Name = "Section",
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            LayoutOrder = props.Order or 10,
            Parent = scroll,
        })
        list(section, 10)

        local headerWrap = make("Frame", {
            Name = "SectionHeaderWrap",
            Size = UDim2.new(1, 0, 0, 26),
            BackgroundTransparency = 1,
            LayoutOrder = 1,
            Parent = section,
        })
        local hLayout = list(headerWrap, 8, Enum.FillDirection.Horizontal)
        hLayout.VerticalAlignment = Enum.VerticalAlignment.Center

        local accentBar = make("Frame", {
            Name = "AccentBar",
            Size = UDim2.fromOffset(3, 16),
            BackgroundColor3 = window.Theme.Accent,
            BorderSizePixel = 0,
            Parent = headerWrap,
        })
        corner(accentBar, 2)

        make("TextLabel", {
            Name = "SectionTitle",
            Text = string.upper(tostring(props.Title or "Section")),
            Font = Enum.Font.GothamBold,
            TextSize = 14,
            TextColor3 = window.Theme.Muted,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -20, 1, 0),
            Parent = headerWrap,
        })

        local sectionApi = createPageApi(window, section :: any)
        sectionApi.Root = section
        return sectionApi
    end

    function api:Label(props: { [string]: any })
        props = props or {}
        local row = createCoreRow(window, scroll, tostring(props.Title or "Label"), props.Desc or "", props.Image or "", props.Height or 60, 20)
        local item = {}
        function item:SetTitle(value: string)
            local titleLabel = row:FindFirstChild("Title", true)
            if titleLabel and titleLabel:IsA("TextLabel") then titleLabel.Text = value end
        end
        function item:SetDesc(value: string)
            local descLabel = row:FindFirstChild("Desc", true)
            if descLabel and descLabel:IsA("TextLabel") then descLabel.Text = value end
        end
        function item:SetVisible(value: boolean) row.Visible = value end
        return item
    end

    function api:Button(props: { [string]: any })
        props = props or {}
        local callback = props.Callback or function() end
        local row = createCoreRow(window, scroll, tostring(props.Title or "Button"), props.Desc or "", props.Image or "Button", props.Height or 60, 50)
        addRipple(row, window.Theme.Accent)

        local actionPill = make("Frame", {
            Name = "ActionPill",
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -14, 0.5, 0),
            Size = UDim2.fromOffset(32, 32),
            BackgroundColor3 = window.Theme.Sidebar,
            BackgroundTransparency = 0.4,
            BorderSizePixel = 0,
            Parent = row,
        })
        corner(actionPill, 8)
        stroke(actionPill, window.Theme.StrokeSoft, 1, 0.8)

        local glyph = createIcon(actionPill, props.RightIcon or "Button", 16, window.Theme.Muted, 0)
        glyph.AnchorPoint = Vector2.new(0.5, 0.5)
        glyph.Position = UDim2.fromScale(0.5, 0.5)

        row.MouseEnter:Connect(function()
            tween(glyph, 0.15, { ImageColor3 = window.Theme.Accent })
            tween(actionPill, 0.15, { BackgroundColor3 = window.Theme.AccentSoft, BackgroundTransparency = 0.1 })
        end)
        row.MouseLeave:Connect(function()
            tween(glyph, 0.15, { ImageColor3 = window.Theme.Muted })
            tween(actionPill, 0.15, { BackgroundColor3 = window.Theme.Sidebar, BackgroundTransparency = 0.4 })
        end)

        row.MouseButton1Click:Connect(function()
            if not checkPremium(props) then return end
            tween(row, 0.08, { Size = UDim2.new(1, 0, 0, (props.Height or 60) - 3) })
            task.delay(0.08, function()
                tween(row, 0.12, { Size = UDim2.new(1, 0, 0, props.Height or 60) })
            end)
            task.spawn(callback)
        end)

        local item = {}
        function item:SetTitle(value: string)
            local titleLabel = row:FindFirstChild("Title", true)
            if titleLabel and titleLabel:IsA("TextLabel") then titleLabel.Text = value end
        end
        function item:SetVisible(value: boolean) row.Visible = value end
        return item
    end

    function api:Toggle(props: { [string]: any })
        props = props or {}
        local value = props.Value == true
        local callback = props.Callback or function() end
        local row = createCoreRow(window, scroll, tostring(props.Title or "Toggle"), props.Desc or "", props.Image or "", props.Height or 60, 68)
        addRipple(row, window.Theme.Accent)

        local switch = make("Frame", {
            Name = "Switch",
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -16, 0.5, 0),
            Size = UDim2.fromOffset(48, 26),
            BackgroundColor3 = value and window.Theme.Success or window.Theme.Sidebar,
            BackgroundTransparency = value and 0.1 or 0.3,
            BorderSizePixel = 0,
            Parent = row,
        })
        corner(switch, 13)
        local switchStroke = stroke(switch, value and window.Theme.Success or window.Theme.StrokeSoft, 1, value and 0.3 or 0.6)

        local knob = make("Frame", {
            Name = "Knob",
            Size = UDim2.fromOffset(20, 20),
            Position = value and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 3, 0.5, -10),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BorderSizePixel = 0,
            Parent = switch,
        })
        corner(knob, 10)

        local function setValue(nextValue: boolean, fire: boolean?)
            value = nextValue == true
            tween(switch, 0.22, {
                BackgroundColor3 = value and window.Theme.Success or window.Theme.Sidebar,
                BackgroundTransparency = value and 0.1 or 0.3,
            }, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            tween(switchStroke, 0.22, {
                Color = value and window.Theme.Success or window.Theme.StrokeSoft,
                Transparency = value and 0.3 or 0.6,
            })
            tween(knob, 0.22, {
                Position = value and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 3, 0.5, -10),
            }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            if fire then
                task.spawn(function() callback(value) end)
            end
        end

        row.MouseButton1Click:Connect(function()
            if not checkPremium(props) then return end
            setValue(not value, true)
        end)

        local item = {}
        function item:SetValue(nextVal: boolean) setValue(nextVal, false) end
        function item:GetValue() return value end
        function item:SetVisible(nextVal: boolean) row.Visible = nextVal end
        return item
    end

    function api:Dropdown(props: { [string]: any })
        props = props or {}
        local options = props.List or props.Options or {}
        local multi = props.Multi == true
        local title = tostring(props.Title or "Dropdown")
        local desc = tostring(props.Desc or "")
        local callback = props.Callback or function() end
        local selected = props.Value
        if selected == nil and not multi then
            selected = options[1]
        elseif selected == nil and multi then
            selected = {}
        end

        local container = make("Frame", {
            Name = "DropdownContainer",
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            LayoutOrder = 10,
            Parent = scroll,
        })
        list(container, 6)

        local pillWidth = props.ValueWidth or 160
        local row = createCoreRow(window, container, title, desc, props.Image or "", props.Height or 60, pillWidth + 24)
        addRipple(row, window.Theme.Accent)

        local pillWrap = make("Frame", {
            Name = "ValuePill",
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -14, 0.5, 0),
            Size = UDim2.fromOffset(pillWidth, 34),
            BackgroundColor3 = window.Theme.Sidebar,
            BackgroundTransparency = 0.3,
            BorderSizePixel = 0,
            Parent = row,
        })
        corner(pillWrap, 8)
        local pillStroke = stroke(pillWrap, window.Theme.StrokeSoft, 1, 0.8)
        padding(pillWrap, 12, 0, 12, 0)

        local valueLabel = make("TextLabel", {
            Name = "Value",
            Text = multi and table.concat(selected, ", ") or tostring(selected or "Select"),
            Font = Enum.Font.GothamBold,
            TextSize = 13,
            TextColor3 = window.Theme.Accent,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -24, 1, 0),
            Parent = pillWrap,
        })

        local chevron = createIcon(pillWrap, "Chevron", 16, window.Theme.Muted, 0)
        chevron.AnchorPoint = Vector2.new(1, 0.5)
        chevron.Position = UDim2.new(1, 0, 0.5, 0)

        local listFrame = make("Frame", {
            Name = "DropdownList",
            Size = UDim2.new(1, 0, 0, 0),
            BackgroundColor3 = window.Theme.Sidebar,
            BackgroundTransparency = 0.15,
            BorderSizePixel = 0,
            ClipsDescendants = true,
            Visible = false,
            LayoutOrder = 11,
            Parent = container,
        })
        corner(listFrame, 10)
        stroke(listFrame, window.Theme.StrokeSoft, 1, 0.6)
        padding(listFrame, 6, 6, 6, 6)
        local optionLayout = list(listFrame, 4)

        local open = false
        local buttons = {}

        local function getDropdownHeight()
            return optionLayout.AbsoluteContentSize.Y + 12
        end

        local function closeDropdown()
            open = false
            tween(listFrame, 0.2, { Size = UDim2.new(1, 0, 0, 0) }, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            tween(chevron, 0.2, { Rotation = 0 })
            task.delay(0.2, function()
                if not open and listFrame.Parent then listFrame.Visible = false end
            end)
        end

        local function openDropdown()
            open = true
            listFrame.Visible = true
            listFrame.Size = UDim2.new(1, 0, 0, 0)
            tween(listFrame, 0.25, { Size = UDim2.new(1, 0, 0, getDropdownHeight()) }, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            tween(chevron, 0.2, { Rotation = 180 })
        end

        local function selectedContains(val: any)
            if not multi or type(selected) ~= "table" then return selected == val end
            return table.find(selected, val) ~= nil
        end

        local function refreshValue()
            valueLabel.Text = multi and table.concat(selected, ", ") or tostring(selected or "Select")
            if valueLabel.Text == "" then valueLabel.Text = "Select" end
            for opt, btn in pairs(buttons) do
                local active = selectedContains(opt)
                btn.TextColor3 = active and window.Theme.Accent or window.Theme.Text
                btn.BackgroundColor3 = active and window.Theme.AccentSoft or window.Theme.Surface
                btn.BackgroundTransparency = active and 0.2 or 0.7
            end
        end

        local function addOption(opt: any)
            local btn = make("TextButton", {
                Name = "Option",
                Text = "   " .. tostring(opt),
                Font = Enum.Font.GothamMedium,
                TextSize = 14,
                TextColor3 = selectedContains(opt) and window.Theme.Accent or window.Theme.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                AutoButtonColor = false,
                BackgroundColor3 = selectedContains(opt) and window.Theme.AccentSoft or window.Theme.Surface,
                BackgroundTransparency = selectedContains(opt) and 0.2 or 0.7,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 36),
                Parent = listFrame,
            })
            corner(btn, 6)
            addRipple(btn, window.Theme.Accent)
            buttons[opt] = btn

            btn.MouseButton1Click:Connect(function()
                if multi then
                    local pos = table.find(selected, opt)
                    if pos then table.remove(selected, pos) else table.insert(selected, opt) end
                else
                    selected = opt
                    closeDropdown()
                end
                refreshValue()
                callback(selected)
            end)
        end

        for _, opt in ipairs(options) do
            addOption(opt)
        end

        row.MouseButton1Click:Connect(function()
            if not checkPremium(props) then return end
            if open then closeDropdown() else openDropdown() end
        end)

        local item = {}
        function item:SetValue(v: any) selected = v; refreshValue() end
        function item:GetValue() return selected end
        function item:SetVisible(v: boolean) container.Visible = v end
        return item
    end

    function api:Segmented(props: { [string]: any })
        props = props or {}
        local options = props.Options or props.List or { "Option 1", "Option 2" }
        local selected = props.Value or options[1]
        local callback = props.Callback or function() end

        local row = make("Frame", {
            Name = "SegmentedContainer",
            Size = UDim2.new(1, 0, 0, 52),
            BackgroundColor3 = window.Theme.Surface,
            BackgroundTransparency = 0.35,
            BorderSizePixel = 0,
            LayoutOrder = 10,
            Parent = scroll,
        })
        corner(row, 10)
        stroke(row, window.Theme.StrokeSoft, 1, 0.75)
        padding(row, 6, 6, 6, 6)
        local segLayout = list(row, 6, Enum.FillDirection.Horizontal)
        segLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        segLayout.VerticalAlignment = Enum.VerticalAlignment.Center

        local buttons = {}
        local btnWidth = 1 / #options

        local function refreshSegmented()
            for opt, btn in pairs(buttons) do
                local active = opt == selected
                tween(btn, 0.2, {
                    BackgroundColor3 = active and window.Theme.Accent or window.Theme.Sidebar,
                    BackgroundTransparency = active and 0.15 or 0.6,
                }, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                btn.TextColor3 = active and Color3.fromRGB(255, 255, 255) or window.Theme.Muted
            end
        end

        for _, opt in ipairs(options) do
            local btn = make("TextButton", {
                Name = "Segment_" .. tostring(opt),
                Text = tostring(opt),
                Font = Enum.Font.GothamBold,
                TextSize = 14,
                TextColor3 = opt == selected and Color3.fromRGB(255, 255, 255) or window.Theme.Muted,
                AutoButtonColor = false,
                BackgroundColor3 = opt == selected and window.Theme.Accent or window.Theme.Sidebar,
                BackgroundTransparency = opt == selected and 0.15 or 0.6,
                BorderSizePixel = 0,
                Size = UDim2.new(btnWidth, -4, 1, 0),
                Parent = row,
            })
            corner(btn, 8)
            addRipple(btn, Color3.fromRGB(255, 255, 255))
            buttons[opt] = btn

            btn.MouseButton1Click:Connect(function()
                if not checkPremium(props) then return end
                selected = opt
                refreshSegmented()
                task.spawn(function() callback(selected) end)
            end)
        end

        local item = {}
        function item:SetValue(v: any) selected = v; refreshSegmented() end
        function item:GetValue() return selected end
        function item:SetVisible(v: boolean) row.Visible = v end
        return item
    end

    function api:SelectionBox(props: { [string]: any })
        props = props or {}
        local selections = props.Selections or { "Free", "Premium" }
        local descriptions = props.Descriptions or {}
        local checklist = props.Checklist or {}
        local buttonTexts = props.ButtonTexts or {}
        local callbacks = props.Callbacks or {}
        
        local selected = props.Value or selections[1]

        local container = make("Frame", {
            Name = "SelectionBoxContainer",
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            LayoutOrder = 10,
            Parent = scroll,
        })
        list(container, 10)

        local segRow = make("Frame", {
            Name = "SegmentedContainer",
            Size = UDim2.new(1, 0, 0, 50),
            BackgroundColor3 = window.Theme.Surface,
            BackgroundTransparency = 0.35,
            BorderSizePixel = 0,
            Parent = container,
        })
        corner(segRow, 10)
        stroke(segRow, window.Theme.StrokeSoft, 1, 0.75)
        padding(segRow, 6, 6, 6, 6)
        local segLayout = list(segRow, 6, Enum.FillDirection.Horizontal)
        segLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        segLayout.VerticalAlignment = Enum.VerticalAlignment.Center

        local segButtons = {}
        local btnWidth = 1 / #selections

        local card = make("Frame", {
            Name = "SelectionCardBody",
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = window.Theme.Surface,
            BackgroundTransparency = 0.25,
            BorderSizePixel = 0,
            Parent = container,
        })
        corner(card, 12)
        stroke(card, window.Theme.StrokeSoft, 1, 0.65)
        padding(card, 18, 16, 18, 16)
        list(card, 14)

        local headerRow = make("Frame", {
            Name = "HeaderRow",
            Size = UDim2.new(1, 0, 0, 32),
            BackgroundTransparency = 1,
            Parent = card,
        })
        local cardTitleLabel = createText(headerRow, "CardTitle", "", 16, window.Theme.Text, true)

        local badgePill = make("Frame", {
            Name = "BadgePill",
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, 0, 0.5, 0),
            Size = UDim2.fromOffset(0, 26),
            AutomaticSize = Enum.AutomaticSize.X,
            BackgroundColor3 = window.Theme.AccentSoft,
            BorderSizePixel = 0,
            Parent = headerRow,
        })
        corner(badgePill, 6)
        padding(badgePill, 10, 0, 10, 0)
        stroke(badgePill, window.Theme.Accent, 1, 0.5)

        local badgeText = make("TextLabel", {
            Name = "BadgeText",
            Text = "",
            Font = Enum.Font.GothamBold,
            TextSize = 11,
            TextColor3 = window.Theme.Accent,
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(0, 26),
            AutomaticSize = Enum.AutomaticSize.X,
            Parent = badgePill,
        })

        local checklistContainer = make("Frame", {
            Name = "ChecklistContainer",
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Parent = card,
        })
        list(checklistContainer, 10)

        local actionBtn = make("TextButton", {
            Name = "ActionButton",
            Text = "",
            Font = Enum.Font.GothamBold,
            TextSize = 15,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            AutoButtonColor = false,
            BackgroundColor3 = window.Theme.Accent,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 46),
            Parent = card,
        })
        corner(actionBtn, 8)
        addRipple(actionBtn, Color3.fromRGB(255, 255, 255))

        actionBtn.MouseEnter:Connect(function()
            tween(actionBtn, 0.16, { BackgroundColor3 = window.Theme.AccentHover })
        end)
        actionBtn.MouseLeave:Connect(function()
            tween(actionBtn, 0.16, { BackgroundColor3 = window.Theme.Accent })
        end)

        local function updateSelectionView(targetOption: any)
            selected = targetOption

            for opt, btn in pairs(segButtons) do
                local active = opt == targetOption
                tween(btn, 0.2, {
                    BackgroundColor3 = active and window.Theme.Accent or window.Theme.Sidebar,
                    BackgroundTransparency = active and 0.15 or 0.6,
                }, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                btn.TextColor3 = active and Color3.fromRGB(255, 255, 255) or window.Theme.Muted
            end

            cardTitleLabel.Text = tostring(targetOption)
            local descVal = descriptions[targetOption] or descriptions[tostring(targetOption)] or ""
            badgeText.Text = string.upper(tostring(descVal))
            badgePill.Visible = (descVal ~= "")

            for _, child in ipairs(checklistContainer:GetChildren()) do
                if child:IsA("Frame") then child:Destroy() end
            end

            local matchedKey = targetOption
            if not checklist[matchedKey] then
                for k, v in pairs(checklist) do
                    if tostring(k):lower() == tostring(targetOption):lower() then
                        matchedKey = k
                        break
                    end
                end
            end

            local items = checklist[matchedKey] or {}
            for _, it in ipairs(items) do
                local itemRow = make("Frame", {
                    Name = "ItemRow",
                    Size = UDim2.new(1, 0, 0, 24),
                    BackgroundTransparency = 1,
                    Parent = checklistContainer,
                })
                local hLayout = list(itemRow, 10, Enum.FillDirection.Horizontal)
                hLayout.VerticalAlignment = Enum.VerticalAlignment.Center

                local checkDot = make("Frame", {
                    Name = "CheckDot",
                    Size = UDim2.fromOffset(20, 20),
                    BackgroundColor3 = window.Theme.Success,
                    BackgroundTransparency = 0.85,
                    BorderSizePixel = 0,
                    Parent = itemRow,
                })
                corner(checkDot, 10)
                stroke(checkDot, window.Theme.Success, 1, 0.5)

                make("TextLabel", {
                    Name = "Checkmark",
                    Text = "✓",
                    Font = Enum.Font.GothamBold,
                    TextSize = 12,
                    TextColor3 = window.Theme.Success,
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(1, 1),
                    Parent = checkDot,
                })

                make("TextLabel", {
                    Name = "ItemText",
                    Text = tostring(it),
                    Font = Enum.Font.GothamMedium,
                    TextSize = 13,
                    TextColor3 = window.Theme.Text,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, -34, 1, 0),
                    Parent = itemRow,
                })
            end

            local matchedBtnKey = targetOption
            if not buttonTexts[matchedBtnKey] then
                for k, v in pairs(buttonTexts) do
                    if tostring(k):lower() == tostring(targetOption):lower() then
                        matchedBtnKey = k
                        break
                    end
                end
            end
            actionBtn.Text = tostring(buttonTexts[matchedBtnKey] or ("Select " .. tostring(targetOption)))

            actionBtn.MouseButton1Click:Connect(function()
                if not checkPremium(props) then return end
                local matchedCbKey = targetOption
                if not callbacks[matchedCbKey] then
                    for k, v in pairs(callbacks) do
                        if tostring(k):lower() == tostring(targetOption):lower() then
                            matchedCbKey = k
                            break
                        end
                    end
                end
                local cb = callbacks[matchedCbKey]
                if type(cb) == "function" then
                    task.spawn(cb)
                end
            end)
        end

        for _, opt in ipairs(selections) do
            local btn = make("TextButton", {
                Name = "Segment_" .. tostring(opt),
                Text = tostring(opt),
                Font = Enum.Font.GothamBold,
                TextSize = 13,
                TextColor3 = opt == selected and Color3.fromRGB(255, 255, 255) or window.Theme.Muted,
                AutoButtonColor = false,
                BackgroundColor3 = opt == selected and window.Theme.Accent or window.Theme.Sidebar,
                BackgroundTransparency = opt == selected and 0.15 or 0.6,
                BorderSizePixel = 0,
                Size = UDim2.new(btnWidth, -4, 1, 0),
                Parent = segRow,
            })
            corner(btn, 8)
            addRipple(btn, Color3.fromRGB(255, 255, 255))
            segButtons[opt] = btn

            btn.MouseButton1Click:Connect(function()
                updateSelectionView(opt)
            end)
        end

        updateSelectionView(selected)

        local apiItem = {}
        function apiItem:SetValue(v: any) updateSelectionView(v) end
        function apiItem:GetValue() return selected end
        function apiItem:SetVisible(v: boolean) container.Visible = v end
        return apiItem
    end

    function api:FeatureCard(props: { [string]: any })
        props = props or {}
        local title = tostring(props.Title or "Feature Card")
        local badge = tostring(props.Badge or "")
        local items = props.Items or {}
        local buttonText = tostring(props.ButtonText or "Action")
        local callback = props.Callback or function() end

        local card = make("Frame", {
            Name = "FeatureCard",
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = window.Theme.Surface,
            BackgroundTransparency = 0.25,
            BorderSizePixel = 0,
            LayoutOrder = 10,
            Parent = scroll,
        })
        corner(card, 12)
        stroke(card, window.Theme.StrokeSoft, 1, 0.65)
        padding(card, 18, 16, 18, 16)
        list(card, 14)

        local headerRow = make("Frame", {
            Name = "HeaderRow",
            Size = UDim2.new(1, 0, 0, 32),
            BackgroundTransparency = 1,
            Parent = card,
        })
        createText(headerRow, "CardTitle", title, 16, window.Theme.Text, true)

        if badge ~= "" then
            local badgePill = make("Frame", {
                Name = "BadgePill",
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, 0, 0.5, 0),
                Size = UDim2.fromOffset(0, 26),
                AutomaticSize = Enum.AutomaticSize.X,
                BackgroundColor3 = window.Theme.AccentSoft,
                BorderSizePixel = 0,
                Parent = headerRow,
            })
            corner(badgePill, 6)
            padding(badgePill, 10, 0, 10, 0)
            stroke(badgePill, window.Theme.Accent, 1, 0.5)

            make("TextLabel", {
                Name = "BadgeText",
                Text = badge,
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                TextColor3 = window.Theme.Accent,
                BackgroundTransparency = 1,
                Size = UDim2.fromOffset(0, 26),
                AutomaticSize = Enum.AutomaticSize.X,
                Parent = badgePill,
            })
        end

        for _, it in ipairs(items) do
            local itemRow = make("Frame", {
                Name = "ItemRow",
                Size = UDim2.new(1, 0, 0, 24),
                BackgroundTransparency = 1,
                Parent = card,
            })
            local hLayout = list(itemRow, 10, Enum.FillDirection.Horizontal)
            hLayout.VerticalAlignment = Enum.VerticalAlignment.Center

            local checkDot = make("Frame", {
                Name = "CheckDot",
                Size = UDim2.fromOffset(20, 20),
                BackgroundColor3 = window.Theme.Success,
                BackgroundTransparency = 0.85,
                BorderSizePixel = 0,
                Parent = itemRow,
            })
            corner(checkDot, 10)
            stroke(checkDot, window.Theme.Success, 1, 0.5)

            make("TextLabel", {
                Name = "Checkmark",
                Text = "✓",
                Font = Enum.Font.GothamBold,
                TextSize = 12,
                TextColor3 = window.Theme.Success,
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1),
                Parent = checkDot,
            })

            make("TextLabel", {
                Name = "ItemText",
                Text = tostring(it),
                Font = Enum.Font.GothamMedium,
                TextSize = 13,
                TextColor3 = window.Theme.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -34, 1, 0),
                Parent = itemRow,
            })
        end

        if buttonText ~= "" then
            local actionBtn = make("TextButton", {
                Name = "ActionButton",
                Text = buttonText,
                Font = Enum.Font.GothamBold,
                TextSize = 15,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                AutoButtonColor = false,
                BackgroundColor3 = window.Theme.Accent,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 46),
                Parent = card,
            })
            corner(actionBtn, 8)
            addRipple(actionBtn, Color3.fromRGB(255, 255, 255))

            actionBtn.MouseEnter:Connect(function()
                tween(actionBtn, 0.16, { BackgroundColor3 = window.Theme.AccentHover })
            end)
            actionBtn.MouseLeave:Connect(function()
                tween(actionBtn, 0.16, { BackgroundColor3 = window.Theme.Accent })
            end)
            actionBtn.MouseButton1Click:Connect(function()
                if not checkPremium(props) then return end
                task.spawn(callback)
            end)
        end

        local item = {}
        function item:SetVisible(v: boolean) card.Visible = v end
        return item
    end

    function api:Search(props: { [string]: any })
        props = props or {}
        local placeholder = tostring(props.Placeholder or "Search components...")
        local callback = props.Callback or function() end

        local container = make("Frame", {
            Name = "SearchContainer",
            Size = UDim2.new(1, 0, 0, 48),
            BackgroundColor3 = window.Theme.Surface,
            BackgroundTransparency = 0.3,
            BorderSizePixel = 0,
            LayoutOrder = props.Order or 1,
            Parent = scroll,
        })
        corner(container, 10)
        local searchStroke = stroke(container, window.Theme.StrokeSoft, 1, 0.7)

        local searchIcon = createIcon(container, "Search", 18, window.Theme.Muted, 0)
        searchIcon.AnchorPoint = Vector2.new(0, 0.5)
        searchIcon.Position = UDim2.new(0, 14, 0.5, 0)

        local textBox = make("TextBox", {
            Name = "SearchInput",
            Text = "",
            PlaceholderText = placeholder,
            Font = Enum.Font.GothamMedium,
            TextSize = 13,
            TextColor3 = window.Theme.Text,
            PlaceholderColor3 = window.Theme.Muted,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(42, 0),
            Size = UDim2.new(1, -56, 1, 0),
            Parent = container,
        })

        textBox.Focused:Connect(function()
            if not checkPremium(props) then
                textBox:ReleaseFocus()
                return
            end
            tween(searchStroke, 0.15, { Color = window.Theme.Accent, Transparency = 0.3 })
            tween(searchIcon, 0.15, { ImageColor3 = window.Theme.Accent })
        end)

        textBox.FocusLost:Connect(function()
            tween(searchStroke, 0.15, { Color = window.Theme.StrokeSoft, Transparency = 0.7 })
            tween(searchIcon, 0.15, { ImageColor3 = window.Theme.Muted })
        end)

        textBox:GetPropertyChangedSignal("Text"):Connect(function()
            if props.IsPrem == false then return end
            local query = textBox.Text:lower()
            task.spawn(function() callback(query) end)
        end)

        local item = {}
        function item:SetVisible(v: boolean) container.Visible = v end
        return item
    end

    function api:Slider(props: { [string]: any })
        props = props or {}
        local min = tonumber(props.Min) or 0
        local max = tonumber(props.Max) or 100
        local value = tonumber(props.Value) or min
        local callback = props.Callback or function() end
        local sliderWidth = props.Width or 135

        -- Reserve sliderWidth + 18px so title & desc have plenty of width on the left
        local row = createCoreRow(window, scroll, tostring(props.Title or "Slider"), props.Desc or "", props.Image or "", props.Height or (props.Desc and 68 or 52), sliderWidth + 18)

        local sliderWrap = make("Frame", {
            Name = "SliderWrap",
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -14, 0.5, 0),
            Size = UDim2.fromOffset(sliderWidth, 38),
            BackgroundTransparency = 1,
            Parent = row,
        })

        local numberPill = make("Frame", {
            Name = "NumberPill",
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, 0, 0, 0),
            Size = UDim2.fromOffset(48, 20),
            BackgroundColor3 = window.Theme.Sidebar,
            BackgroundTransparency = 0.3,
            BorderSizePixel = 0,
            Parent = sliderWrap,
        })
        corner(numberPill, 6)
        stroke(numberPill, window.Theme.StrokeSoft, 1, 0.8)

        local numberLabel = make("TextLabel", {
            Name = "Number",
            Text = tostring(value),
            Font = Enum.Font.GothamBold,
            TextSize = 13,
            TextColor3 = window.Theme.Accent,
            TextXAlignment = Enum.TextXAlignment.Center,
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Parent = numberPill,
        })

        local bar = make("Frame", {
            Name = "Bar",
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.new(0, 0, 1, -2),
            Size = UDim2.new(1, 0, 0, 7),
            BackgroundColor3 = window.Theme.Sidebar,
            BorderSizePixel = 0,
            Parent = sliderWrap,
        })
        corner(bar, 4)

        local fill = make("Frame", {
            Name = "Fill",
            Size = UDim2.fromScale(0, 1),
            BackgroundColor3 = window.Theme.Accent,
            BorderSizePixel = 0,
            Parent = bar,
        })
        corner(fill, 4)

        local knob = make("Frame", {
            Name = "Knob",
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(1, 0, 0.5, 0),
            Size = UDim2.fromOffset(16, 16),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BorderSizePixel = 0,
            Parent = fill,
        })
        corner(knob, 8)
        stroke(knob, window.Theme.Accent, 2, 0.2)

        local dragging = false
        local function setValueFromAlpha(alpha: number, fire: boolean?)
            alpha = math.clamp(alpha, 0, 1)
            value = math.floor((min + ((max - min) * alpha)) + 0.5)
            local fillRatio = (value - min) / math.max(max - min, 1)
            fill.Size = UDim2.fromScale(fillRatio, 1)
            numberLabel.Text = tostring(value)
            if fire then callback(value) end
        end

        local function fromX(x: number)
            setValueFromAlpha((x - bar.AbsolutePosition.X) / math.max(bar.AbsoluteSize.X, 1), true)
        end

        bar.InputBegan:Connect(function(input)
            if not checkPremium(props) then return end
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                fromX(input.Position.X)
            end
        end)
        bar.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                fromX(input.Position.X)
            end
        end)

        setValueFromAlpha((value - min) / math.max(max - min, 1), false)

        local item = {}
        function item:SetValue(v: number)
            value = math.clamp(v, min, max)
            setValueFromAlpha((value - min) / math.max(max - min, 1), false)
        end
        function item:GetValue() return value end
        function item:SetVisible(v: boolean) row.Visible = v end
        return item
    end

    function api:Textbox(props: { [string]: any })
        props = props or {}
        local callback = props.Callback or function() end
        local boxWidth = props.Width or 125
        local row = createCoreRow(window, scroll, tostring(props.Title or "Textbox"), props.Desc or "", props.Image or "Textbox", props.Height or (props.Desc and 68 or 52), boxWidth + 18)

        local box = make("TextBox", {
            Name = "Input",
            Text = tostring(props.Value or ""),
            PlaceholderText = tostring(props.Placeholder or "Enter text"),
            Font = Enum.Font.GothamMedium,
            TextSize = 12,
            TextColor3 = window.Theme.Text,
            PlaceholderColor3 = window.Theme.Muted,
            TextXAlignment = Enum.TextXAlignment.Left,
            ClearTextOnFocus = props.ClearTextOnFocus == true or props.ClearText == true,
            BackgroundColor3 = window.Theme.Sidebar,
            BackgroundTransparency = 0.35,
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -14, 0.5, 0),
            Size = UDim2.fromOffset(boxWidth, 32),
            Parent = row,
        })
        corner(box, 8)
        local boxStroke = stroke(box, window.Theme.StrokeSoft, 1, 0.75)
        padding(box, 12, 0, 12, 0)

        box.Focused:Connect(function()
            if not checkPremium(props) then
                box:ReleaseFocus()
                return
            end
            tween(boxStroke, 0.16, { Color = window.Theme.Accent, Transparency = 0.3 })
        end)
        box.FocusLost:Connect(function(enterPressed)
            tween(boxStroke, 0.16, { Color = window.Theme.StrokeSoft, Transparency = 0.75 })
            if props.IsPrem ~= false then
                callback(box.Text, enterPressed)
            end
        end)

        local item = {}
        function item:SetValue(v: string) box.Text = v end
        function item:GetValue() return box.Text end
        function item:SetPlaceholderText(v: string) box.PlaceholderText = v end
        function item:SetVisible(v: boolean) row.Visible = v end
        return item
    end

    api.Root = scroll
    return api
end

function Library:Window(props: { [string]: any })
    props = props or {}
    local self = setmetatable({}, Library)
    self.ThemeName = (type(props.Theme) == "string" and props.Theme) or "CyberNeon"
    self.Theme = resolveTheme(props.Theme or "CyberNeon")
    self.Tabs = {}
    self.SelectedTab = nil
    self.Keybind = (props.Config and props.Config.Keybind) or props.Keybind or Enum.KeyCode.RightControl
    self.ManualScale = nil
    self.DeviceType = detectDeviceType()

    local appTitle = tostring(props.Title or "CYBERFLOW // v2.0")
    local guiName = props.Name or "CyberNeon_Window"
    local existing = getParentGui():FindFirstChild(guiName)
    if existing then existing:Destroy() end

    local screenGui = make("ScreenGui", {
        Name = guiName,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = props.DisplayOrder or 999,
        Parent = getParentGui(),
    })
    if typeof(protectgui) == "function" then
        pcall(protectgui, screenGui)
    elseif typeof(syn) == "table" and typeof((syn :: any).protect_gui) == "function" then
        pcall((syn :: any).protect_gui, screenGui)
    end
    self.ScreenGui = screenGui

    local shadow = make("ImageLabel", {
        Name = "Shadow",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = props.Position or UDim2.fromScale(0.5, 0.5),
        Size = (props.Config and props.Config.Size) or props.Size or UDim2.fromOffset(800, 540),
        BackgroundTransparency = 1,
        Image = Library.Assets.Shadow,
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        ImageTransparency = 0.4,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10, 10, 118, 118),
        Parent = screenGui,
    })
    self.Shadow = shadow

    -- Responsive Mobile / Tablet / Desktop UIScale
    local uiScale = make("UIScale", {
        Scale = 1,
        Parent = shadow,
    })
    self.UIScale = uiScale

    local function updateDeviceScale()
        local camera = workspace.CurrentCamera
        if not camera then return end
        local vp = camera.ViewportSize
        local topInset = getTopInset()
        self.DeviceType = detectDeviceType()

        local finalScale = self.ManualScale or calculateDeviceScale(self.DeviceType, vp, topInset)
        uiScale.Scale = finalScale
        clampWindowPosition(shadow, uiScale)
    end

    local camera = workspace.CurrentCamera
    if camera then
        camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateDeviceScale)
        task.spawn(updateDeviceScale)
    end

    -- Allow manual scale customization or resetting back to automatic
    function self:SetScale(newScale: number?)
        self.ManualScale = newScale
        updateDeviceScale()
    end

    function self:GetDeviceType(): string
        return self.DeviceType
    end

    local root = make("Frame", {
        Name = "WindowRoot",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.new(1, -16, 1, -16),
        BackgroundColor3 = self.Theme.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = shadow,
    })
    corner(root, 14)

    -- Animated Dynamic Gradient Border Stroke
    local rootStroke = stroke(root, Color3.fromRGB(255, 255, 255), 1.5, 0.15)
    rootStroke.Name = "AnimatedBorderStroke"
    local borderGradient = make("UIGradient", {
        Name = "BorderGradient",
        Color = props.BorderGradient or createDefaultBorderSequence(self.Theme),
        Rotation = 0,
        Parent = rootStroke,
    })
    self.BorderGradient = borderGradient
    self.BorderStroke = rootStroke
    self.CustomBorderGradient = props.BorderGradient ~= nil

    -- Animated Multi-Layer Frosted Glass Background
    local bgLayer = make("Frame", {
        Name = "BackgroundLayer",
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = self.Theme.Background,
        BorderSizePixel = 0,
        ZIndex = 1,
        ClipsDescendants = true,
        Parent = root,
    })
    corner(bgLayer, 14)

    local bgGradient = make("UIGradient", {
        Name = "AnimatedBgGradient",
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, self.Theme.Background),
            ColorSequenceKeypoint.new(0.35, self.Theme.Sidebar),
            ColorSequenceKeypoint.new(0.70, Color3.fromRGB(18, 20, 32)),
            ColorSequenceKeypoint.new(1.00, self.Theme.Background),
        }),
        Rotation = 45,
        Parent = bgLayer,
    })
    self.BgGradient = bgGradient

    local bgImage = make("ImageLabel", {
        Name = "BackgroundImage",
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        ScaleType = Enum.ScaleType.Crop,
        Image = normalizeAsset(props.BackgroundImage or props.Image or "82941526973068"),
        ImageTransparency = props.BackgroundImageTransparency or props.ImageTransparency or 0.82,
        ImageColor3 = props.BackgroundImageColor or Color3.fromRGB(255, 255, 255),
        ZIndex = 1,
        Parent = bgLayer,
    })
    self.BackgroundImage = bgImage

    -- Moving / Animated dynamic wave gradient on the background image itself
    local imgGradient = make("UIGradient", {
        Name = "MovingImageGradient",
        Color = props.BackgroundImageGradient or ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(130, 150, 195)),
            ColorSequenceKeypoint.new(0.35, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(0.65, self.Theme.Accent),
            ColorSequenceKeypoint.new(0.85, Color3.fromRGB(168, 85, 247)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(130, 150, 195)),
        }),
        Rotation = 35,
        Offset = Vector2.new(-1, 0),
        Parent = bgImage,
    })
    self.ImageGradient = imgGradient

    local ambientGlow = make("ImageLabel", {
        Name = "AmbientGlow",
        AnchorPoint = Vector2.new(0.5, 0.2),
        Position = UDim2.fromScale(0.5, 0.2),
        Size = UDim2.fromScale(1.4, 0.8),
        BackgroundTransparency = 1,
        Image = Library.Assets.Shadow,
        ImageColor3 = self.Theme.Accent,
        ImageTransparency = 0.88,
        ScaleType = Enum.ScaleType.Fit,
        ZIndex = 1,
        Parent = bgLayer,
    })
    self.AmbientGlow = ambientGlow

    -- Animated Border & Background Engine
    local borderAnimationActive = (props.BorderAnimation ~= false)
    local backgroundAnimationActive = (props.BackgroundAnimation ~= false)
    local borderSpeed = props.BorderSpeed or 60
    local bgTime = 0

    local animConn: RBXScriptConnection? = nil
    animConn = RunService.RenderStepped:Connect(function(dt)
        if not screenGui.Parent then
            if animConn then
                animConn:Disconnect()
                animConn = nil
            end
            return
        end

        if borderAnimationActive and borderGradient and borderGradient.Parent then
            borderGradient.Rotation = (borderGradient.Rotation + dt * borderSpeed) % 360
        end

        if backgroundAnimationActive then
            bgTime = bgTime + dt
            -- Dynamic moving wave sweep across the background image
            if imgGradient and imgGradient.Parent then
                local waveOffset = -1 + ((bgTime * 0.35) % 2)
                imgGradient.Offset = Vector2.new(waveOffset, math.sin(bgTime * 0.6) * 0.12)
                imgGradient.Rotation = 35 + math.sin(bgTime * 0.4) * 12
            end

            -- Ambient moving gradient rotation and offset
            if bgGradient and bgGradient.Parent then
                bgGradient.Rotation = (bgGradient.Rotation + dt * 18) % 360
                bgGradient.Offset = Vector2.new(math.sin(bgTime * 0.5) * 0.18, math.cos(bgTime * 0.4) * 0.18)
            end
            if ambientGlow and ambientGlow.Parent then
                ambientGlow.ImageTransparency = 0.86 + (math.sin(bgTime * 1.4) * 0.06)
            end
        end
    end)
    self.AnimConnection = animConn

    function self:SetBorderAnimation(enabled: boolean, speed: number?)
        borderAnimationActive = enabled
        if speed then borderSpeed = speed end
    end

    function self:SetBorderGradient(seq: ColorSequence?)
        if seq then
            self.CustomBorderGradient = true
            borderGradient.Color = seq
        else
            self.CustomBorderGradient = false
            borderGradient.Color = createDefaultBorderSequence(self.Theme)
        end
    end

    function self:SetBackgroundImage(asset: string, transparency: number?)
        bgImage.Image = normalizeAsset(asset)
        if transparency then
            bgImage.ImageTransparency = transparency
        end
        bgImage.Visible = (asset ~= "")
    end

    function self:SetBackgroundAnimation(enabled: boolean)
        backgroundAnimationActive = enabled
    end

    self.Root = root

    local topGlow = make("Frame", {
        Name = "TopGlow",
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = self.Theme.Accent,
        BackgroundTransparency = 0.6,
        BorderSizePixel = 0,
        Parent = root,
    })

    local floatingOpenBtn = make("ImageButton", {
        Name = "FloatingOpenButton",
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 24, 0.5, 0),
        Size = UDim2.fromOffset(54, 54),
        BackgroundColor3 = self.Theme.Surface,
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        Image = normalizeAsset(props.FloatingIcon or "89839278613299"),
        ImageColor3 = (tostring(props.Icon or "autohub_icon.png"):find("%.png") or tostring(props.Icon or "autohub_icon.png"):find("%.jpg")) and Color3.fromRGB(255, 255, 255) or self.Theme.Accent,
        Visible = false,
        ZIndex = 200,
        Parent = screenGui,
    })
    corner(floatingOpenBtn, 27)
    stroke(floatingOpenBtn, self.Theme.Accent, 1, 0.4)
    addRipple(floatingOpenBtn, self.Theme.Accent)
    bindDrag(floatingOpenBtn, floatingOpenBtn, nil)

    local confirmOverlay = make("Frame", {
        Name = "ConfirmOverlay",
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.65,
        Visible = false,
        ZIndex = 300,
        Parent = root,
    })

    local confirmModal = make("Frame", {
        Name = "ConfirmModal",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(320, 160),
        BackgroundColor3 = self.Theme.Sidebar,
        BorderSizePixel = 0,
        ZIndex = 301,
        Parent = confirmOverlay,
    })
    corner(confirmModal, 12)
    stroke(confirmModal, self.Theme.StrokeSoft, 1, 0.5)
    padding(confirmModal, 20, 20, 20, 20)
    list(confirmModal, 12)

    createText(confirmModal, "ModalTitle", "Confirm Exit", 17, self.Theme.Text, true, 1)
    createText(confirmModal, "ModalDesc", "Are you sure you want to close this UI?", 14, self.Theme.Muted, false, 2)

    local modalBtnRow = make("Frame", {
        Name = "ModalBtnRow",
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundTransparency = 1,
        LayoutOrder = 3,
        Parent = confirmModal,
    })
    list(modalBtnRow, 12, Enum.FillDirection.Horizontal)

    local cancelBtn = make("TextButton", {
        Name = "CancelBtn",
        Text = "Cancel",
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = self.Theme.Text,
        AutoButtonColor = false,
        BackgroundColor3 = self.Theme.Surface,
        BackgroundTransparency = 0.3,
        BorderSizePixel = 0,
        Size = UDim2.new(0.5, -6, 1, 0),
        Parent = modalBtnRow,
    })
    corner(cancelBtn, 8)
    stroke(cancelBtn, self.Theme.StrokeSoft, 1, 0.7)
    addRipple(cancelBtn, self.Theme.Muted)

    local confirmBtn = make("TextButton", {
        Name = "ConfirmBtn",
        Text = "Exit",
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        AutoButtonColor = false,
        BackgroundColor3 = self.Theme.Danger,
        BorderSizePixel = 0,
        Size = UDim2.new(0.5, -6, 1, 0),
        Parent = modalBtnRow,
    })
    corner(confirmBtn, 8)
    addRipple(confirmBtn, Color3.fromRGB(255, 255, 255))

    cancelBtn.MouseButton1Click:Connect(function()
        tween(confirmOverlay, 0.15, { BackgroundTransparency = 1 })
        local t = tween(confirmModal, 0.15, { Size = UDim2.fromOffset(250, 125) }, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        t.Completed:Connect(function()
            confirmOverlay.Visible = false
        end)
    end)

    confirmBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    -- Window Open / Close Animation Controller
    local isWindowVisible = true
    local isTransitioning = false

    local function getBaseScale(): number
        local camera = workspace.CurrentCamera
        local vp = (camera and camera.ViewportSize) or Vector2.new(1920, 1080)
        return self.ManualScale or calculateDeviceScale(self.DeviceType, vp, getTopInset())
    end

    local function animateOpen()
        if isTransitioning then return end
        if shadow.Visible and isWindowVisible then return end
        isTransitioning = true
        isWindowVisible = true

        if floatingOpenBtn.Visible then
            local hideBtnTween = tween(floatingOpenBtn, 0.16, { Size = UDim2.fromOffset(0, 0) }, Enum.EasingStyle.Back, Enum.EasingDirection.In)
            hideBtnTween.Completed:Connect(function()
                floatingOpenBtn.Visible = false
            end)
        end

        local targetScale = getBaseScale()
        clampWindowPosition(shadow, uiScale)

        shadow.Visible = true
        uiScale.Scale = targetScale * 0.85
        local basePos = shadow.Position
        shadow.Position = UDim2.new(basePos.X.Scale, basePos.X.Offset, basePos.Y.Scale, basePos.Y.Offset + 18)

        local scaleAnim = tween(uiScale, 0.30, { Scale = targetScale }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        local posAnim = tween(shadow, 0.30, { Position = basePos }, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

        scaleAnim.Completed:Connect(function()
            uiScale.Scale = targetScale
            shadow.Position = basePos
            clampWindowPosition(shadow, uiScale)
            isTransitioning = false
        end)
    end

    local function animateClose(showFloating: boolean?)
        if isTransitioning then return end
        if not shadow.Visible and not isWindowVisible then return end
        isTransitioning = true
        isWindowVisible = false

        local targetScale = getBaseScale()
        local basePos = shadow.Position
        local targetPos = UDim2.new(basePos.X.Scale, basePos.X.Offset, basePos.Y.Scale, basePos.Y.Offset + 16)

        local scaleAnim = tween(uiScale, 0.22, { Scale = targetScale * 0.82 }, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        local posAnim = tween(shadow, 0.22, { Position = targetPos }, Enum.EasingStyle.Quart, Enum.EasingDirection.In)

        scaleAnim.Completed:Connect(function()
            shadow.Visible = false
            shadow.Position = basePos
            uiScale.Scale = targetScale
            isTransitioning = false

            if showFloating ~= false then
                floatingOpenBtn.Visible = true
                floatingOpenBtn.Size = UDim2.fromOffset(0, 0)
                tween(floatingOpenBtn, 0.25, { Size = UDim2.fromOffset(54, 54) }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            end
        end)
    end

    local function toggleVisibility()
        if isWindowVisible then
            animateClose(true)
        else
            animateOpen()
        end
    end

    local resizeHandle = make("ImageButton", {
        Name = "ResizeHandle",
        AnchorPoint = Vector2.new(1, 1),
        Position = UDim2.new(1, -6, 1, -6),
        Size = UDim2.fromOffset(20, 20),
        BackgroundTransparency = 1,
        Image = Library.Assets.Resize,
        ImageColor3 = self.Theme.Muted,
        ImageTransparency = 0.5,
        ZIndex = 100,
        Parent = shadow,
    })
    bindResize(resizeHandle, shadow, Vector2.new(620, 420), uiScale)

    resizeHandle.MouseEnter:Connect(function()
        tween(resizeHandle, 0.15, { ImageTransparency = 0.1, ImageColor3 = self.Theme.Accent })
    end)
    resizeHandle.MouseLeave:Connect(function()
        tween(resizeHandle, 0.15, { ImageTransparency = 0.5, ImageColor3 = self.Theme.Muted })
    end)

    local sidebarWidth = 195
    local sidebar = make("Frame", {
        Name = "Sidebar",
        Size = UDim2.new(0, sidebarWidth, 1, 0),
        BackgroundColor3 = self.Theme.Sidebar,
        BackgroundTransparency = 0.25,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 5,
        Parent = root,
    })
    self.Sidebar = sidebar

    local sideDivider = make("Frame", {
        Name = "SideDivider",
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        Size = UDim2.new(0, 1, 1, 0),
        BackgroundColor3 = self.Theme.StrokeSoft,
        BackgroundTransparency = 0.7,
        BorderSizePixel = 0,
        Parent = sidebar,
    })

    local sideHeader = make("Frame", {
        Name = "SideHeader",
        Size = UDim2.new(1, 0, 0, 68),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Parent = sidebar,
    })
    bindDrag(sideHeader, shadow, uiScale)

    local sideLogoWrap = make("Frame", {
        Name = "SideLogoWrap",
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 12, 0.5, 0),
        Size = UDim2.fromOffset(32, 32),
        BackgroundColor3 = self.Theme.Surface,
        BackgroundTransparency = 0.3,
        BorderSizePixel = 0,
        Parent = sideHeader,
    })
    corner(sideLogoWrap, 8)
    stroke(sideLogoWrap, self.Theme.Accent, 1, 0.5)

    -- Guaranteed non-blank icon with built-in fallback
    local iconTarget = props.Icon or "autohub_icon.png"
    local resolvedIcon = normalizeAsset(iconTarget)
    if resolvedIcon == "" or resolvedIcon == "autohub_icon.png" then
        resolvedIcon = Library.Assets.ImageLogo or "rbxassetid://111362591084511"
    end
    local isCustomIcon = tostring(iconTarget):find("%.png") or tostring(iconTarget):find("%.jpg")
    local iconColor = isCustomIcon and Color3.fromRGB(255, 255, 255) or self.Theme.Accent
    local sideLogo = createIcon(sideLogoWrap, resolvedIcon, 20, iconColor, 0)
    sideLogo.AnchorPoint = Vector2.new(0.5, 0.5)
    sideLogo.Position = UDim2.fromScale(0.5, 0.5)

    -- AppTitle: contained strictly within sidebar with text truncate
    local sideAppTitle = make("TextLabel", {
        Name = "AppTitle",
        Text = appTitle,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = self.Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        TextWrapped = true,
        ClipsDescendants = true,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(52, 0),
        Size = UDim2.new(1, -58, 1, 0),
        Parent = sideHeader,
    })

    local tabContainer = make("ScrollingFrame", {
        Name = "TabContainer",
        Position = UDim2.fromOffset(0, 68),
        Size = UDim2.new(1, 0, 1, -160),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = self.Theme.Accent,
        CanvasSize = UDim2.fromOffset(0, 0),
        Active = true,
        Parent = sidebar,
    })
    padding(tabContainer, 10, 8, 10, 8)
    local tabLayout = list(tabContainer, 6)
    updateCanvas(tabContainer, tabLayout, 10)

    -- User Profile Widget
    local profileCard = make("Frame", {
        Name = "ProfileCard",
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 10, 1, -10),
        Size = UDim2.new(1, -20, 0, 74),
        BackgroundColor3 = self.Theme.Surface,
        BackgroundTransparency = 0.3,
        BorderSizePixel = 0,
        Parent = sidebar,
    })
    corner(profileCard, 10)
    stroke(profileCard, self.Theme.StrokeSoft, 1, 0.7)
    padding(profileCard, 10, 8, 10, 8)
    list(profileCard, 4)

    local pTopRow = make("Frame", {
        Name = "ProfileTop",
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundTransparency = 1,
        Parent = profileCard,
    })

    local pAvatarWrap = make("Frame", {
        Name = "AvatarWrap",
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 0, 0.5, 0),
        Size = UDim2.fromOffset(34, 34),
        BackgroundColor3 = self.Theme.Sidebar,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = pTopRow,
    })
    corner(pAvatarWrap, 17)
    local pAvatarStroke = stroke(pAvatarWrap, self.Theme.Accent, 1, 0.4)

    local pAvatarImage = make("ImageLabel", {
        Name = "Avatar",
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(LocalPlayer and LocalPlayer.UserId or 1) .. "&w=100&h=100",
        Parent = pAvatarWrap,
    })

    local pInfoWrap = make("Frame", {
        Name = "InfoWrap",
        Position = UDim2.fromOffset(42, 0),
        Size = UDim2.new(1, -42, 1, 0),
        BackgroundTransparency = 1,
        Parent = pTopRow,
    })
    local pInfoLayout = list(pInfoWrap, 2)
    pInfoLayout.VerticalAlignment = Enum.VerticalAlignment.Center

    local pUsernameLabel = make("TextLabel", {
        Name = "Username",
        Text = LocalPlayer and LocalPlayer.Name or "User",
        Font = Enum.Font.GothamBold,
        TextSize = 15,
        TextColor3 = self.Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 18),
        Parent = pInfoWrap,
    })

    local pBadgePill = make("Frame", {
        Name = "BadgePill",
        Size = UDim2.fromOffset(0, 16),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = self.Theme.AccentSoft,
        BorderSizePixel = 0,
        Parent = pInfoWrap,
    })
    corner(pBadgePill, 4)
    padding(pBadgePill, 6, 0, 6, 0)

    local pBadgeText = make("TextLabel", {
        Name = "BadgeText",
        Text = "VIP ACCESS",
        Font = Enum.Font.GothamBold,
        TextSize = 10,
        TextColor3 = self.Theme.Accent,
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(0, 16),
        AutomaticSize = Enum.AutomaticSize.X,
        Parent = pBadgePill,
    })

    local pTimeLabel = make("TextLabel", {
        Name = "TimeLeft",
        Text = "Time left: 23h 45m",
        Font = Enum.Font.GothamMedium,
        TextSize = 12,
        TextColor3 = self.Theme.Muted,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 16),
        Parent = profileCard,
    })

    function self:UserProfile(userProps: { [string]: any })
        userProps = userProps or {}
        if userProps.Username then pUsernameLabel.Text = tostring(userProps.Username) end
        if userProps.Badge then pBadgeText.Text = string.upper(tostring(userProps.Badge)) end
        if userProps.TimeLeft then pTimeLabel.Text = "Time left: " .. tostring(userProps.TimeLeft) end
        if userProps.AvatarId then
            pAvatarImage.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(userProps.AvatarId) .. "&w=100&h=100"
        end
        return {
            SetUsername = function(_, name: string) pUsernameLabel.Text = name end,
            SetBadge    = function(_, badge: string) pBadgeText.Text = string.upper(badge) end,
            SetTimeLeft = function(_, timeStr: string) pTimeLabel.Text = "Time left: " .. timeStr end,
            SetAvatar   = function(_, id: number) pAvatarImage.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(id) .. "&w=100&h=100" end,
        }
    end

    local contentArea = make("Frame", {
        Name = "ContentArea",
        Position = UDim2.new(0, sidebarWidth, 0, 68),
        Size = UDim2.new(1, -sidebarWidth, 1, -68),
        BackgroundTransparency = 1,
        Parent = root,
    })

    local topBar = make("Frame", {
        Name = "TopBar",
        Position = UDim2.new(0, sidebarWidth, 0, 0),
        Size = UDim2.new(1, -sidebarWidth, 0, 68),
        BackgroundTransparency = 1,
        Parent = root,
    })
    bindDrag(topBar, shadow, uiScale)

    local topDivider = make("Frame", {
        Name = "TopDivider",
        Position = UDim2.new(0, 0, 1, -1),
        Size = UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = self.Theme.StrokeSoft,
        BackgroundTransparency = 0.7,
        BorderSizePixel = 0,
        Parent = topBar,
    })

    local breadcrumbWrap = make("Frame", {
        Name = "BreadcrumbWrap",
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 18, 0.5, 0),
        Size = UDim2.new(1, -190, 0, 42),
        BackgroundTransparency = 1,
        Parent = topBar,
    })
    local bLayout = list(breadcrumbWrap, 2)
    bLayout.VerticalAlignment = Enum.VerticalAlignment.Center

    local breadcrumbLabel = make("TextLabel", {
        Name = "Breadcrumb",
        Text = "OVERVIEW",
        Font = Enum.Font.GothamBold,
        TextSize = 15,
        TextColor3 = self.Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 18),
        Parent = breadcrumbWrap,
    })

    local descLabelRef = make("TextLabel", {
        Name = "Subtitle",
        Text = tostring(props.Desc or props.Subtitle or "LOBBY : System Ready"),
        Font = Enum.Font.GothamMedium,
        TextSize = 12,
        TextColor3 = self.Theme.Muted,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 15),
        Parent = breadcrumbWrap,
    })

    local controls = make("Frame", {
        Name = "Controls",
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -14, 0.5, 0),
        Size = UDim2.fromOffset(156, 32),
        BackgroundTransparency = 1,
        Parent = topBar,
    })
    list(controls, 6, Enum.FillDirection.Horizontal)

    local function makeTopBtn(name: string, icon: string, callback: () -> ())
        local btn = make("ImageButton", {
            Name = name,
            Image = normalizeAsset(icon),
            ImageColor3 = self.Theme.Muted,
            BackgroundColor3 = self.Theme.Surface,
            BackgroundTransparency = 0.4,
            BorderSizePixel = 0,
            Size = UDim2.fromOffset(28, 28),
            AutoButtonColor = false,
            Parent = controls,
        })
        corner(btn, 7)
        local btnStroke = stroke(btn, self.Theme.StrokeSoft, 1, 0.8)

        btn.MouseEnter:Connect(function()
            tween(btn, 0.15, { BackgroundTransparency = 0.1, ImageColor3 = self.Theme.Text })
            tween(btnStroke, 0.15, { Color = self.Theme.Accent, Transparency = 0.4 })
        end)
        btn.MouseLeave:Connect(function()
            tween(btn, 0.15, { BackgroundTransparency = 0.4, ImageColor3 = self.Theme.Muted })
            tween(btnStroke, 0.15, { Color = self.Theme.StrokeSoft, Transparency = 0.8 })
        end)
        btn.MouseButton1Click:Connect(callback)
        return btn
    end

    makeTopBtn("HideBtn", "Hide", function()
        animateClose(true)
        self:Notify({ Title = "UI Minimized", Desc = "Click floating badge or press keybind to restore.", Duration = 2 })
    end)

    local minimized = false
    local originalSize = shadow.Size
    makeTopBtn("MinimizeBtn", "Minimize", function()
        minimized = not minimized
        if minimized then
            originalSize = shadow.Size
            resizeHandle.Visible = false
            tween(shadow, 0.2, { Size = UDim2.fromOffset(originalSize.X.Offset, 68) })
            contentArea.Visible = false
            sidebar.Visible = false
        else
            contentArea.Visible = true
            sidebar.Visible = true
            tween(shadow, 0.2, { Size = originalSize })
            task.delay(0.2, function()
                resizeHandle.Visible = true
            end)
        end
    end)

    makeTopBtn("ThemeBtn", "Theme", function()
        local currentIdx = table.find(THEME_ORDER, self.ThemeName) or 1
        local nextIdx = (currentIdx % #THEME_ORDER) + 1
        local nextThemeName = THEME_ORDER[nextIdx]
        self:SetTheme(nextThemeName)
        self:Notify({
            Title = "Theme Shift",
            Desc = "Switched theme to: " .. nextThemeName,
            Duration = 2,
        })
    end)

    makeTopBtn("DiscordBtn", "Discord", function()
        if setclipboard then
            pcall(setclipboard, props.DiscordLink or "https://discord.gg")
            self:Notify({
                Title = "Link Copied",
                Desc = "Discord invite copied to clipboard!",
                Duration = 2,
            })
        end
    end)

    makeTopBtn("CloseBtn", "Close", function()
        confirmOverlay.BackgroundTransparency = 1
        confirmOverlay.Visible = true
        confirmModal.Size = UDim2.fromOffset(250, 125)
        tween(confirmOverlay, 0.20, { BackgroundTransparency = 0.65 })
        tween(confirmModal, 0.25, { Size = UDim2.fromOffset(320, 160) }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    end)

    floatingOpenBtn.MouseButton1Click:Connect(function()
        animateOpen()
    end)

    local pages = make("Frame", {
        Name = "Pages",
        Position = UDim2.fromOffset(16, 12),
        Size = UDim2.new(1, -32, 1, -24),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Parent = contentArea,
    })

    function self:SetTitle(newTitle: string)
        appTitle = newTitle
        sideAppTitle.Text = newTitle
        if self.SelectedTab then
            breadcrumbLabel.Text = string.upper(self.SelectedTab)
        end
    end

    function self:SetSubtitle(newSub: string)
        descLabelRef.Text = newSub
    end
    self.SetSub = self.SetSubtitle

    function self:SetTheme(themeNameOrTable: any)
        self.Theme = resolveTheme(themeNameOrTable)
        if type(themeNameOrTable) == "string" then
            self.ThemeName = themeNameOrTable
        end

        root.BackgroundColor3 = self.Theme.Background
        topGlow.BackgroundColor3 = self.Theme.Accent
        if borderGradient and not self.CustomBorderGradient then
            borderGradient.Color = createDefaultBorderSequence(self.Theme)
        end
        if bgGradient then
            bgGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0.00, self.Theme.Background),
                ColorSequenceKeypoint.new(0.35, self.Theme.Sidebar),
                ColorSequenceKeypoint.new(0.70, Color3.fromRGB(18, 20, 32)),
                ColorSequenceKeypoint.new(1.00, self.Theme.Background),
            })
        end
        if ambientGlow then
            ambientGlow.ImageColor3 = self.Theme.Accent
        end
        sidebar.BackgroundColor3 = self.Theme.Sidebar
        sideDivider.BackgroundColor3 = self.Theme.StrokeSoft
        topDivider.BackgroundColor3 = self.Theme.StrokeSoft
        sideLogo.ImageColor3 = self.Theme.Accent
        sideLogoWrap.UIStroke.Color = self.Theme.Accent
        pAvatarStroke.Color = self.Theme.Accent
        pBadgePill.BackgroundColor3 = self.Theme.AccentSoft
        pBadgeText.TextColor3 = self.Theme.Accent
        floatingOpenBtn.ImageColor3 = self.Theme.Accent
        floatingOpenBtn.UIStroke.Color = self.Theme.Accent

        if self.SelectedTab then
            self:SelectTab(self.SelectedTab)
        end
    end

    function self:SelectTab(name: string)
        for tabName, tab in pairs(self.Tabs) do
            local selected = tabName == name
            
            if selected then
                tab.Page.Visible = true
                tab.Page.Position = UDim2.new(0, 10, 0, 0)
                tab.Page.BackgroundTransparency = 1
                tween(tab.Page, 0.22, { Position = UDim2.fromScale(0, 0) }, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            else
                tab.Page.Visible = false
            end

            tween(tab.Button, 0.18, {
                BackgroundColor3 = selected and self.Theme.Surface or self.Sidebar.BackgroundColor3,
                BackgroundTransparency = selected and 0.1 or 1,
            })
            if tab.Indicator then
                tween(tab.Indicator, 0.18, {
                    BackgroundTransparency = selected and 0 or 1,
                    Size = selected and UDim2.new(0, 3, 0.55, 0) or UDim2.new(0, 3, 0, 0),
                })
            end
            if tab.TitleLabel then
                tab.TitleLabel.TextColor3 = selected and self.Theme.Text or self.Theme.Muted
            end
            if tab.DescLabel then
                tab.DescLabel.TextColor3 = selected and self.Theme.Accent or Color3.fromRGB(110, 125, 150)
            end
            if tab.Icon then
                tab.Icon.ImageColor3 = selected and self.Theme.Accent or self.Theme.Muted
            end
        end
        self.SelectedTab = name
        breadcrumbLabel.Text = string.upper(name)
    end

    function self:Tab(tabProps: { [string]: any })
        tabProps = tabProps or {}
        local name = tostring(tabProps.Title or ("Tab " .. tostring(#self.Tabs + 1)))
        local subDesc = tostring(tabProps.Subtitle or tabProps.Desc or "Active Module")
        local tabIconAsset = normalizeAsset(tabProps.Icon or "Home")
        local hasTabIcon = tabIconAsset ~= ""

        local tabButton = make("TextButton", {
            Name = "Tab_" .. name,
            Text = "",
            AutoButtonColor = false,
            Size = UDim2.new(1, 0, 0, 52),
            BackgroundColor3 = self.Theme.Sidebar,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Parent = tabContainer,
        })
        corner(tabButton, 8)
        addRipple(tabButton, self.Theme.Accent)

        local tabIndicator = make("Frame", {
            Name = "ActiveIndicator",
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, 2, 0.5, 0),
            Size = UDim2.new(0, 3, 0.55, 0),
            BackgroundColor3 = self.Theme.Accent,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Parent = tabButton,
        })
        corner(tabIndicator, 2)

        local tabIcon = createIcon(tabButton, tabIconAsset, 20, self.Theme.Muted, 0)
        tabIcon.AnchorPoint = Vector2.new(0, 0.5)
        tabIcon.Position = UDim2.new(0, 14, 0.5, 0)

        local textWrap = make("Frame", {
            Name = "TextWrap",
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, hasTabIcon and 44 or 14, 0.5, 0),
            Size = UDim2.new(1, -(hasTabIcon and 50 or 18), 1, -8),
            BackgroundTransparency = 1,
            Parent = tabButton,
        })
        local tLayout = list(textWrap, 2)
        tLayout.VerticalAlignment = Enum.VerticalAlignment.Center

        local titleLabel = make("TextLabel", {
            Name = "Title",
            Text = name,
            Font = Enum.Font.GothamBold,
            TextSize = 15,
            TextColor3 = self.Theme.Muted,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 18),
            Parent = textWrap,
        })

        local descLabel = make("TextLabel", {
            Name = "Desc",
            Text = subDesc,
            Font = Enum.Font.GothamMedium,
            TextSize = 12,
            TextColor3 = Color3.fromRGB(110, 125, 150),
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 15),
            Parent = textWrap,
        })

        local page = make("ScrollingFrame", {
            Name = "Page_" .. name,
            Size = UDim2.new(1, -4, 1, -6),
            Position = UDim2.fromOffset(0, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            AutomaticCanvasSize = Enum.AutomaticSize.None,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            ScrollBarThickness = 2,
            ScrollBarImageColor3 = self.Theme.Accent,
            ScrollBarImageTransparency = 0.55,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false,
            Active = true,
            Parent = pages,
        })
        padding(page, 6, 4, 12, 16)
        local pageLayout = list(page, 10)
        updateCanvas(page, pageLayout, 30)

        local pageApi = createPageApi(self, page)
        pageApi.Name = name

        self.Tabs[name] = {
            Button      = tabButton,
            Indicator   = tabIndicator,
            TitleLabel  = titleLabel,
            DescLabel   = descLabel,
            Icon        = tabIcon,
            Page        = page,
            Api         = pageApi,
        }

        tabButton.MouseButton1Click:Connect(function()
            self:SelectTab(name)
        end)

        if not self.SelectedTab then
            self:SelectTab(name)
        end

        return pageApi
    end

    function self:Notify(toastProps: { [string]: any })
        toastProps = toastProps or {}
        local toast = make("Frame", {
            Name = "Toast",
            AnchorPoint = Vector2.new(1, 1),
            Position = UDim2.new(1, -16, 1, -16),
            Size = UDim2.fromOffset(300, 72),
            BackgroundColor3 = self.Theme.Surface,
            BackgroundTransparency = 0.1,
            BorderSizePixel = 0,
            ZIndex = 50,
            Parent = root,
        })
        corner(toast, 10)
        stroke(toast, self.Theme.StrokeSoft, 1, 0.6)
        padding(toast, 14, 10, 14, 10)

        local accentLine = make("Frame", {
            Name = "AccentLine",
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, -10, 0.5, 0),
            Size = UDim2.new(0, 3, 0.6, 0),
            BackgroundColor3 = toastProps.Color or self.Theme.Accent,
            BorderSizePixel = 0,
            Parent = toast,
        })
        corner(accentLine, 2)

        local toastContent = make("Frame", {
            Name = "ToastContent",
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            Parent = toast,
        })
        list(toastContent, 3)

        createText(toastContent, "ToastTitle", tostring(toastProps.Title or "Notification"), 15, toastProps.Color or self.Theme.Text, true, 1)
        createText(toastContent, "ToastDesc", tostring(toastProps.Desc or toastProps.Message or ""), 13, self.Theme.Muted, false, 2)

        toast.BackgroundTransparency = 1
        toast.Position = UDim2.new(1, 340, 1, -16)
        tween(toast, 0.25, {
            BackgroundTransparency = 0.1,
            Position = UDim2.new(1, -16, 1, -16),
        }, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

        task.delay(toastProps.Duration or 3, function()
            if toast.Parent then
                tween(toast, 0.2, {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, 340, 1, -16),
                }, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
                task.wait(0.22)
                if toast then toast:Destroy() end
            end
        end)
        return toast
    end

    function self:SetVisible(val: boolean)
        if val then
            animateOpen()
        else
            animateClose(false)
        end
    end

    function self:Destroy()
        if animConn then
            animConn:Disconnect()
            animConn = nil
        end
        screenGui:Destroy()
    end

    UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == self.Keybind then
            toggleVisibility()
        end
    end)

    clampWindowPosition(shadow, uiScale)

    -- Smooth entrance animation on startup
    task.spawn(function()
        animateOpen()
    end)

    return self
end

return Library
