--[[
    Y. GUS ULTIMATE HUB - V9 (GOD MODE EDITION)
    Design: Dark Acrylic / Neon Mint / Apex UI
    Features: Aimbot, Noclip, Hitbox, ESP, Server Hop
]]

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local mouse = player:GetMouse()

-- PALETA DE CORES SUPREMA
local Theme = {
    Main = Color3.fromRGB(10, 10, 12),
    Sidebar = Color3.fromRGB(15, 15, 18),
    Accent = Color3.fromRGB(0, 255, 170), -- Mint Super Neon
    OffColor = Color3.fromRGB(255, 60, 60), -- Vermelho
    Text = Color3.fromRGB(255, 255, 255),
    TextDark = Color3.fromRGB(130, 130, 140),
    Card = Color3.fromRGB(20, 20, 24)
}

local function Tween(obj, info, goal)
    return TweenService:Create(obj, TweenInfo.new(unpack(info)), goal):Play()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "YGus_V9_GodMode"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- ==========================================
-- === SISTEMA DE NOTIFICAÇÃO ===============
-- ==========================================
local function Notify(title, text)
    local nFrame = Instance.new("Frame", ScreenGui)
    nFrame.Size = UDim2.new(0, 250, 0, 60); nFrame.Position = UDim2.new(1, 10, 0.9, 0); nFrame.BackgroundColor3 = Theme.Main
    Instance.new("UICorner", nFrame).CornerRadius = UDim.new(0, 8)
    local s = Instance.new("UIStroke", nFrame); s.Color = Theme.Accent; s.Thickness = 1.2

    local tl = Instance.new("TextLabel", nFrame)
    tl.Size = UDim2.new(1, -10, 0, 25); tl.Position = UDim2.new(0, 10, 0, 5)
    tl.Text = title; tl.TextColor3 = Theme.Accent; tl.Font = "GothamBold"; tl.TextXAlignment = "Left"; tl.BackgroundTransparency = 1
    local ml = Instance.new("TextLabel", nFrame)
    ml.Size = UDim2.new(1, -10, 0, 25); ml.Position = UDim2.new(0, 10, 0, 25)
    ml.Text = text; ml.TextColor3 = Theme.Text; ml.Font = "Gotham"; ml.TextXAlignment = "Left"; ml.BackgroundTransparency = 1; ml.TextSize = 12

    nFrame:TweenPosition(UDim2.new(1, -260, 0.9, 0), "Out", "Back", 0.5)
    task.delay(3, function() nFrame:TweenPosition(UDim2.new(1, 10, 0.9, 0), "In", "Sine", 0.5); task.wait(0.5); nFrame:Destroy() end)
end

-- ==========================================
-- === MENU PRINCIPAL E BOTÃO ===============
-- ==========================================
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 60, 0, 60); ToggleBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
ToggleBtn.BackgroundColor3 = Theme.Main; ToggleBtn.Text = "YG"
ToggleBtn.Font = "GothamBlack"; ToggleBtn.TextSize = 20; ToggleBtn.TextColor3 = Theme.Accent
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", ToggleBtn).Thickness = 2; Instance.new("UIStroke", ToggleBtn).Color = Theme.Accent

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 720, 0, 500); Main.Position = UDim2.new(0.5, -360, 0.5, -250)
Main.BackgroundColor3 = Theme.Main; Main.Visible = false; Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", Main).Thickness = 1; Instance.new("UIStroke", Main).Color = Theme.Accent; Instance.new("UIStroke", Main).Transparency = 0.5

local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 50); Header.BackgroundTransparency = 1
local HTitle = Instance.new("TextLabel", Header)
HTitle.Size = UDim2.new(0, 350, 1, 0); HTitle.Position = UDim2.new(0, 20, 0, 0)
HTitle.Text = "Y. GUS <font color='#00FFAA'>GOD MODE</font>"; HTitle.RichText = true
HTitle.TextColor3 = Theme.Text; HTitle.Font = "GothamBlack"; HTitle.TextSize = 22; HTitle.TextXAlignment = "Left"; HTitle.BackgroundTransparency = 1

