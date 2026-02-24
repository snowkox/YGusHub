--[[
    Y. GUS ULTIMATE HUB - V6 (SUPREME AI EDITION)
    Design: Dark Acrylic / Neon Mint Gradient
    Features: Cinematic Boot, Smart AI Chat, ESP, MM2, Optimization
    Compatible: Xeno & Premium Executors
]]

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- API GROQ CONFIGURAÇÃO
local API_KEY = "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"
local API_URL = "https://api.groq.com/openai/v1/chat/completions"

-- Captura a função de request do executor (Xeno, Fluxus, Delta, etc)
local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
local setclip = setclipboard or toclipboard or function() end

-- PALETA DE CORES SUPREMA
local Theme = {
    Main = Color3.fromRGB(10, 10, 12),
    Sidebar = Color3.fromRGB(15, 15, 18),
    Accent = Color3.fromRGB(0, 255, 170), -- Mint Super Neon
    Text = Color3.fromRGB(255, 255, 255),
    TextDark = Color3.fromRGB(130, 130, 140),
    Card = Color3.fromRGB(20, 20, 24),
    ChatUser = Color3.fromRGB(15, 35, 25),
    ChatAI = Color3.fromRGB(22, 22, 28)
}

local function Tween(obj, info, goal)
    return TweenService:Create(obj, TweenInfo.new(unpack(info)), goal):Play()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "YGus_V6_Supreme"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- ==========================================
-- === TELA DE CARREGAMENTO CINEMÁTICA ======
-- ==========================================
local BootScreen = Instance.new("Frame", ScreenGui)
BootScreen.Size = UDim2.new(1, 0, 1, 0)
BootScreen.BackgroundColor3 = Color3.fromRGB(2, 2, 3)
BootScreen.ZIndex = 1000

local BootText = Instance.new("TextLabel", BootScreen)
BootText.Size = UDim2.new(1, 0, 1, 0)
BootText.BackgroundTransparency = 1
BootText.TextColor3 = Theme.Accent
BootText.Font = Enum.Font.Code
BootText.TextSize = 18
BootText.Text = ""
BootText.TextXAlignment = Enum.TextXAlignment.Left
BootText.TextYAlignment = Enum.TextYAlignment.Top
BootText.Position = UDim2.new(0, 20, 0, 20)

local LogoMain = Instance.new("TextLabel", BootScreen)
LogoMain.Size = UDim2.new(1, 0, 1, 0)
LogoMain.BackgroundTransparency = 1
LogoMain.Text = "Y. GUS"
LogoMain.TextColor3 = Theme.Text
LogoMain.Font = Enum.Font.GothamBlack
LogoMain.TextSize = 0 -- Começa invisivel
LogoMain.TextTransparency = 1

task.spawn(function()
    local lines = {
        "> Iniciando Y. Gus Core v6.0...",
        "> Bypass do Anticheat... [OK]",
        "> Conectando a Groq AI (LLaMA 3)... [OK]",
        "> Carregando Modulos de Interface...",
        "> Injetando no Processo Roblox...",
        "> Bem-vindo de volta, " .. player.Name .. "."
    }
    
    local currentText = ""
    for _, line in ipairs(lines) do
        currentText = currentText .. line .. "\n"
        BootText.Text = currentText
        task.wait(math.random(2, 5) / 10) -- Efeito de digitação hacker
    end
    
    task.wait(0.5)
    Tween(BootText, {0.5}, {TextTransparency = 1})
    task.wait(0.5)
    
    Tween(LogoMain, {1, Enum.EasingStyle.Elastic}, {TextSize = 80, TextTransparency = 0})
    local uig = Instance.new("UIGradient", LogoMain)
    uig.Color = ColorSequence.new(Theme.Accent, Color3.fromRGB(0, 150, 255))
    
    task.wait(1.5)
    Tween(BootScreen, {1, Enum.EasingStyle.Quart}, {BackgroundTransparency = 1})
    Tween(LogoMain, {1}, {TextTransparency = 1})
    task.wait(1)
    BootScreen:Destroy()
end)

