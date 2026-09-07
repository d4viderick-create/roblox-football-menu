-- Script de Menu RGB para Roblox Football
-- Coloque este script em StarterGui

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- ===== CONFIGURAÇÕES =====
local MENU_WIDTH = 350
local MENU_HEIGHT = 650
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

-- Adicionar borda com cor rosa claro/preto
local border = Instance.new("UIStroke")
border.Thickness = 3
border.Color = Color3.fromRGB(255, 192, 203) -- Rosa claro
border.Parent = mainPanel

-- Barra de título com RGB
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 50)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainPanel

local titleStroke = Instance.new("UIStroke")
titleStroke.Thickness = 2
titleStroke.Color = Color3.fromRGB(255, 192, 203) -- Rosa claro
titleStroke.Parent = titleBar

-- Texto do título RGB "XERECA HUB"
local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(1, -80, 1, 0)
titleText.BackgroundTransparency = 1
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextSize = 22
titleText.Font = Enum.Font.GothamBold
titleText.Text = "XERECA HUB"
titleText.Parent = titleBar

-- Botão Minimizar
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Name = "MinimizeBtn"
minimizeBtn.Size = UDim2.new(0, 35, 0, 35)
minimizeBtn.Position = UDim2.new(1, -75, 0, 7.5)
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
closeBtn.Position = UDim2.new(1, -35, 0, 7.5)
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
contentFrame.Size = UDim2.new(1, 0, 1, -50)
contentFrame.Position = UDim2.new(0, 0, 0, 50)
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

-- ScrollingFrame para melhor organização
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ScrollFrame"
scrollFrame.Size = UDim2.new(1, 0, 1, 0)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 6
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
scrollFrame.Parent = contentFrame

-- Lista principal
local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 12)
listLayout.Parent = scrollFrame

-- ===== ESTADO DAS FUNÇÕES =====
local functionsState = {
    autoDrible = false,
    autoCarrinho = false,
    autoCatch = false,
    espBola = false
}

-- ===== FUNÇÃO PARA AUTO DRIBLE =====
local function setupAutoDrible()
    if not functionsState.autoDrible then return end
    
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character then return end
    
    -- Implementar lógica de auto drible
    -- Detectar jogadores do outro time próximos
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            local otherChar = otherPlayer.Character
            local otherRoot = otherChar:FindFirstChild("HumanoidRootPart")
            
            if otherRoot then
                local distance = (humanoidRootPart.Position - otherRoot.Position).Magnitude
                
                -- Se jogador está próximo (menos de 20 studs)
                if distance < 20 and distance > 0 then
                    -- Executar ação de drible
                    local args = {
                        [1] = humanoidRootPart.Position + humanoidRootPart.CFrame.LookVector * 15
                    }
                    
                    -- Enviar evento de drible (ajuste conforme seu jogo)
                    if game:FindFirstChild("Remotes") then
                        local dribeEvent = game.Remotes:FindFirstChild("Drible")
                        if dribeEvent then
                            dribeEvent:FireServer(args[1])
                        end
                    end
                end
            end
        end
    end
end

-- ===== FUNÇÃO PARA AUTO CARRINHO =====
local function setupAutoCarrinho()
    if not functionsState.autoCarrinho then return end
    
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    -- Detectar se o jogador tem a bola
    local ball = workspace:FindFirstChild("Ball")
    
    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            local otherChar = otherPlayer.Character
            local otherRoot = otherChar:FindFirstChild("HumanoidRootPart")
            
            if otherRoot then
                local distance = (humanoidRootPart.Position - otherRoot.Position).Magnitude
                
                -- Se está muito próximo do adversário
                if distance < 15 and distance > 0 then
                    -- Executar ação de carrinho
                    if game:FindFirstChild("Remotes") then
                        local carrinhoEvent = game.Remotes:FindFirstChild("Carrinho")
                        if carrinhoEvent then
                            carrinhoEvent:FireServer()
                        end
                    end
                end
            end
        end
    end
end

-- ===== FUNÇÃO PARA AUTO CATCH =====
local function setupAutoCatch()
    if not functionsState.autoCatch then return end
    
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local ball = workspace:FindFirstChild("Ball")
    
    if ball then
        local distance = (humanoidRootPart.Position - ball.Position).Magnitude
        
        -- Se a bola está próxima (menos de 30 studs)
        if distance < 30 and distance > 0 then
            -- Executar ação de pegar a bola automaticamente
            if game:FindFirstChild("Remotes") then
                local catchEvent = game.Remotes:FindFirstChild("Catch") or game.Remotes:FindFirstChild("Pegar")
                if catchEvent then
                    catchEvent:FireServer(ball)
                end
            end
        end
    end