local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 180, 1, -60); Sidebar.Position = UDim2.new(0, 10, 0, 50); Sidebar.BackgroundColor3 = Theme.Sidebar
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)
local TabContainer = Instance.new("Frame", Sidebar)
TabContainer.Size = UDim2.new(1, 0, 1, -20); TabContainer.Position = UDim2.new(0, 0, 0, 10); TabContainer.BackgroundTransparency = 1
Instance.new("UIListLayout", TabContainer).HorizontalAlignment = "Center"; Instance.new("UIListLayout", TabContainer).Padding = UDim.new(0, 6)

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
-- === SISTEMA DE COMPONENTES UI ============
-- ==========================================
local Tabs = {}
function CreateTab(name)
    local Page = Instance.new("ScrollingFrame", Content)
    Page.Size = UDim2.new(1, 0, 1, 0); Page.BackgroundTransparency = 1; Page.Visible = false; Page.ScrollBarThickness = 2; Page.ScrollBarImageColor3 = Theme.Accent
    local pLayout = Instance.new("UIListLayout", Page); pLayout.Padding = UDim.new(0, 10); Page.AutomaticCanvasSize = Enum.AutomaticSize.Y

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

function AddButton(tab, title, desc, func)
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

function AddToggle(tab, title, desc, default, callback)
    local state = default
    local Card = Instance.new("TextButton", tab)
    Card.Size = UDim2.new(1, -10, 0, 60); Card.BackgroundColor3 = Theme.Card; Card.Text = ""; Card.AutoButtonColor = false
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8)
    local cStroke = Instance.new("UIStroke", Card); cStroke.Transparency = 0.8; cStroke.Color = Theme.Accent

    local ct = Instance.new("TextLabel", Card)
    ct.Text = title; ct.Size = UDim2.new(1, -80, 0, 30); ct.Position = UDim2.new(0, 15, 0, 5)
    ct.TextColor3 = Theme.Accent; ct.Font = "GothamBold"; ct.TextSize = 15; ct.BackgroundTransparency = 1; ct.TextXAlignment = "Left"
    local cd = Instance.new("TextLabel", Card)
    cd.Text = desc; cd.Size = UDim2.new(1, -80, 0, 20); cd.Position = UDim2.new(0, 15, 0, 30)
    cd.TextColor3 = Theme.TextDark; cd.Font = "Gotham"; cd.TextSize = 12; cd.BackgroundTransparency = 1; cd.TextXAlignment = "Left"

    local StatusLabel = Instance.new("TextLabel", Card)
    StatusLabel.Size = UDim2.new(0, 60, 0, 30); StatusLabel.Position = UDim2.new(1, -75, 0.5, -15)
    StatusLabel.Text = state and "[ ON ]" or "[ OFF ]"
    StatusLabel.TextColor3 = state and Theme.Accent or Theme.OffColor
    StatusLabel.Font = "GothamBlack"; StatusLabel.TextSize = 14; StatusLabel.BackgroundTransparency = 1

    Card.MouseEnter:Connect(function() Tween(Card, {0.2}, {BackgroundColor3 = Color3.fromRGB(30, 30, 36)}); Tween(cStroke, {0.2}, {Transparency = 0}) end)
    Card.MouseLeave:Connect(function() Tween(Card, {0.2}, {BackgroundColor3 = Theme.Card}); Tween(cStroke, {0.2}, {Transparency = 0.8}) end)
    
    Card.MouseButton1Click:Connect(function()
        state = not state
        StatusLabel.Text = state and "[ ON ]" or "[ OFF ]"
        StatusLabel.TextColor3 = state and Theme.Accent or Theme.OffColor
        Notify(title, state and "Ativado" or "Desativado")
        callback(state)
    end)
end