-- ==========================================
-- === SISTEMA DE NOTIFICAÇÃO ===============
-- ==========================================
local function Notify(title, text)
    local nFrame = Instance.new("Frame", ScreenGui)
    nFrame.Size = UDim2.new(0, 250, 0, 60); nFrame.Position = UDim2.new(1, 10, 0.9, 0)
    nFrame.BackgroundColor3 = Theme.Main
    Instance.new("UICorner", nFrame).CornerRadius = UDim.new(0, 8)
    local s = Instance.new("UIStroke", nFrame); s.Color = Theme.Accent; s.Thickness = 1.2

    local tl = Instance.new("TextLabel", nFrame)
    tl.Size = UDim2.new(1, -10, 0, 25); tl.Position = UDim2.new(0, 10, 0, 5)
    tl.Text = title; tl.TextColor3 = Theme.Accent; tl.Font = "GothamBold"; tl.TextXAlignment = "Left"; tl.BackgroundTransparency = 1
    
    local ml = Instance.new("TextLabel", nFrame)
    ml.Size = UDim2.new(1, -10, 0, 25); ml.Position = UDim2.new(0, 10, 0, 25)
    ml.Text = text; ml.TextColor3 = Theme.Text; ml.Font = "Gotham"; ml.TextXAlignment = "Left"; ml.BackgroundTransparency = 1; ml.TextSize = 12

    nFrame:TweenPosition(UDim2.new(1, -260, 0.9, 0), "Out", "Back", 0.5)
    task.delay(3, function()
        nFrame:TweenPosition(UDim2.new(1, 10, 0.9, 0), "In", "Sine", 0.5)
        task.wait(0.5); nFrame:Destroy()
    end)
end

-- ==========================================
-- === MENU PRINCIPAL E BOTÃO ===============
-- ==========================================
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 60, 0, 60); ToggleBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
ToggleBtn.BackgroundColor3 = Theme.Main; ToggleBtn.Text = "YG"
ToggleBtn.Font = "GothamBlack"; ToggleBtn.TextSize = 20; ToggleBtn.TextColor3 = Theme.Accent
ToggleBtn.Visible = false
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", ToggleBtn).Thickness = 2; Instance.new("UIStroke", ToggleBtn).Color = Theme.Accent

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 700, 0, 480); Main.Position = UDim2.new(0.5, -350, 0.5, -240)
Main.BackgroundColor3 = Theme.Main; Main.Visible = false; Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
local mStroke = Instance.new("UIStroke", Main); mStroke.Thickness = 1; mStroke.Color = Theme.Accent; mStroke.Transparency = 0.5

local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 50); Header.BackgroundTransparency = 1
local HTitle = Instance.new("TextLabel", Header)
HTitle.Size = UDim2.new(0, 300, 1, 0); HTitle.Position = UDim2.new(0, 20, 0, 0)
HTitle.Text = "Y. GUS <font color='#00FFAA'>SUPREME</font>"; HTitle.RichText = true
HTitle.TextColor3 = Theme.Text; HTitle.Font = "GothamBlack"; HTitle.TextSize = 22; HTitle.TextXAlignment = "Left"; HTitle.BackgroundTransparency = 1

local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 180, 1, -60); Sidebar.Position = UDim2.new(0, 10, 0, 50); Sidebar.BackgroundColor3 = Theme.Sidebar
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)
local TabContainer = Instance.new("Frame", Sidebar)
TabContainer.Size = UDim2.new(1, 0, 1, -20); TabContainer.Position = UDim2.new(0, 0, 0, 10); TabContainer.BackgroundTransparency = 1
Instance.new("UIListLayout", TabContainer).HorizontalAlignment = "Center"
Instance.new("UIListLayout", TabContainer).Padding = UDim.new(0, 6)

local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -210, 1, -70); Content.Position = UDim2.new(0, 200, 0, 60); Content.BackgroundTransparency = 1

local function MakeDraggable(obj)
    local d, i, s, sp
    obj.InputBegan:Connect(function(inp) if inp.UserInputType == Enum.UserInputType.MouseButton1 then d = true; s = inp.Position; sp = obj.Position end end)
    obj.InputEnded:Connect(function(inp) if inp.UserInputType == Enum.UserInputType.MouseButton1 then d = false end end)
    UserInputService.InputChanged:Connect(function(inp) if d and inp.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = inp.Position - s; obj.Position = UDim2.new(sp.X.Scale, sp.X.Offset + delta.X, sp.Y.Scale, sp.Y.Offset + delta.Y)
    end end)
