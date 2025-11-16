-- c00lgui LIBRARY v3.5 | By Grok | 2025 | Keyless | Mobile OK
-- https://github.com/grok-ai/c00lgui-library
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/grok-ai/c00lgui-library/main/c00lgui.lua"))()

local c00lgui = {}
c00lgui.Version = "3.5"
c00lgui.Author = "Grok"
c00lgui.Keybind = Enum.KeyCode.Insert

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

-- Criar GUI Base
local function CreateBase()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "c00lgui_Library"
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 999

    -- Matrix Rain Background
    local MatrixBG = Instance.new("Frame")
    MatrixBG.Name = "MatrixBG"
    MatrixBG.Parent = ScreenGui
    MatrixBG.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MatrixBG.Size = UDim2.new(1, 0, 1, 0)
    MatrixBG.ZIndex = 0
    task.spawn(function()
        while MatrixBG.Parent do
            local lbl = Instance.new("TextLabel", MatrixBG)
            lbl.Text = string.char(math.random(33, 126))
            lbl.TextColor3 = Color3.fromRGB(0, math.random(100, 255), 0)
            lbl.Font = Enum.Font.Code
            lbl.TextSize = math.random(10, 18)
            lbl.Position = UDim2.new(math.random(), 0, 0, 0)
            lbl.BackgroundTransparency = 1
            lbl.Size = UDim2.new(0, 15, 0, 15)
            TweenService:Create(lbl, TweenInfo.new(math.random(2, 5), Enum.EasingStyle.Linear), {
                Position = UDim2.new(math.random(), 0, 1, 0),
                TextTransparency = 1
            }):Play()
            game:GetService("Debris"):AddItem(lbl, 5)
            task.wait(0.08)
        end
    end)

    return ScreenGui
end

-- Criar Janela
function c00lgui:Create(title, callback)
    local ScreenGui = CreateBase()
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.02, 0, 0.1, 0)
    MainFrame.Size = UDim2.new(0, 360, 0, 520)
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Visible = false

    local Glow = Instance.new("UIStroke", MainFrame)
    Glow.Color = Color3.fromRGB(0, 255, 0)
    Glow.Thickness = 4
    Glow.Transparency = 0.4

    local Corner = Instance.new("UICorner", MainFrame)
    Corner.CornerRadius = UDim.new(0, 14)

    local Title = Instance.new("TextLabel")
    Title.Parent = MainFrame
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = "c00lgui | " .. title
    Title.TextColor3 = Color3.fromRGB(0, 255, 0)
    Title.TextScaled = true
    Title.TextStrokeTransparency = 0

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Parent = MainFrame
    CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    CloseBtn.Position = UDim2.new(1, -50, 0, 8)
    CloseBtn.Size = UDim2.new(0, 42, 0, 34)
    CloseBtn.Font = Enum.Font.SourceSansBold
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextScaled = true
    local CloseCorner = Instance.new("UICorner", CloseBtn)
    CloseCorner.CornerRadius = UDim.new(0, 6)

    local Scroll = Instance.new("ScrollingFrame")
    Scroll.Parent = MainFrame
    Scroll.BackgroundTransparency = 1
    Scroll.Position = UDim2.new(0, 15, 0, 60)
    Scroll.Size = UDim2.new(1, -30, 1, -75)
    Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    Scroll.ScrollBarThickness = 8
    Scroll.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 0)

    local List = Instance.new("UIListLayout")
    List.Parent = Scroll
    List.Padding = UDim.new(0, 9)
    List.SortOrder = Enum.SortOrder.LayoutOrder

    -- Auto-resize canvas
    List:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Scroll.CanvasSize = UDim2.new(0, 0, 0, List.AbsoluteContentSize.Y + 20)
    end)

    -- UI Object
    local ui = {}

    function ui:Toggle(name, default, callback)
        local state = default or false
        local Btn = Instance.new("TextButton")
        Btn.Parent = Scroll
        Btn.Background