end

-- ===== FUNÇÃO PARA ESP DE BOLA =====
local function setupESPBola()
    local ball = workspace:FindFirstChild("Ball")
    
    if ball then
        if functionsState.espBola then
            -- Criar ou atualizar ESP da bola
            local espLabel = ball:FindFirstChild("ESPLabel")
            
            if not espLabel then
                espLabel = Instance.new("BillboardGui")
                espLabel.Name = "ESPLabel"
                espLabel.Size = UDim2.new(4, 0, 2, 0)
                espLabel.MaxDistance = 500
                espLabel.Parent = ball
                
                local textLabel = Instance.new("TextLabel")
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.BackgroundTransparency = 0.3
                textLabel.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                textLabel.TextSize = 14
                textLabel.Font = Enum.Font.GothamBold
                textLabel.Text = "⚽ BOLA"
                textLabel.Parent = espLabel
            end
        else
            -- Remover ESP da bola
            local espLabel = ball:FindFirstChild("ESPLabel")
            if espLabel then
                espLabel:Destroy()
            end
        end
    end
end

-- ===== FUNÇÃO PARA CRIAR CATEGORIAS =====
local function createCategory(categoryName, icon)
    -- Container da categoria
    local categoryContainer = Instance.new("Frame")
    categoryContainer.Name = categoryName .. "Container"
    categoryContainer.Size = UDim2.new(1, 0, 0, 0)
    categoryContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    categoryContainer.BorderSizePixel = 0
    categoryContainer.Parent = scrollFrame
    
    local categoryStroke = Instance.new("UIStroke")
    categoryStroke.Thickness = 2
    categoryStroke.Color = Color3.fromRGB(255, 192, 203) -- Rosa claro
    categoryStroke.Parent = categoryContainer
    
    -- Padding do container
    local containerPadding = Instance.new("UIPadding")
    containerPadding.PaddingLeft = UDim.new(0, 12)
    containerPadding.PaddingRight = UDim.new(0, 12)
    containerPadding.PaddingTop = UDim.new(0, 10)
    containerPadding.PaddingBottom = UDim.new(0, 10)
    containerPadding.Parent = categoryContainer
    
    -- Cabeçalho da categoria (ícone + nome)
    local headerFrame = Instance.new("Frame")
    headerFrame.Name = "Header"
    headerFrame.Size = UDim2.new(1, 0, 0, 35)
    headerFrame.BackgroundTransparency = 1
    headerFrame.Parent = categoryContainer
    
    local headerLayout = Instance.new("UIListLayout")
    headerLayout.FillDirection = Enum.FillDirection.Horizontal
    headerLayout.Padding = UDim.new(0, 10)
    headerLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    headerLayout.Parent = headerFrame
    
    -- Ícone (casinha)
    local houseIcon = Instance.new("TextLabel")
    houseIcon.Name = "HouseIcon"
    houseIcon.Size = UDim2.new(0, 40, 0, 35)
    houseIcon.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    houseIcon.TextColor3 = Color3.fromRGB(255, 150, 0)
    houseIcon.TextSize = 24
    houseIcon.Font = Enum.Font.GothamBold
    houseIcon.Text = icon
    houseIcon.BorderSizePixel = 0
    houseIcon.Parent = headerFrame
    
    local houseStroke = Instance.new("UIStroke")
    houseStroke.Thickness = 1
    houseStroke.Color = Color3.fromRGB(255, 192, 203)
    houseStroke.Parent = houseIcon
    
    -- Nome da categoria
    local categoryLabel = Instance.new("TextLabel")
    categoryLabel.Name = "CategoryLabel"
    categoryLabel.Size = UDim2.new(1, -60, 0, 35)
    categoryLabel.BackgroundTransparency = 1
    categoryLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    categoryLabel.TextSize = 16
    categoryLabel.Font = Enum.Font.GothamBold
    categoryLabel.Text = categoryName
    categoryLabel.TextXAlignment = Enum.TextXAlignment.Left
    categoryLabel.Parent = headerFrame
    
    return categoryContainer
end