end
MakeDraggable(Main); MakeDraggable(ToggleBtn)

-- ==========================================
-- === SISTEMA DE ABAS ======================
-- ==========================================
local Tabs = {}
function CreateTab(name)
    local Page = Instance.new("ScrollingFrame", Content)
    Page.Size = UDim2.new(1, 0, 1, 0); Page.BackgroundTransparency = 1; Page.Visible = false; Page.ScrollBarThickness = 0
    local pLayout = Instance.new("UIListLayout", Page); pLayout.Padding = UDim.new(0, 10)

    local TBtn = Instance.new("TextButton", TabContainer)
    TBtn.Size = UDim2.new(0.9, 0, 0, 40); TBtn.BackgroundColor3 = Theme.Main; TBtn.Text = "  " .. name
    TBtn.TextColor3 = Theme.TextDark; TBtn.Font = "GothamBold"; TBtn.TextSize = 14; TBtn.TextXAlignment = "Left"
    Instance.new("UICorner", TBtn).CornerRadius = UDim.new(0, 6)
    
    TBtn.MouseButton1Click:Connect(function()
        for _, v in pairs(Tabs) do v.Visible = false end
        for _, b in pairs(TabContainer:GetChildren()) do if b:IsA("TextButton") then b.TextColor3 = Theme.TextDark; Tween(b, {0.3}, {BackgroundColor3 = Theme.Main}) end end
        Page.Visible = true; TBtn.TextColor3 = Theme.Accent; Tween(TBtn, {0.3}, {BackgroundColor3 = Theme.Card})
    end)
    Tabs[name] = Page; return Page
end

function AddCard(tab, title, desc, func)
    local Card = Instance.new("TextButton", tab)
    Card.Size = UDim2.new(1, -10, 0, 60); Card.BackgroundColor3 = Theme.Card; Card.Text = ""; Card.AutoButtonColor = false
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8)
    local cStroke = Instance.new("UIStroke", Card); cStroke.Transparency = 0.8; cStroke.Color = Theme.Accent

    local ct = Instance.new("TextLabel", Card)
    ct.Text = title; ct.Size = UDim2.new(1, -20, 0, 30); ct.Position = UDim2.new(0, 15, 0, 5)
    ct.TextColor3 = Theme.Accent; ct.Font = "GothamBold"; ct.TextSize = 15; ct.BackgroundTransparency = 1; ct.TextXAlignment = "Left"
    local cd = Instance.new("TextLabel", Card)
    cd.Text = desc; cd.Size = UDim2.new(1, -20, 0, 20); cd.Position = UDim2.new(0, 15, 0, 30)
    cd.TextColor3 = Theme.TextDark; cd.Font = "Gotham"; cd.TextSize = 12; cd.BackgroundTransparency = 1; cd.TextXAlignment = "Left"

    Card.MouseEnter:Connect(function() Tween(Card, {0.2}, {BackgroundColor3 = Color3.fromRGB(30, 30, 36)}); Tween(cStroke, {0.2}, {Transparency = 0}) end)
    Card.MouseLeave:Connect(function() Tween(Card, {0.2}, {BackgroundColor3 = Theme.Card}); Tween(cStroke, {0.2}, {Transparency = 0.8}) end)
    Card.MouseButton1Click:Connect(function() Notify("Executado", title); func() end)
end

-- ==========================================
-- === ABA DA IA (CHATBOT GROQ OTIMIZADO) ===
-- ==========================================
local TabAI = CreateTab("AI Scripter")
TabAI.ScrollingEnabled = false

local ChatHistory = Instance.new("ScrollingFrame", TabAI)
ChatHistory.Size = UDim2.new(1, -10, 1, -65); ChatHistory.BackgroundTransparency = 1
ChatHistory.ScrollBarThickness = 2; ChatHistory.ScrollBarImageColor3 = Theme.Accent
local ChatLayout = Instance.new("UIListLayout", ChatHistory)
ChatLayout.Padding = UDim.new(0, 12); ChatLayout.SortOrder = Enum.SortOrder.LayoutOrder

ChatHistory.AutomaticCanvasSize = Enum.AutomaticSize.Y

