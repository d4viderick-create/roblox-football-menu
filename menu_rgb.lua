-- Script de Menu RGB para Roblox Football
-- Coloque este script em StarterGui

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- ===== CONFIGURAÇÕES =====
local MENU_WIDTH = 300
local MENU_HEIGHT = 400
local RGB_SPEED = 2 -- Velocidade da animação RGB
local DRAG_SENSITIVITY = 1.5

-- ===== CRIAR GUI =====
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FootballMenu"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Painel principal
local mainPanel = Instance.new("Frame")
mainPanel.Name = "MainPanel"
mainPanel.Size = UDim2.new(0, MENU_WIDTH, 0, MENU_HEIGHT)
mainPanel.Position = UDim2.new(0.5, -MENU_WIDTH/2, 0.5, -MENU_HEIGHT/2)
mainPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainPanel.BorderSizePixel = 0
mainPanel.Parent = screenGui

-- Adicionar borda RGB animada
local border = Instance.new("UIStroke")
border.Thickness = 3
border.Parent = mainPanel

-- Barra de título com RGB
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainPanel

local titleStroke = Instance.new("UIStroke")
titleStroke.Thickness = 2
titleStroke.Parent = titleBar

-- Texto do título
local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(1, -80, 1, 0)
titleText.BackgroundTransparency = 1
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextSize = 18
titleText.Font = Enum.Font.GothamBold
titleText.Text = "⚽ FOOTBALL MENU"
titleText.Parent = titleBar

-- Botão Minimizar
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Name = "MinimizeBtn"
minimizeBtn.Size = UDim2.new(0, 35, 0, 35)
minimizeBtn.Position = UDim2.new(1, -75, 0, 2.5)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimizeBtn.TextColor3 = Color3.fromRGB(255, 200, 0)
minimizeBtn.TextSize = 20
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.Text = "−"
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Parent = titleBar

-- Botão Fechar
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -35, 0, 2.5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 20
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "✕"
closeBtn.BorderSizePixel = 0
closeBtn.Parent = titleBar

-- Conteúdo do menu
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, 0, 1, -40)
contentFrame.Position = UDim2.new(0, 0, 0, 40)
contentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainPanel

-- Adicionar padding
local padding = Instance.new("UIPadding")
padding.PaddingLeft = UDim.new(0, 15)
padding.PaddingRight = UDim.new(0, 15)
padding.PaddingTop = UDim.new(0, 15)
padding.PaddingBottom = UDim.new(0, 15)
padding.Parent = contentFrame

-- Lista de opções
local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 10)
listLayout.Parent = contentFrame

-- Função para criar botões do menu
local function createMenuButton(text, parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextSize = 14
    btn.Font = Enum.Font.Gotham
    btn.Text = text
    btn.BorderSizePixel = 0
    btn.Parent = parent
    
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Thickness = 1
    btnStroke.Color = Color3.fromRGB(100, 100, 100)
    btnStroke.Parent = btn
    
    -- Hover effect
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end)
    
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end)
    
    return btn
end

-- Adicionar botões de exemplo
createMenuButton("⚽ Chute Normal", contentFrame)
createMenuButton("🔥 Super Chute", contentFrame)
createMenuButton("🎯 Passe Preciso", contentFrame)
createMenuButton("⚙️ Configurações", contentFrame)
createMenuButton("❓ Ajuda", contentFrame)

-- ===== VARIÁVEIS DE ESTADO =====
local isMinimized = false
local isDragging = false
local dragStart = nil
local panelStart = nil
local hueOffset = 0

-- ===== FUNÇÕES DE ANIMAÇÃO RGB =====
local function updateRGBColor()
    hueOffset = (hueOffset + RGB_SPEED) % 360
    
    -- Calcular cores HSV para RGB
    local h = hueOffset / 360
    local s = 0.8
    local v = 1
    
    local c = v * s
    local x = c * (1 - math.abs((h * 6) % 2 - 1))
    local m = v - c
    
    local r, g, b = 0, 0, 0
    
    if h < 1/6 then
        r, g, b = c, x, 0
    elseif h < 2/6 then
        r, g, b = x, c, 0
    elseif h < 3/6 then
        r, g, b = 0, c, x
    elseif h < 4/6 then
        r, g, b = 0, x, c
    elseif h < 5/6 then
        r, g, b = x, 0, c
    else
        r, g, b = c, 0, x
    end
    
    local color = Color3.fromRGB(
        math.floor((r + m) * 255),
        math.floor((g + m) * 255),
        math.floor((b + m) * 255)
    )
    
    border.Color = color
    titleStroke.Color = color
end

-- ===== FUNÇÕES DE MINIMIZAR/FECHAR =====
local function toggleMinimize()
    isMinimized = not isMinimized
    
    if isMinimized then
        contentFrame.Visible = false
        mainPanel.Size = UDim2.new(0, MENU_WIDTH, 0, 40)
        minimizeBtn.Text = "+"
    else
        contentFrame.Visible = true
        mainPanel.Size = UDim2.new(0, MENU_WIDTH, 0, MENU_HEIGHT)
        minimizeBtn.Text = "−"
    end
end

local function closeMenu()
    screenGui:Destroy()
end

-- ===== FUNÇÕES DE MOVIMENTO =====
local function startDrag(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local mousePos = UserInputService:GetMouseLocation()
        local titleBarPos = titleBar.AbsolutePosition
        local titleBarSize = titleBar.AbsoluteSize
        
        -- Verifica se clicou na barra de título
        if mousePos.X >= titleBarPos.X and 
           mousePos.X <= titleBarPos.X + titleBarSize.X and
           mousePos.Y >= titleBarPos.Y and 
           mousePos.Y <= titleBarPos.Y + titleBarSize.Y then
            
            -- Verifica se não clicou nos botões
            if not (mousePos.X > minimizeBtn.AbsolutePosition.X and 
                    mousePos.X < closeBtn.AbsolutePosition.X + closeBtn.AbsoluteSize.X) then
                
                isDragging = true
                dragStart = mousePos
                panelStart = mainPanel.Position
            end
        end
    end
end

local function updateDrag()
    if isDragging and dragStart then
        local mousePos = UserInputService:GetMouseLocation()
        local delta = Vector2.new(
            mousePos.X - dragStart.X,
            mousePos.Y - dragStart.Y
        )
        
        mainPanel.Position = UDim2.new(
            panelStart.X.Scale,
            panelStart.X.Offset + delta.X,
            panelStart.Y.Scale,
            panelStart.Y.Offset + delta.Y
        )
    end
end

local function endDrag()
    isDragging = false
end

-- ===== CONEXÕES DE INPUT =====
UserInputService.InputBegan:Connect(startDrag)
UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        endDrag()
    end
end)

-- ===== CONEXÕES DE BOTÕES =====
minimizeBtn.MouseButton1Click:Connect(toggleMinimize)
closeBtn.MouseButton1Click:Connect(closeMenu)

-- ===== LOOP DE ANIMAÇÃO =====
RunService.RenderStepped:Connect(function()
    updateRGBColor()
    updateDrag()
end)

print("✅ Menu RGB carregado com sucesso!")