-- ===== FUNÇÃO PARA CRIAR FUNÇÕES NA CATEGORIA =====
local function addFunctionToCategory(categoryContainer, functionName, functionKey)
    -- Frame para a função
    local functionFrame = Instance.new("Frame")
    functionFrame.Name = functionName .. "Frame"
    functionFrame.Size = UDim2.new(1, 0, 0, 45)
    functionFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    functionFrame.BorderSizePixel = 0
    functionFrame.Parent = categoryContainer
    
    local funcStroke = Instance.new("UIStroke")
    funcStroke.Thickness = 1
    funcStroke.Color = Color3.fromRGB(255, 192, 203)
    funcStroke.Parent = functionFrame
    
    local funcPadding = Instance.new("UIPadding")
    funcPadding.PaddingLeft = UDim.new(0, 10)
    funcPadding.PaddingRight = UDim.new(0, 10)
    funcPadding.Parent = functionFrame
    
    local funcLayout = Instance.new("UIListLayout")
    funcLayout.FillDirection = Enum.FillDirection.Horizontal
    funcLayout.Padding = UDim.new(0, 10)
    funcLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    funcLayout.Parent = functionFrame
    
    -- Nome da função
    local funcLabel = Instance.new("TextLabel")
    funcLabel.Name = "FuncLabel"
    funcLabel.Size = UDim2.new(1, -70, 1, 0)
    funcLabel.BackgroundTransparency = 1
    funcLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    funcLabel.TextSize = 13
    funcLabel.Font = Enum.Font.Gotham
    funcLabel.Text = functionName
    funcLabel.TextXAlignment = Enum.TextXAlignment.Left
    funcLabel.Parent = functionFrame
    
    -- Toggle Button
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Name = functionName .. "Toggle"
    toggleBtn.Size = UDim2.new(0, 60, 0, 30)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(100, 20, 20)
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.TextSize = 12
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.Text = "OFF"
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Parent = functionFrame
    
    local toggleStroke = Instance.new("UIStroke")
    toggleStroke.Thickness = 1
    toggleStroke.Color = Color3.fromRGB(255, 192, 203)
    toggleStroke.Parent = toggleBtn
    
    local isActive = false
    
    -- Click effect
    toggleBtn.MouseButton1Click:Connect(function()
        isActive = not isActive
        functionsState[functionKey] = isActive
        
        if isActive then
            toggleBtn.BackgroundColor3 = Color3.fromRGB(20, 150, 20)
            toggleBtn.Text = "ON"
        else
            toggleBtn.BackgroundColor3 = Color3.fromRGB(100, 20, 20)
            toggleBtn.Text = "OFF"
        end
    end)
    
    return functionFrame
end

-- ===== CRIAR AS CATEGORIAS =====
local autoCategoryContainer = createCategory("Auto", "🏠")
addFunctionToCategory(autoCategoryContainer, "Auto Drible", "autoDrible")
addFunctionToCategory(autoCategoryContainer, "Auto Carrinho", "autoCarrinho")
addFunctionToCategory(autoCategoryContainer, "Auto Catch", "autoCatch")

-- Atualizar tamanho do container Auto
autoCategoryContainer.Size = UDim2.new(1, 0, 0, 170)

local espCategoryContainer = createCategory("ESP", "👁️")
addFunctionToCategory(espCategoryContainer, "ESP Bola", "espBola")

-- Atualizar tamanho do container ESP
espCategoryContainer.Size = UDim2.new(1, 0, 0, 90)

local gkCategoryContainer = createCategory("GK", "🧤")
addFunctionToCategory(gkCategoryContainer, "Modo Goleiro", "modoGoleiro")

-- Atualizar tamanho do container GK
gkCategoryContainer.Size = UDim2.new(1, 0, 0, 90)

-- Atualizar o tamanho do ScrollFrame
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 350)

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
    
    -- Aplicar cor RGB ao título
    titleText.TextColor3 = Color3.fromRGB(
        math.floor((r + 0.3) * 255),
        math.floor((g + 0.3) * 255),
        math.floor((b + 0.3) * 255)
    )
end

-- ===== FUNÇÕES DE MINIMIZAR/FECHAR =====
local function toggleMinimize()
    isMinimized = not isMinimized
    
    if isMinimized then
        contentFrame.Visible = false
        mainPanel.Size = UDim2.new(0, MENU_WIDTH, 0, 50)
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

-- ===== LOOP DE ANIMAÇÃO E FUNÇÕES =====
RunService.RenderStepped:Connect(function()
    updateRGBColor()
    updateDrag()
    
    -- Executar funções ativas
    setupAutoDrible()
    setupAutoCarrinho()
    setupAutoCatch()
    setupESPBola()
end)

print("✅ XERECA HUB carregado com sucesso!")