function AddSlider(tab, title, min, max, default, callback)
    local SliderFrame = Instance.new("Frame", tab)
    SliderFrame.Size = UDim2.new(1, -10, 0, 65); SliderFrame.BackgroundColor3 = Theme.Card
    Instance.new("UICorner", SliderFrame).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", SliderFrame).Color = Theme.Accent; Instance.new("UIStroke", SliderFrame).Transparency = 0.8

    local TitleL = Instance.new("TextLabel", SliderFrame)
    TitleL.Size = UDim2.new(1, -30, 0, 30); TitleL.Position = UDim2.new(0, 15, 0, 5)
    TitleL.Text = title .. " : " .. tostring(default); TitleL.TextColor3 = Theme.Text; TitleL.Font = "GothamBold"; TitleL.TextSize = 14; TitleL.BackgroundTransparency = 1; TitleL.TextXAlignment = "Left"

    local Track = Instance.new("TextButton", SliderFrame)
    Track.Size = UDim2.new(1, -30, 0, 8); Track.Position = UDim2.new(0, 15, 0, 40); Track.BackgroundColor3 = Theme.Main; Track.Text = ""; Track.AutoButtonColor = false
    Instance.new("UICorner", Track).CornerRadius = UDim.new(1, 0)

    local Fill = Instance.new("Frame", Track)
    local startPos = (default - min) / (max - min)
    Fill.Size = UDim2.new(startPos, 0, 1, 0); Fill.BackgroundColor3 = Theme.Accent
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)

    local dragging = false
    local function UpdateSlider(input)
        local pos = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + ((max - min) * pos))
        TitleL.Text = title .. " : " .. tostring(value)
        Tween(Fill, {0.1}, {Size = UDim2.new(pos, 0, 1, 0)})
        callback(value)
    end

    Track.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true; UpdateSlider(input) end end)
    UserInputService.InputChanged:Connect(function(input) if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then UpdateSlider(input) end end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
end

-- ==========================================
-- === LÓGICA GLOBAL DE HACKS (GOD MODE) ====
-- ==========================================
local Configs = {
    Hitbox = false, HitboxSize = 10,
    ESP = false,
    WalkSpeed = 16, JumpPower = 50,
    Noclip = false, InfJump = false,
    Aimbot = false, AimSmooth = 0.5
}

-- Inf Jump
UserInputService.JumpRequest:Connect(function()
    if Configs.InfJump and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Aimbot Target Finder
local function GetNearestPlayer()
    local nearest = nil
    local shortestDist = math.huge
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            local pos, onScreen = camera:WorldToViewportPoint(v.Character.Head.Position)
            if onScreen then
                local dist = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
                if dist < shortestDist then
                    shortestDist = dist
                    nearest = v.Character.Head
                end
            end
        end
    end
    return nearest
end

-- HEARTBEAT / RENDER LOOP GLOBAL (Velocidade, Noclip, Aimbot, Hitbox)
RunService.Stepped:Connect(function()
    if Configs.Noclip and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    -- AIMBOT CAMLOCK
    if Configs.Aimbot then
        local target = GetNearestPlayer()
        if target then
            camera.CFrame = camera.CFrame:Lerp(CFrame.new(camera.CFrame.Position, target.Position), Configs.AimSmooth)
        end
    end

    -- Hitbox Controle
    if Configs.Hitbox then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = v.Character.HumanoidRootPart
                hrp.Size = Vector3.new(Configs.HitboxSize, Configs.HitboxSize, Configs.HitboxSize)
                hrp.Transparency = 0.6; hrp.BrickColor = BrickColor.new("Bright green"); hrp.Material = Enum.Material.Neon; hrp.CanCollide = false
            end
        end
    else
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = v.Character.HumanoidRootPart
                if hrp.Size.X > 3 then hrp.Size = Vector3.new(2, 2, 1); hrp.Transparency = 1; hrp.CanCollide = false end
            end
        end
    end

    -- ESP Box
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = p.Character.HumanoidRootPart
            local esp = hrp:FindFirstChild("YGUS_ESP")
            if Configs.ESP then
                if not esp then
                    esp = Instance.new("BoxHandleAdornment"); esp.Name = "YGUS_ESP"; esp.Size = Vector3.new(4, 6, 1); esp.AlwaysOnTop = true; esp.ZIndex = 5; esp.Transparency = 0.5; esp.Color3 = Theme.Accent; esp.Adornee = hrp; esp.Parent = hrp
                end
            else
                if esp then esp:Destroy() end
            end
        end
    end

    -- Speed & Jump Fixes
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        if Configs.WalkSpeed ~= 16 then player.Character.Humanoid.WalkSpeed = Configs.WalkSpeed end
        if Configs.JumpPower ~= 50 then player.Character.Humanoid.JumpPower = Configs.JumpPower end
    end
end)

-- ==========================================
-- === CONSTRUÇÃO DAS ABAS ==================
-- ==========================================

-- --- ABA COMBATE (AIMBOT) ---
local TabAim = CreateTab("Combate")
AddToggle(TabAim, "Aimbot (CamLock)", "Trava a câmera na cabeça do inimigo mais próximo do mouse", false, function(s) Configs.Aimbot = s end)
AddSlider(TabAim, "Suavidade do Aimbot", 1, 10, 5, function(v) Configs.AimSmooth = v / 10 end)

-- --- ABA JOGADOR ---
local Tab1 = CreateTab("Jogador")
AddToggle(Tab1, "Noclip", "Atravessar todas as paredes", false, function(s) Configs.Noclip = s end)
AddToggle(Tab1, "Pulo Infinito", "Pule no ar como se estivesse voando", false, function(s) Configs.InfJump = s end)
AddToggle(Tab1, "Hitbox Expander", "Aumenta e destaca o corpo dos inimigos", false, function(s) Configs.Hitbox = s end)
AddSlider(Tab1, "Tamanho da Hitbox", 2, 50, 10, function(v) Configs.HitboxSize = v end)
AddSlider(Tab1, "Velocidade (WalkSpeed)", 16, 250, 16, function(v) Configs.WalkSpeed = v end)
AddSlider(Tab1, "Força do Pulo (JumpPower)", 50, 300, 50, function(v) Configs.JumpPower = v end)
AddButton(Tab1, "Resetar Status Básicos", "Volta tudo ao padrão do Roblox", function() Configs.WalkSpeed = 16; Configs.JumpPower = 50; Configs.Noclip = false; Configs.InfJump = false; Notify("Resetado", "Status restaurado.") end)

-- --- ABA VISUALS ---
local TabVis = CreateTab("Visuals (ESP)")
AddToggle(TabVis, "Ativar ESP Box", "Cria caixas brilhantes através das paredes", false, function(s) Configs.ESP = s end)

-- --- ABA UNIVERSAL & MM2 ---
local TabUni = CreateTab("Universal")
AddButton(TabUni, "Infinite Yield Admin", "Comandos de admin", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Infinite-Yield-reupload-112882"))() end)
AddButton(TabUni, "Animações Customizadas", "Pacote R15/R6", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-GAE-SIMPLIFIED-27193"))() end)
AddButton(TabUni, "Menu de Emotes", "Dance a qualquer momento", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-emote-script-7yd7-63469"))() end)
AddButton(TabUni, "Nexus Script (MM2)", "Melhor script para Murder Mystery 2", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Murder-Mystery-2-nexus-updated-15270"))() end)

-- --- ABA CONFIGURAÇÕES ---
local Tab5 = CreateTab("Configs")
AddButton(Tab5, "FPS Boost Master", "Remove gráficos para rodar liso", function() settings().Rendering.QualityLevel = 1; for _, v in pairs(game:GetDescendants()) do if v:IsA("Part") or v:IsA("MeshPart") then v.Material = "SmoothPlastic" elseif v:IsA("Texture") or v:IsA("Decal") then v:Destroy() end end end)
AddButton(Tab5, "Server Hop", "Pula para outro servidor diferente", function() 
    Notify("Aguarde", "Procurando outro servidor...")
    local Servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
    for _, s in pairs(Servers.data) do
        if s.playing ~= s.maxPlayers and s.id ~= game.JobId then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id, player)
            break
        end
    end
end)
AddButton(Tab5, "Fechar Y. Gus Hub", "Remove o menu da tela", function() ScreenGui:Destroy() end)

-- ==========================================
-- === LOGICA DE TECLADO E TOGGLE ===========
-- ==========================================
local function ToggleMenu()
    if Main.Visible then
        Tween(Main, {0.3, Enum.EasingStyle.Quart}, {Size = UDim2.new(0, 0, 0, 500), BackgroundTransparency = 1}); task.wait(0.3); Main.Visible = false
    else
        Main.Visible = true; Main.BackgroundTransparency = 0; Tween(Main, {0.5, Enum.EasingStyle.Back}, {Size = UDim2.new(0, 720, 0, 500)})
    end
end

ToggleBtn.MouseButton1Click:Connect(ToggleMenu)

-- Atalho no Teclado (Control Direito para Abrir/Fechar)
UserInputService.InputBegan:Connect(function(input, isProcessed)
    if not isProcessed and input.KeyCode == Enum.KeyCode.RightControl then ToggleMenu() end
end)

-- Start Application
Tabs["Combate"].Visible = true
Notify("Y. Gus Hub", "Pressione Right-Control para fechar/abrir o menu.")