local InputFrame = Instance.new("Frame", TabAI)
InputFrame.Size = UDim2.new(1, -10, 0, 45); InputFrame.Position = UDim2.new(0, 0, 1, -50)
InputFrame.BackgroundColor3 = Theme.Card
Instance.new("UICorner", InputFrame).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", InputFrame).Color = Theme.Accent

local AIInput = Instance.new("TextBox", InputFrame)
AIInput.Size = UDim2.new(1, -60, 1, 0); AIInput.Position = UDim2.new(0, 10, 0, 0)
AIInput.BackgroundTransparency = 1; AIInput.Text = ""; AIInput.PlaceholderText = "Peça um script (Ex: Script de voar)..."
AIInput.TextColor3 = Theme.Text; AIInput.Font = "Gotham"; AIInput.TextSize = 13; AIInput.TextXAlignment = "Left"; AIInput.ClearTextOnFocus = false

local SendBtn = Instance.new("TextButton", InputFrame)
SendBtn.Size = UDim2.new(0, 40, 0, 35); SendBtn.Position = UDim2.new(1, -45, 0, 5)
SendBtn.BackgroundColor3 = Theme.Accent; SendBtn.Text = "➤"; SendBtn.TextColor3 = Theme.Main
SendBtn.Font = "GothamBlack"; SendBtn.TextSize = 18
Instance.new("UICorner", SendBtn).CornerRadius = UDim.new(0, 6)

local ChatMemory = {
    {role = "system", content = "Você é Y. Gus AI. Crie apenas scripts Luau curtos e funcionais para Roblox. Evite explicações longas, mande logo o código."}
}

local function AddChatBubble(text, isUser)
    local BubbleBtn = Instance.new("TextButton", ChatHistory) -- Usando botão para permitir copiar
    BubbleBtn.BackgroundColor3 = isUser and Theme.ChatUser or Theme.ChatAI
    BubbleBtn.Text = ""
    BubbleBtn.AutoButtonColor = false
    Instance.new("UICorner", BubbleBtn).CornerRadius = UDim.new(0, 8)
    
    local txt = Instance.new("TextLabel", BubbleBtn)
    txt.Text = (isUser and "Você: " or "Y. Gus: ") .. text
    txt.Size = UDim2.new(1, -20, 0, 0) -- Altura gerada pelo AutomaticSize
    txt.Position = UDim2.new(0, 10, 0, 10)
    txt.TextColor3 = isUser and Theme.Accent or Theme.Text
    txt.Font = "Gotham"
    txt.TextSize = 13
    txt.TextWrapped = true
    txt.TextXAlignment = "Left"
    txt.TextYAlignment = "Top"
    txt.BackgroundTransparency = 1
    txt.AutomaticSize = Enum.AutomaticSize.Y

    BubbleBtn.AutomaticSize = Enum.AutomaticSize.Y
    
    -- Se for IA, permite clicar para copiar
    if not isUser then
        BubbleBtn.MouseButton1Click:Connect(function()
            setclip(text)
            Notify("Copiado!", "Resposta da IA copiada para a área de transferência.")
        end)
    end
    
    -- Forçar scroll para baixo
    task.wait(0.1)
    ChatHistory.CanvasPosition = Vector2.new(0, ChatHistory.AbsoluteWindowSize.Y + 9999)
end

local isGenerating = false
SendBtn.MouseButton1Click:Connect(function()
    local userText = AIInput.Text
    if userText == "" or isGenerating then return end
    
    if not httprequest then
        AddChatBubble("Erro: Seu executor (Xeno/etc) não suporta a função 'request'. A IA precisa de internet para funcionar.", false)
        return
    end

    AIInput.Text = ""
    isGenerating = true
    SendBtn.Text = "..."
    SendBtn.BackgroundColor3 = Theme.TextDark

    AddChatBubble(userText, true)
    table.insert(ChatMemory, {role = "user", content = userText})

    task.spawn(function()
        local bodyData = {
            model = "llama3-8b-8192",
            messages = ChatMemory,
            temperature = 0.5
        }

        local success, response = pcall(function()
            return httprequest({
                Url = API_URL,
                Method = "POST",
                Headers = {
                    ["Authorization"] = "Bearer " .. API_KEY,
                    ["Content-Type"] = "application/json"
                },
                Body = HttpService:JSONEncode(bodyData)
            })
        end)

        if success then
            -- Tratando a resposta da API (que pode vir como StatusCode no lugar de Status)
            local code = response.StatusCode or response.Status
            if code == 200 then
                local decoded = HttpService:JSONDecode(response.Body)
                local aiReply = decoded.choices[1].message.content
                table.insert(ChatMemory, {role = "assistant", content = aiReply})
                AddChatBubble(aiReply .. "\n\n[CLIQUE NESTA MENSAGEM PARA COPIAR O SCRIPT]", false)
            else
                -- Mostra o erro exato que a API retornou
                AddChatBubble("Erro na API (Codigo " .. tostring(code) .. "):\n" .. tostring(response.Body), false)
            end
        else
            AddChatBubble("Falha fatal na requisição: O executor bloqueou a conexão ou você está sem internet.", false)
            print(response) -- Loga o erro no console do executor
        end

        isGenerating = false
        SendBtn.Text = "➤"
        SendBtn.BackgroundColor3 = Theme.Accent
    end)
end)

-- ==========================================
-- === OUTRAS ABAS (Player, ESP, etc) =======
-- ==========================================

local Tab1 = CreateTab("Jogador")
AddCard(Tab1, "Velocidade Extrema (WalkSpeed)", "Corre como o flash", function() player.Character.Humanoid.WalkSpeed = 100 end)
AddCard(Tab1, "Pulo Extremo (JumpPower)", "Pula alturas absurdas", function() player.Character.Humanoid.JumpPower = 150 end)
AddCard(Tab1, "Restaurar Personagem", "Volta ao estado normal", function() player.Character.Humanoid.WalkSpeed = 16; player.Character.Humanoid.JumpPower = 50 end)

local TabVis = CreateTab("Visuals (ESP)")
AddCard(TabVis, "Box ESP (Ver Através das Paredes)", "Cria caixas nos jogadores inimigos", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local box = Instance.new("BoxHandleAdornment")
            box.Size = Vector3.new(4, 6, 1); box.AlwaysOnTop = true; box.ZIndex = 5; box.Transparency = 0.5; box.Color3 = Theme.Accent
            box.Adornee = p.Character.HumanoidRootPart
            box.Parent = p.Character.HumanoidRootPart
        end
    end
end)

local Tab2 = CreateTab("Universal")
AddCard(Tab2, "Infinite Yield Admin", "Comandos ilimitados", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Infinite-Yield-reupload-112882"))() end)
AddCard(Tab2, "Animações Customizadas", "Pacote R15/R6", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-GAE-SIMPLIFIED-27193"))() end)
AddCard(Tab2, "Menu de Emotes", "Dance a qualquer momento", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-emote-script-7yd7-63469"))() end)

local Tab3 = CreateTab("MM2")
AddCard(Tab3, "Nexus Script", "Melhor script para Murder Mystery 2", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Murder-Mystery-2-nexus-updated-15270"))() end)

local Tab5 = CreateTab("Configs")
AddCard(Tab5, "FPS Boost Master", "Deixa o jogo sem lag (Plastico puro)", function() 
    settings().Rendering.QualityLevel = 1
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("MeshPart") then v.Material = "SmoothPlastic"
        elseif v:IsA("Texture") or v:IsA("Decal") then v:Destroy() end
    end
end)
AddCard(Tab5, "Fechar Y. Gus Hub", "Remove toda a interface", function() ScreenGui:Destroy() end)

-- Toggle Menu Logic
ToggleBtn.MouseButton1Click:Connect(function()
    if Main.Visible then
        Tween(Main, {0.4, Enum.EasingStyle.Quart}, {Size = UDim2.new(0, 0, 0, 480), BackgroundTransparency = 1}); task.wait(0.4); Main.Visible = false
    else
        Main.Visible = true; Main.BackgroundTransparency = 0; Tween(Main, {0.6, Enum.EasingStyle.Back}, {Size = UDim2.new(0, 700, 0, 480)})
    end
end)

-- Start Application
task.wait(5.5) -- Espera acabar a animação de loading cinemática
ToggleBtn.Visible = true
Tabs["AI Scripter"].Visible = true
Notify("Y. Gus Hub", "Sistema inicializado. Bem-vindo!")
