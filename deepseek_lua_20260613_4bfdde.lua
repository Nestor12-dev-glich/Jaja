--[[
    NINO HUB - CORREGIDO
    - Auto LEFT/RIGHT reemplazados por Auto Play de Atr (waypoints)
    - Auto Grab/Steal reemplazado por Prime Hub (barra blanca, ping/fps)
    - Todas las demás funciones originales intactas
]]

do
local TS = game:GetService("TweenService")
local CG = game:GetService("CoreGui")
local SS = game:GetService("SoundService")
local Lighting = game:GetService("Lighting")
local LP = game.Players.LocalPlayer

-- BLUR
local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting

local gui = Instance.new("ScreenGui")
gui.Name = "NinoHubIntro"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global

pcall(function()
    gui.Parent = CG
end)

if not gui.Parent then
    gui.Parent = LP.PlayerGui
end

-- CONTENEDOR
local holder = Instance.new("Frame")
holder.Parent = gui
holder.AnchorPoint = Vector2.new(0.5,0.5)
holder.Position = UDim2.new(0.5,0,0.5,0)
holder.Size = UDim2.new(0,700,0,140)
holder.BackgroundTransparency = 1

-- SOMBRA PROFUNDA
local shadow = Instance.new("TextLabel")
shadow.Parent = holder
shadow.Size = UDim2.fromScale(1,1)
shadow.Position = UDim2.new(0,8,0,8)
shadow.BackgroundTransparency = 1
shadow.Text = "NINO HUB"
shadow.Font = Enum.Font.Antique
shadow.TextSize = 82
shadow.TextColor3 = Color3.fromRGB(0,0,0)
shadow.TextTransparency = 1

-- CAPA INTERMEDIA (PÚRPURA)
local depth = Instance.new("TextLabel")
depth.Parent = holder
depth.Size = UDim2.fromScale(1,1)
depth.Position = UDim2.new(0,4,0,4)
depth.BackgroundTransparency = 1
depth.Text = "NINO HUB"
depth.Font = Enum.Font.Antique
depth.TextSize = 82
depth.TextColor3 = Color3.fromRGB(128,0,128)
depth.TextTransparency = 1

-- TEXTO PRINCIPAL (NEGRO)
local title = Instance.new("TextLabel")
title.Parent = holder
title.Size = UDim2.fromScale(1,1)
title.BackgroundTransparency = 1
title.Text = "NINO HUB"
title.Font = Enum.Font.Antique
title.TextSize = 82
title.TextColor3 = Color3.fromRGB(0,0,0)
title.TextTransparency = 1
title.TextStrokeTransparency = 0
title.TextStrokeColor3 = Color3.fromRGB(128,0,128)

-- BORDE BRILLANTE PÚRPURA
local stroke = Instance.new("UIStroke")
stroke.Parent = title
stroke.Thickness = 3
stroke.Color = Color3.fromRGB(128,0,128)
stroke.Transparency = 0

-- GLOW PÚRPURA
local glow = Instance.new("UIStroke")
glow.Parent = title
glow.Thickness = 10
glow.Color = Color3.fromRGB(128,0,128)
glow.Transparency = 0.75

-- GRADIENTE NEGRO A PÚRPURA
local grad = Instance.new("UIGradient")
grad.Parent = title
grad.Rotation = 90
grad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0,0,0)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(60,0,60)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(128,0,128))
})

-- DESTELLO BLANCO
local shine = Instance.new("Frame")
shine.Parent = holder
shine.Size = UDim2.new(0,80,1,0)
shine.Position = UDim2.new(-0.2,0,0,0)
shine.BackgroundColor3 = Color3.fromRGB(255,255,255)
shine.BackgroundTransparency = 0.82
shine.BorderSizePixel = 0
shine.Rotation = 15

-- MÚSICA
local music = Instance.new("Sound")
music.Parent = SS
music.SoundId = "rbxassetid://82149511707056"
music.Volume = 1

pcall(function()
    music:Play()
end)

-- ENTRADA
TS:Create(
    blur,
    TweenInfo.new(0.6, Enum.EasingStyle.Quint),
    {Size = 24}
):Play()

TS:Create(
    title,
    TweenInfo.new(0.6),
    {TextTransparency = 0}
):Play()

TS:Create(
    depth,
    TweenInfo.new(0.6),
    {TextTransparency = 0}
):Play()

TS:Create(
    shadow,
    TweenInfo.new(0.6),
    {TextTransparency = 0.35}
):Play()

task.wait(0.7)

TS:Create(
    shine,
    TweenInfo.new(1.1, Enum.EasingStyle.Linear),
    {Position = UDim2.new(1.2,0,0,0)}
):Play()

task.wait(4.3)

TS:Create(
    title,
    TweenInfo.new(0.5),
    {TextTransparency = 1}
):Play()

TS:Create(
    depth,
    TweenInfo.new(0.5),
    {TextTransparency = 1}
):Play()

TS:Create(
    shadow,
    TweenInfo.new(0.5),
    {TextTransparency = 1}
):Play()

TS:Create(
    blur,
    TweenInfo.new(0.5),
    {Size = 0}
):Play()

task.wait(0.6)

pcall(function() music:Destroy() end)
pcall(function() blur:Destroy() end)
pcall(function() gui:Destroy() end)

end

-- ============================================================
-- EFECTO DE CLIMA
-- ============================================================
local function applyWeatherEffect()
    pcall(function()
        local Lighting = game:GetService("Lighting")
        local TweenService = game:GetService("TweenService")

        Lighting.ClockTime = 16.5
        Lighting.Brightness = 1.8
        Lighting.FogStart = 50
        Lighting.FogEnd = 250
        Lighting.FogColor = Color3.fromRGB(180, 180, 175)

        local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
        if not atmosphere then
            atmosphere = Instance.new("Atmosphere")
            atmosphere.Parent = Lighting
        end
        atmosphere.Density = 0.45
        atmosphere.Haze = 3
        atmosphere.Glare = 0.15

        local terrain = workspace.Terrain
        if terrain then
            local clouds = terrain:FindFirstChildOfClass("Clouds")
            if clouds then
                clouds.Cover = 0.65
                clouds.Density = 0.5
                clouds.Color = Color3.fromRGB(220, 220, 220)
            end
        end

        local rainSound = workspace:FindFirstChild("RainSound")
        if rainSound and rainSound:IsA("Sound") then
            rainSound.Volume = 0.4
            rainSound.Looped = true
            rainSound:Play()
        end

        TweenService:Create(
            atmosphere,
            TweenInfo.new(5),
            {
                Density = 0.5,
                Haze = 3.5
            }
        ):Play()
    end)
end

applyWeatherEffect()

-- NINO HUB BB SCRIPT
repeat task.wait() until game:IsLoaded()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local HS = game:GetService("HttpService")
local Stats = game:GetService("Stats")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LP = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- ============================================================
-- AUTO PLAY (Atr Auto Play) - REEMPLAZA Auto Left/Right
-- ============================================================
local AutoPlay = {
    Enabled = false,
    Side = "left", -- "left" or "right"
    GoingSpeed = 55,
    StealSpeed = 29,
    activeConnection = nil,
    activeWaypoints = nil,
    waypointIndex = 1,
    currentPhase = 1,
    proxy = nil,
    ConfigFileName = "Nino_AutoPlay_Speeds.json",
}

-- Waypoints (los mismos de Atr Auto Play)
local leftWaypoints = {
    Vector3.new(-476.85, -6.59, 94.91),
    Vector3.new(-485.55, -4.53, 100.61),
    Vector3.new(-475.60, -6.59, 92.80),
    Vector3.new(-475.26, -6.57, 21.54),
}
local rightWaypoints = {
    Vector3.new(-475.77, -6.57, 26.76),
    Vector3.new(-485.85, -4.48, 20.13),
    Vector3.new(-475.83, -6.59, 26.54),
    Vector3.new(-476.17, -6.09, 97.73),
}

-- Cargar config
local function loadAutoPlayConfig()
    if not readfile or not isfile then return end
    pcall(function()
        if isfile(AutoPlay.ConfigFileName) then
            local data = HS:JSONDecode(readfile(AutoPlay.ConfigFileName))
            AutoPlay.GoingSpeed = data.GoingSpeed or 55
            AutoPlay.StealSpeed = data.StealSpeed or 29
        end
    end)
end

local function saveAutoPlayConfig()
    if not writefile then return end
    pcall(function()
        writefile(AutoPlay.ConfigFileName, HS:JSONEncode({
            GoingSpeed = AutoPlay.GoingSpeed,
            StealSpeed = AutoPlay.StealSpeed
        }))
    end)
end
loadAutoPlayConfig()

-- Proxy para movimiento
local function ensureAutoPlayProxy()
    local char = LP.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    if not AutoPlay.proxy or AutoPlay.proxy.Parent ~= char then
        if AutoPlay.proxy then AutoPlay.proxy:Destroy() end
        AutoPlay.proxy = Instance.new("Part")
        AutoPlay.proxy.Name = "Nino_AutoPlayProxy"
        AutoPlay.proxy.Size = Vector3.new(1,1,1)
        AutoPlay.proxy.Transparency = 1
        AutoPlay.proxy.CanCollide = false
        AutoPlay.proxy.Massless = true
        AutoPlay.proxy.Parent = char
        local weld = Instance.new("Weld")
        weld.Part0 = hrp
        weld.Part1 = AutoPlay.proxy
        weld.C0 = CFrame.new(0,0,0)
        weld.Parent = AutoPlay.proxy
    end
    return AutoPlay.proxy
end

local function moveTo(target, speed)
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local dir = (target - hrp.Position)
    local moveDir = Vector3.new(dir.X, 0, dir.Z).Unit
    local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum:Move(moveDir, false) end
    if AutoPlay.proxy then
        AutoPlay.proxy.AssemblyLinearVelocity = Vector3.new(moveDir.X * speed, AutoPlay.proxy.AssemblyLinearVelocity.Y, moveDir.Z * speed)
    end
end

local function stopAutoPlayMovement()
    if AutoPlay.proxy then AutoPlay.proxy.AssemblyLinearVelocity = Vector3.new(0,0,0) end
    local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum:Move(Vector3.zero, false) end
end

local function startPatrol(waypoints)
    if AutoPlay.activeConnection then AutoPlay.activeConnection:Disconnect() end
    AutoPlay.activeWaypoints = waypoints
    AutoPlay.waypointIndex = 1
    AutoPlay.currentPhase = 1
    ensureAutoPlayProxy()
    AutoPlay.activeConnection = RunService.Stepped:Connect(function()
        if not AutoPlay.activeWaypoints then return end
        local char = LP.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local target = AutoPlay.activeWaypoints[AutoPlay.waypointIndex]
        if not target then return end
        
        local dist = (target - hrp.Position).Magnitude
        local speed = (AutoPlay.currentPhase <= 2) and AutoPlay.GoingSpeed or AutoPlay.StealSpeed
        if dist < 2.5 then
            AutoPlay.waypointIndex = AutoPlay.waypointIndex + 1
            if AutoPlay.waypointIndex > #AutoPlay.activeWaypoints then
                AutoPlay.activeConnection:Disconnect()
                AutoPlay.activeConnection = nil
                AutoPlay.activeWaypoints = nil
                AutoPlay.Enabled = false
                if updateAutoPlayUI then updateAutoPlayUI() end
                stopAutoPlayMovement()
                return
            end
            if AutoPlay.waypointIndex == 3 then
                AutoPlay.currentPhase = 3
            end
        else
            moveTo(target, speed)
        end
    end)
end

local function stopPatrol()
    if AutoPlay.activeConnection then AutoPlay.activeConnection:Disconnect(); AutoPlay.activeConnection = nil end
    AutoPlay.activeWaypoints = nil
    AutoPlay.waypointIndex = 1
    stopAutoPlayMovement()
end

-- Función que reemplaza a los antiguos startAutoLeft/startAutoRight
local function setAutoPlay(side, enabled)
    if enabled and side == "left" then
        if AutoPlay.Enabled and AutoPlay.Side == "left" then return end
        stopPatrol()
        AutoPlay.Enabled = true
        AutoPlay.Side = "left"
        startPatrol(leftWaypoints)
    elseif enabled and side == "right" then
        if AutoPlay.Enabled and AutoPlay.Side == "right" then return end
        stopPatrol()
        AutoPlay.Enabled = true
        AutoPlay.Side = "right"
        startPatrol(rightWaypoints)
    else
        stopPatrol()
        AutoPlay.Enabled = false
    end
    if updateAutoPlayUI then updateAutoPlayUI() end
    saveAutoPlayConfig()
    saveConfig()
end

-- ============================================================
-- AUTO GRAB/STEAL (Prime Hub) - REEMPLAZA el antiguo S.Steal
-- ============================================================
local AutoGrab = {
    AUTO_STEAL_ENABLED = true,
    HOLD_MIN = 1.3,
    HOLD_MAX = 2.6,
    ENTRY_DELAY = 0.3,
    COOLDOWN = 0.05,
    STEAL_RANGE = 10,
    PRIME_RANGE = 80,
    isStealing = false,
    progressBarBg = nil,
    progressFill = nil,
    percentLabel = nil,
    infoLabel = nil,
    allAnimalsCache = {},
    PromptMemoryCache = {},
    InternalStealCache = {},
    stealConnection = nil,
    syncRemotes = nil,
    plotAnimalSync = { caches = {}, connections = {} },
    StealState = {
        active = false,
        startTime = 0,
        phase = "idle",
        label = "",
        lastResult = "",
        lastResultTime = 0,
        totalSteals = 0,
        failedSteals = 0,
    },
}

-- UI del Auto Grab
local function setupAutoGrabUI()
    local sg = LP.PlayerGui:FindFirstChild("PrimeHub")
    if not sg then
        sg = Instance.new("ScreenGui")
        sg.Name = "PrimeHub"
        sg.ResetOnSpawn = false
        sg.Parent = LP.PlayerGui
    end

    if not AutoGrab.progressBarBg then
        local container = Instance.new("Frame")
        container.Size = UDim2.new(0, 260, 0, 60)
        container.Position = UDim2.new(0.5, -130, 0, 80)
        container.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        container.BackgroundTransparency = 0.85
        container.BorderSizePixel = 0
        container.Parent = sg
        Instance.new("UICorner", container).CornerRadius = UDim.new(0, 10)

        local border = Instance.new("UIStroke", container)
        border.Color = Color3.fromRGB(40, 40, 40)
        border.Thickness = 1

        local bannerFrame = Instance.new("Frame")
        bannerFrame.Size = UDim2.new(1, 0, 0, 32)
        bannerFrame.Position = UDim2.new(0, 0, 0, 0)
        bannerFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        bannerFrame.BackgroundTransparency = 0
        bannerFrame.BorderSizePixel = 0
        bannerFrame.Parent = container
        Instance.new("UICorner", bannerFrame).CornerRadius = UDim.new(0, 10)

        AutoGrab.infoLabel = Instance.new("TextLabel")
        AutoGrab.infoLabel.Size = UDim2.new(1, 0, 1, 0)
        AutoGrab.infoLabel.BackgroundTransparency = 1
        AutoGrab.infoLabel.Font = Enum.Font.GothamBold
        AutoGrab.infoLabel.TextSize = 13
        AutoGrab.infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        AutoGrab.infoLabel.Text = "Prime Hub | Ping: 0ms | FPS: 0"
        AutoGrab.infoLabel.TextXAlignment = Enum.TextXAlignment.Center
        AutoGrab.infoLabel.Parent = bannerFrame

        AutoGrab.progressBarBg = Instance.new("Frame")
        AutoGrab.progressBarBg.Size = UDim2.new(0.85, 0, 0, 14)
        AutoGrab.progressBarBg.Position = UDim2.new(0.075, 0, 0, 38)
        AutoGrab.progressBarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        AutoGrab.progressBarBg.BackgroundTransparency = 0
        AutoGrab.progressBarBg.BorderSizePixel = 0
        AutoGrab.progressBarBg.Visible = true
        AutoGrab.progressBarBg.Parent = container
        Instance.new("UICorner", AutoGrab.progressBarBg).CornerRadius = UDim.new(0, 8)

        AutoGrab.progressFill = Instance.new("Frame")
        AutoGrab.progressFill.Size = UDim2.new(0, 0, 1, 0)
        AutoGrab.progressFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        AutoGrab.progressFill.BorderSizePixel = 0
        AutoGrab.progressFill.Parent = AutoGrab.progressBarBg
        Instance.new("UICorner", AutoGrab.progressFill).CornerRadius = UDim.new(0, 8)

        AutoGrab.percentLabel = Instance.new("TextLabel")
        AutoGrab.percentLabel.Size = UDim2.new(1, 0, 1, 0)
        AutoGrab.percentLabel.BackgroundTransparency = 1
        AutoGrab.percentLabel.Font = Enum.Font.GothamBold
        AutoGrab.percentLabel.TextSize = 10
        AutoGrab.percentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        AutoGrab.percentLabel.Text = "0%"
        AutoGrab.percentLabel.TextXAlignment = Enum.TextXAlignment.Center
        AutoGrab.percentLabel.Parent = AutoGrab.progressBarBg

        -- Actualizar ping/FPS
        local framesCount = 0
        local last = tick()
        RunService.RenderStepped:Connect(function()
            framesCount = framesCount + 1
            if tick() - last >= 1 then
                local fps = framesCount
                framesCount = 0
                last = tick()
                local ping = 0
                local network = Stats:FindFirstChild("Network")
                if network and network:FindFirstChild("ServerStatsItem") then
                    local dataPing = network.ServerStatsItem:FindFirstChild("Data Ping")
                    if dataPing then ping = math.floor(dataPing:GetValue()) end
                end
                AutoGrab.infoLabel.Text = "Prime Hub | Ping: " .. ping .. "ms | FPS: " .. fps
            end
        end)
    end
end

local function updateGrabProgressBar(p)
    if AutoGrab.progressFill then
        AutoGrab.progressFill.Size = UDim2.new(p, 0, 1, 0)
    end
    if AutoGrab.percentLabel then
        AutoGrab.percentLabel.Text = math.floor(p * 100) .. "%"
    end
end

-- Sistema de sincronización
local function setupGrabSync()
    local Packages = ReplicatedStorage:WaitForChild("Packages")
    local Datas = ReplicatedStorage:WaitForChild("Datas")
    local AnimalsData = require(Datas:WaitForChild("Animals"))
    local plots = workspace:WaitForChild("Plots")

    AutoGrab.syncRemotes = (function()
        local folder = Packages:WaitForChild("Synchronizer")
        return {
            channelFolder = folder:WaitForChild("Channel"),
            routeRemote = folder:WaitForChild("CommunicationRoute"),
            requestData = folder:FindFirstChild("RequestData"),
        }
    end)()

    local function splitSyncPath(path)
        if typeof(path) == "table" then return path end
        local out = {}
        for part in string.gmatch(tostring(path), "[^%.]+") do
            table.insert(out, tonumber(part) or part)
        end
        return out
    end

    local function resolveSyncPath(path, root)
        local current = root
        local parent = nil
        local key = nil
        for _, part in ipairs(splitSyncPath(path)) do
            parent = current
            key = part
            current = current and current[part] or nil
        end
        return current, parent, key
    end

    local function applyPlotSyncDiff(channelName, packet)
        local cache = AutoGrab.plotAnimalSync.caches[channelName]
        if typeof(cache) ~= "table" then return end
        local path, action, a, b = packet[1], packet[2], packet[3], packet[4]
        local current, parent, key = resolveSyncPath(path, cache)
        if action == "Changed" then
            if parent ~= nil then parent[key] = a end
        elseif action == "ArrayInsert" then
            if current ~= nil then table.insert(current, b, a) end
        elseif action == "ArrayRemoved" then
            if current ~= nil then table.remove(current, b) end
        elseif action == "DictionaryInsert" then
            if current ~= nil then current[b] = a end
        elseif action == "DictionaryRemoved" then
            if current ~= nil then current[b] = nil end
        end
    end

    local function attachPlotChannel(remote)
        if AutoGrab.plotAnimalSync.connections[remote] then return end
        local channelName = tostring(remote.Name)
        if not plots:FindFirstChild(channelName) then return end
        if AutoGrab.syncRemotes.requestData and AutoGrab.plotAnimalSync.caches[channelName] == nil then
            local ok, data = pcall(function()
                return AutoGrab.syncRemotes.requestData:InvokeServer(channelName)
            end)
            if ok and typeof(data) == "table" then
                AutoGrab.plotAnimalSync.caches[channelName] = data
            else
                AutoGrab.plotAnimalSync.caches[channelName] = {}
            end
        elseif AutoGrab.plotAnimalSync.caches[channelName] == nil then
            AutoGrab.plotAnimalSync.caches[channelName] = {}
        end
        AutoGrab.plotAnimalSync.connections[remote] = remote.OnClientEvent:Connect(function(queue)
            for _, packet in ipairs(queue) do
                applyPlotSyncDiff(channelName, packet)
            end
        end)
    end

    for _, child in ipairs(AutoGrab.syncRemotes.channelFolder:GetChildren()) do
        if child:IsA("RemoteEvent") then
            attachPlotChannel(child)
        end
    end
    AutoGrab.syncRemotes.channelFolder.ChildAdded:Connect(function(child)
        if child:IsA("RemoteEvent") then
            attachPlotChannel(child)
        end
    end)
    AutoGrab.syncRemotes.routeRemote.OnClientEvent:Connect(function(actions)
        for _, action in ipairs(actions) do
            local kind, channelName = action[1], tostring(action[2])
            if not plots:FindFirstChild(channelName) then continue end
            if kind == "ListenerAdded" then
                local remote = AutoGrab.syncRemotes.channelFolder:FindFirstChild(channelName)
                if remote and remote:IsA("RemoteEvent") then
                    attachPlotChannel(remote)
                end
            elseif kind == "ListenerRemoved" then
                local conn = AutoGrab.plotAnimalSync.connections[remote]
                if conn then conn:Disconnect() end
                AutoGrab.plotAnimalSync.connections[remote] = nil
                AutoGrab.plotAnimalSync.caches[tostring(channelName)] = nil
            end
        end
    end)

    return AnimalsData, plots
end

local AnimalsData, plots = setupGrabSync()

local function getPlotChannelData(plotName)
    return AutoGrab.plotAnimalSync.caches[plotName]
end

local function getPlotOwner(plot)
    local sign = plot:FindFirstChild("PlotSign")
    local frame = sign and sign:FindFirstChild("SurfaceGui") and sign.SurfaceGui:FindFirstChild("Frame")
    local label = frame and frame:FindFirstChild("TextLabel")
    if not label or label.Text == "Empty Base" then
        return nil
    end
    return label.Text:gsub("'s [Bb]ase$", ""):gsub("%s+$", "")
end

local function isMyBaseAnimal(animalData)
    if not animalData or not animalData.plot then return false end
    local plot = plots:FindFirstChild(animalData.plot)
    if not plot then return false end
    return getPlotOwner(plot) == LP.DisplayName
end

local function findProximityPromptForAnimal(animalData)
    if not animalData then return nil end
    local cached = AutoGrab.PromptMemoryCache[animalData.uid]
    if cached and cached.Parent then return cached end

    local plot = workspace.Plots:FindFirstChild(animalData.plot)
    if not plot then return nil end
    local podiums = plot:FindFirstChild("AnimalPodiums")
    if not podiums then return nil end
    local podium = podiums:FindFirstChild(animalData.slot)
    if not podium then return nil end
    local base = podium:FindFirstChild("Base")
    if not base then return nil end
    local spawn = base:FindFirstChild("Spawn")
    if not spawn then return nil end
    local attach = spawn:FindFirstChild("PromptAttachment")
    if not attach then return nil end

    for _, p in ipairs(attach:GetChildren()) do
        if p:IsA("ProximityPrompt") then
            AutoGrab.PromptMemoryCache[animalData.uid] = p
            return p
        end
    end
    return nil
end

local function getAnimalPosition(animalData)
    local plot = workspace.Plots:FindFirstChild(animalData.plot)
    if not plot then return nil end
    local podiums = plot:FindFirstChild("AnimalPodiums")
    if not podiums then return nil end
    local podium = podiums:FindFirstChild(animalData.slot)
    if not podium then return nil end
    return podium:GetPivot().Position
end

local function distToAnimal(animalData)
    local character = LP.Character
    if not character then return math.huge end
    local hrp = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("UpperTorso")
    if not hrp then return math.huge end
    local pos = getAnimalPosition(animalData)
    if not pos then return math.huge end
    return (hrp.Position - pos).Magnitude
end

local function pickClosestAnimal()
    local character = LP.Character
    if not character then return nil end
    local hrp = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("UpperTorso")
    if not hrp then return nil end

    local best, bestDist = nil, math.huge
    for _, animalData in ipairs(AutoGrab.allAnimalsCache) do
        if isMyBaseAnimal(animalData) then continue end
        local pos = getAnimalPosition(animalData)
        if not pos then continue end
        local dist = (hrp.Position - pos).Magnitude
        if dist > AutoGrab.PRIME_RANGE then continue end
        if dist < bestDist then
            bestDist = dist
            best = animalData
        end
    end
    return best
end

local function buildStealCallbacks(prompt)
    if AutoGrab.InternalStealCache[prompt] then return end
    local data = { holdCallbacks = {}, triggerCallbacks = {}, ready = true }

    local ok1, conns1 = pcall(getconnections, prompt.PromptButtonHoldBegan)
    if ok1 and type(conns1) == "table" then
        for _, conn in ipairs(conns1) do
            if type(conn.Function) == "function" then
                table.insert(data.holdCallbacks, conn.Function)
            end
        end
    end

    local ok2, conns2 = pcall(getconnections, prompt.Triggered)
    if ok2 and type(conns2) == "table" then
        for _, conn in ipairs(conns2) do
            if type(conn.Function) == "function" then
                table.insert(data.triggerCallbacks, conn.Function)
            end
        end
    end

    if (#data.holdCallbacks > 0) or (#data.triggerCallbacks > 0) then
        AutoGrab.InternalStealCache[prompt] = data
    end
end

local function executeStealAsync(prompt, animalData)
    local data = AutoGrab.InternalStealCache[prompt]
    if not data or not data.ready then return false end
    data.ready = false

    local label = animalData.name or "Animal"
    AutoGrab.StealState.active = true
    AutoGrab.StealState.startTime = tick()
    AutoGrab.StealState.phase = "holding"
    AutoGrab.StealState.label = label
    AutoGrab.isStealing = true

    task.spawn(function()
        for _, fn in ipairs(data.holdCallbacks) do task.spawn(fn) end

        local holdStart = tick()
        while tick() - holdStart < AutoGrab.HOLD_MIN do
            local elapsed = tick() - AutoGrab.StealState.startTime
            local p = math.clamp(elapsed / AutoGrab.HOLD_MAX, 0, 1)
            updateGrabProgressBar(p)
            task.wait()
        end

        AutoGrab.StealState.phase = "waitingRange"
        local alreadyInRange = distToAnimal(animalData) <= AutoGrab.STEAL_RANGE
        local fired = false

        while true do
            local elapsed = tick() - AutoGrab.StealState.startTime
            if elapsed > AutoGrab.HOLD_MAX then break end
            if not prompt.Parent then break end
            if distToAnimal(animalData) <= AutoGrab.STEAL_RANGE then
                if not alreadyInRange then task.wait(AutoGrab.ENTRY_DELAY) end
                for _, fn in ipairs(data.triggerCallbacks) do task.spawn(fn) end
                fired = true
                break
            end
            local p = math.clamp(elapsed / AutoGrab.HOLD_MAX, 0, 1)
            updateGrabProgressBar(p)
            task.wait()
        end

        if fired then
            AutoGrab.StealState.totalSteals = AutoGrab.StealState.totalSteals + 1
            AutoGrab.StealState.lastResult = "Stole " .. label
            updateGrabProgressBar(1)
            task.wait(0.3)
            updateGrabProgressBar(0)
        else
            AutoGrab.StealState.failedSteals = AutoGrab.StealState.failedSteals + 1
            AutoGrab.StealState.lastResult = "Missed: " .. label
            updateGrabProgressBar(0)
        end

        AutoGrab.StealState.active = false
        AutoGrab.StealState.phase = "idle"
        AutoGrab.StealState.lastResultTime = tick()
        AutoGrab.isStealing = false

        task.wait(AutoGrab.COOLDOWN)
        data.ready = true
    end)
    return true
end

local function attemptSteal(prompt, animalData)
    if not prompt or not prompt.Parent then return false end
    buildStealCallbacks(prompt)
    if not AutoGrab.InternalStealCache[prompt] then return false end
    return executeStealAsync(prompt, animalData)
end

local function scanAllPlots()
    local newCache = {}
    for _, plot in ipairs(plots:GetChildren()) do
        local cache = getPlotChannelData(plot.Name)
        if not cache then continue end
        local animalList = cache.AnimalList
        if typeof(animalList) ~= "table" then continue end
        for slot, animalData in pairs(animalList) do
            if type(animalData) == "table" then
                local animalName = animalData.Index
                local animalInfo = AnimalsData[animalName]
                if not animalInfo then continue end
                table.insert(newCache, {
                    name = animalInfo.DisplayName or animalName,
                    plot = plot.Name,
                    slot = tostring(slot),
                    uid = plot.Name .. "_" .. tostring(slot),
                })
            end
        end
    end
    AutoGrab.allAnimalsCache = newCache
    return #AutoGrab.allAnimalsCache
end

local function startAutoSteal()
    if AutoGrab.stealConnection then return end
    AutoGrab.stealConnection = RunService.Heartbeat:Connect(function()
        if not AutoGrab.AUTO_STEAL_ENABLED then return end
        if AutoGrab.StealState.active then return end
        local target = pickClosestAnimal()
        if not target then return end
        local prompt = AutoGrab.PromptMemoryCache[target.uid]
        if not prompt or not prompt.Parent then
            prompt = findProximityPromptForAnimal(target)
        end
        if prompt then attemptSteal(prompt, target) end
    end)
end

local function stopAutoSteal()
    if not AutoGrab.stealConnection then return end
    AutoGrab.stealConnection:Disconnect()
    AutoGrab.stealConnection = nil
end

-- Inicializar Auto Grab
setupAutoGrabUI()
scanAllPlots()
if AutoGrab.AUTO_STEAL_ENABLED then startAutoSteal() end

task.spawn(function()
    while task.wait(5) do scanAllPlots() end
end)

-- ============================================================
-- NINO TIME (STUN TIMER)
-- ============================================================
local stunTimerEnabled = true
local stunTimerGuiBB = nil
local stunTimerText = nil
local stunActive = false
local stunStartTime = 0
local stunDuration = 3.0
local stunConnection = nil
local stateChangedConnection = nil
local lastDisplayedSecond = nil

local function createStunTimerBillboard()
    if stunTimerGuiBB then 
        pcall(function() stunTimerGuiBB.Enabled = stunTimerEnabled end)
        return 
    end
    local char = LP.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end

    stunTimerGuiBB = Instance.new("BillboardGui")
    stunTimerGuiBB.Name = "NinoTimeBB"
    stunTimerGuiBB.Adornee = head
    stunTimerGuiBB.Size = UDim2.new(0, 120, 0, 36)
    stunTimerGuiBB.StudsOffset = Vector3.new(0, 3, 0)
    stunTimerGuiBB.AlwaysOnTop = true
    stunTimerGuiBB.Parent = head
    stunTimerGuiBB.Enabled = stunTimerEnabled

    stunTimerText = Instance.new("TextLabel", stunTimerGuiBB)
    stunTimerText.Size = UDim2.new(1, 0, 1, 0)
    stunTimerText.BackgroundTransparency = 1
    stunTimerText.Text = "READY!!"
    stunTimerText.TextColor3 = Color3.fromRGB(0, 255, 100)
    stunTimerText.TextScaled = true
    stunTimerText.Font = Enum.Font.GothamBlack
    stunTimerText.TextStrokeTransparency = 0.3
    stunTimerText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    stunTimerText.TextXAlignment = Enum.TextXAlignment.Center
    stunTimerText.TextYAlignment = Enum.TextYAlignment.Center
end

local function updateStunDisplay()
    if not stunTimerText then 
        createStunTimerBillboard()
        if not stunTimerText then return end
    end

    if not stunActive then
        stunTimerText.Text = "READY!!"
        stunTimerText.TextColor3 = Color3.fromRGB(0, 255, 100)
        stunTimerText.TextScaled = true
        if stunTimerGuiBB then stunTimerGuiBB.Enabled = stunTimerEnabled end
        return
    end

    local remaining = math.max(0, stunDuration - (tick() - stunStartTime))
    if remaining <= 0 then
        stunActive = false
        if stunConnection then stunConnection:Disconnect(); stunConnection = nil end
        stunTimerText.Text = "READY!!"
        stunTimerText.TextColor3 = Color3.fromRGB(0, 255, 100)
        stunTimerText.TextScaled = true
        return
    end

    local second = math.ceil(remaining)
    if second ~= lastDisplayedSecond then
        lastDisplayedSecond = second
        stunTimerText.Text = tostring(second)
        stunTimerText.TextScaled = true
        if second == 3 then
            stunTimerText.TextColor3 = Color3.fromRGB(255, 0, 0)
        elseif second == 2 then
            stunTimerText.TextColor3 = Color3.fromRGB(255, 255, 0)
        elseif second == 1 then
            stunTimerText.TextColor3 = Color3.fromRGB(0, 255, 255)
        end
    end
    if stunTimerGuiBB then stunTimerGuiBB.Enabled = true end
end

local function onStunDetected()
    if not stunTimerEnabled or stunActive then return end
    stunActive = true
    stunStartTime = tick()
    lastDisplayedSecond = nil
    createStunTimerBillboard()
    updateStunDisplay()
    if stunConnection then stunConnection:Disconnect() end
    stunConnection = RunService.Heartbeat:Connect(updateStunDisplay)
end

local function setupStunDetection(char)
    if stateChangedConnection then stateChangedConnection:Disconnect() end
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    stateChangedConnection = hum.StateChanged:Connect(function(_, newState)
        if not stunTimerEnabled then return end
        local isStunned = (newState == Enum.HumanoidStateType.Physics or
                           newState == Enum.HumanoidStateType.Ragdoll or
                           newState == Enum.HumanoidStateType.FallingDown or
                           newState == Enum.HumanoidStateType.GettingUp or
                           newState == Enum.HumanoidStateType.Stunned)
        if isStunned then onStunDetected() end
    end)
end

local function startNinoTime()
    stunTimerEnabled = true
    createStunTimerBillboard()
    local char = LP.Character
    if char then setupStunDetection(char) end
end

local function stopNinoTime()
    stunTimerEnabled = false
    if stunConnection then stunConnection:Disconnect(); stunConnection = nil end
    if stateChangedConnection then stateChangedConnection:Disconnect(); stateChangedConnection = nil end
    stunActive = false
    if stunTimerGuiBB then 
        pcall(function() stunTimerGuiBB.Enabled = false end)
    end
end

-- ============================================================
-- GALAXY MODE
-- ============================================================
local galaxyOn = false
local defBrightness, defClock, defAmbient = Lighting.Brightness, Lighting.ClockTime, Lighting.OutdoorAmbient

local function updateGalaxy()
    if galaxyOn then
        local sky = Lighting:FindFirstChild("NinoGalaxySky") or Instance.new("Sky")
        sky.Name = "NinoGalaxySky"
        sky.SkyboxBk = "rbxassetid://90008389385236"
        sky.SkyboxDn = "rbxassetid://135894687762727"
        sky.SkyboxFt = "rbxassetid://135894687762727"
        sky.SkyboxLf = "rbxassetid://135894687762727"
        sky.SkyboxRt = "rbxassetid://135894687762727"
        sky.SkyboxUp = "rbxassetid://135894687762727"
        sky.Parent = Lighting
        Lighting.Brightness = 0
        Lighting.ClockTime = 0
        Lighting.ExposureCompensation = -2
        Lighting.OutdoorAmbient = Color3.fromRGB(0, 0, 0)
    else
        if Lighting:FindFirstChild("NinoGalaxySky") then Lighting.NinoGalaxySky:Destroy() end
        Lighting.Brightness = defBrightness
        Lighting.ClockTime = defClock
        Lighting.ExposureCompensation = 0
        Lighting.OutdoorAmbient = defAmbient
    end
end

local function toggleGalaxyMode()
    galaxyOn = not galaxyOn
    updateGalaxy()
end

local removedAccessories = {}

local function removeCharacterAccessories()
    local char = LP.Character
    if not char then return end
    for _, child in ipairs(char:GetChildren()) do
        if child:IsA("Accessory") or child:IsA("Hat") or (child:IsA("Model") and child:FindFirstChild("Handle")) then
            table.insert(removedAccessories, {parent = child.Parent, acc = child})
            child.Parent = nil
        end
    end
end

local function restoreAccessories()
    for _, item in ipairs(removedAccessories) do
        if item.acc and not item.acc.Parent then
            item.acc.Parent = item.parent
        end
    end
    removedAccessories = {}
end

local function safeWritefile(path, data) if type(writefile) == "function" then pcall(writefile, path, data) end end
local function safeReadfile(path) if type(readfile) == "function" then local ok, data = pcall(readfile, path) return ok and data or nil end return nil end
local function safeIsfile(path) if type(isfile) == "function" then local ok, res = pcall(isfile, path) return ok and res end return false end
local function safeSetfpscap(v) if type(setfpscap) == "function" then pcall(setfpscap, v) end end
local function safeSethiddenproperty(obj, prop, val) if type(sethiddenproperty) == "function" then pcall(sethiddenproperty, obj, prop, val) end end

-- ============================================================
-- SCRIPT PRINCIPAL NINO HUB
-- ============================================================
local S = {
    -- VALORES DE VELOCIDAD
    NS = 60,      -- Velocidad Normal
    CS = 30,      -- Velocidad Carry Mode  
    LS = 10.1,    -- Velocidad Lagger 1
    LS2 = 10,     -- Velocidad Lagger 2
    
    -- ESTADOS
    speedMode = false,    -- Carry Mode activado?
    laggerMode = 0,       -- 0=OFF, 1=Modo1(10.1), 2=Modo2(10)
    
    antiRagdollEnabled = false, 
    medusaCounterEnabled = false,
    medusaDebounce = false, medusaLastUsed = 0, medusaConns = {}, MEDUSA_COOLDOWN = 25,
    unwalkEnabled = false,
    -- NOTA: autoLeftEnabled y autoRightEnabled ahora controlan AutoPlay
    autoLeftEnabled = false, 
    autoRightEnabled = false,
    autoLeftSetVisual = nil, 
    autoRightSetVisual = nil,
    _btnAAL = nil, _bsAAL = nil, _l1AAL = nil, _l2AAL = nil,
    _btnAAR = nil, _bsAAR = nil, _l1AAR = nil, _l2AAR = nil,
    _btnBAT = nil, _bsBAT = nil, _l1BAT = nil, _l2BAT = nil,
    _setPButtonActive = nil, speedCounterLabel = nil,
    batAimbotEnabled = false, batAimbotSetVisual = nil, batAimbotConn = nil,
    batAimbotSpeed = 56.5,
    batCounterEnabled = false, batCounterConn = nil, batCounterDebounce = false,
    setBatCounterVisual = nil,
    fpsBoostEnabled = false,
    lockUIEnabled = false,
    mainMenuFrame = nil, miniToggleButton = nil, floatingPanelFrame = nil, floatingPanelGui = nil,
    bypassToggleFrame = nil,
    _noclipTimer = 0, _fpsCount = 0, _lastFpsTime = tick(), currentFPS = 0,
    alConn = nil, arConn = nil, alPhase = 1, arPhase = 1,
    progressFill = nil, progressPct = nil, progressBarFrame = nil, topBarHUD = nil,
    stealActive = false,  -- Ya no se usa, mantener por compatibilidad
    setLaggerVisual = nil, speedClk = nil, setFpsVisual = nil, setInfJumpVisual = nil,
    setAntiRagVisual = nil, setMedusaVisual = nil,
    setUnwalkVisual = nil, setDarkVisual = nil, setInstaGrab = nil,
    normalBox = nil, carryBox = nil, laggerBox = nil, lagger2Box = nil,
    radInput = nil, setLockUI_Visual = nil, setHideOpiumButtons = nil,
    autoTpDownEnabled = false,
    autoTpDownYTarget = -9,
    autoTpDownHeightLimit = 20,
    autoTpDownTimer = 0,
    autoTpDownConn = nil,
    autoTpDownSetVisual = nil, autoTpDownFloatVisual = nil,
    hudScale = 1,
    stealDurationBox = nil,
    dropBrainrotActive = false,
    infJumpEnabled = false,
    holdJumpEnabled = false,
    setHoldJumpVisual = nil,
    ninoTimeEnabled = true,
    setNinoTimeVisual = nil,
    -- Steal antiguo (reemplazado, se mantiene estructura vacía)
    Steal = {
        AutoStealEnabled = false, StealRadius = 20, StealDuration = 0.9,
        Data = {}, plotCache = {}, plotCacheTime = {}, cachedPrompts = {}, promptCacheTime = 0,
        isStealing = false, stealStartTime = nil, lastStealTick = 0,
    },
    KB = {
        DropBrainrot = {kb = Enum.KeyCode.X, gp = Enum.KeyCode.ButtonR2},
        AutoLeft = {kb = Enum.KeyCode.Z, gp = Enum.KeyCode.DPadLeft},
        AutoRight = {kb = Enum.KeyCode.C, gp = Enum.KeyCode.DPadRight},
        AutoBat = {kb = Enum.KeyCode.E, gp = Enum.KeyCode.ButtonY},
        TPFlor = {kb = Enum.KeyCode.F, gp = Enum.KeyCode.ButtonA},
        GuiHide = {kb = Enum.KeyCode.LeftControl, gp = Enum.KeyCode.ButtonSelect},
        SpeedToggle = {kb = Enum.KeyCode.Q, gp = Enum.KeyCode.DPadUp},
        LaggerToggle = {kb = Enum.KeyCode.R, gp = Enum.KeyCode.DPadDown},
        AutoTPDown = {kb = Enum.KeyCode.T, gp = nil},
    },
    AP = {
        L1 = Vector3.new(-476.48, -6.28, 92.73), L2 = Vector3.new(-482.85, -5.03, 93.13),
        L_FACE = Vector3.new(-482.25, -4.96, 92.09),
        R1 = Vector3.new(-476.16, -6.52, 25.62), R2 = Vector3.new(-483.06, -5.03, 27.51),
        R_FACE = Vector3.new(-482.06, -6.93, 35.47),
    },
    Conns = {antiRag = nil, anchor = {}, progress = nil},
    moveConn = nil, speedEnabled = true, h = nil, hrp = nil,
    lastMoveDir = Vector3.new(0,0,0),
    MOVE_KEYS = {
        [Enum.KeyCode.W] = true, [Enum.KeyCode.A] = true,
        [Enum.KeyCode.S] = true, [Enum.KeyCode.D] = true,
        [Enum.KeyCode.Up] = true, [Enum.KeyCode.Left] = true,
        [Enum.KeyCode.Down] = true, [Enum.KeyCode.Right] = true,
    },
    IS_TOUCH_DEVICE = UIS.TouchEnabled,
    IS_MOBILE = UIS.TouchEnabled and not UIS.KeyboardEnabled,
    CONFIG_FILE = "NinohubPC.json",
    _floatingButtons = {},
    BAT_HIT_RANGE = 16,
}

-- ============================================================
-- FUNCIONES PARA AUTO PLAY (reemplazan startAutoLeft/Right)
-- ============================================================
function startAutoLeft()
    -- Ahora inicia AutoPlay hacia la izquierda
    setAutoPlay("left", true)
end

function stopAutoLeft()
    setAutoPlay("left", false)
end

function startAutoRight()
    -- Ahora inicia AutoPlay hacia la derecha
    setAutoPlay("right", true)
end

function stopAutoRight()
    setAutoPlay("right", false)
end

-- Actualizar UI de los botones de AutoPlay
local function updateAutoPlayUI()
    if S.autoLeftSetVisual then 
        S.autoLeftSetVisual(AutoPlay.Enabled and AutoPlay.Side == "left")
    end
    if S.autoRightSetVisual then 
        S.autoRightSetVisual(AutoPlay.Enabled and AutoPlay.Side == "right")
    end
    if S._setPButtonActive and S._btnAAL then
        S._setPButtonActive(S._btnAAL, S._bsAAL, S._l1AAL, S._l2AAL, AutoPlay.Enabled and AutoPlay.Side == "left")
    end
    if S._setPButtonActive and S._btnAAR then
        S._setPButtonActive(S._btnAAR, S._bsAAR, S._l1AAR, S._l2AAR, AutoPlay.Enabled and AutoPlay.Side == "right")
    end
end

-- FUNCIÓN PARA OBTENER VELOCIDAD ACTIVA
function S.getActiveSpeed()
    if S.laggerMode == 1 then 
        return S.LS      -- 10.1
    elseif S.laggerMode == 2 then 
        return S.LS2     -- 10
    elseif S.speedMode then 
        return S.CS      -- 30
    else 
        return S.NS      -- 60
    end
end

local SWING_COOLDOWN = 0.25
local hittingCooldown = false

local BAT_SLAP_LIST = { "Bat", "Slap", "Iron Slap", "Gold Slap", "Diamond Slap", "Emerald Slap", "Ruby Slap", "Dark Matter Slap", "Flame Slap", "Nuclear Slap", "Galaxy Slap", "Glitched Slap" }
local HIT_DIST = 8

local function getBatOriginal()
    local char = LP.Character; if not char then return nil end
    for _, name in ipairs(BAT_SLAP_LIST) do
        local t = char:FindFirstChild(name)
        if t and t:IsA("Tool") then return t end
    end
    local bp = LP:FindFirstChildOfClass("Backpack")
    if bp then
        for _, name in ipairs(BAT_SLAP_LIST) do
            local t = bp:FindFirstChild(name)
            if t and t:IsA("Tool") then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then pcall(function() hum:EquipTool(t) end) end
                return t
            end
        end
    end
    for _, ch in ipairs(char:GetChildren()) do
        if ch:IsA("Tool") and (ch.Name:lower():find("bat") or ch.Name:lower():find("slap")) then return ch end
    end
    if bp then
        for _, ch in ipairs(bp:GetChildren()) do
            if ch:IsA("Tool") and (ch.Name:lower():find("bat") or ch.Name:lower():find("slap")) then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then pcall(function() hum:EquipTool(ch) end) end
                return ch
            end
        end
    end
    return nil
end

local function trySwingOriginal()
    if hittingCooldown then return end
    hittingCooldown = true
    pcall(function()
        local char = LP.Character
        if char then
            local bat = getBatOriginal()
            if bat then
                if bat.Parent ~= char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then pcall(function() hum:EquipTool(bat) end) end
                end
                pcall(function() bat:Activate() end)
            end
        end
    end)
    task.delay(SWING_COOLDOWN, function() hittingCooldown = false end)
end

local function getClosestPlayerOriginal()
    if not S.hrp then return nil, math.huge end
    local cp, cd = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local tr = p.Character:FindFirstChild("HumanoidRootPart")
            local ph = p.Character:FindFirstChildOfClass("Humanoid")
            if tr and ph and ph.Health > 0 then
                local d = (S.hrp.Position - tr.Position).Magnitude
                if d < cd then cd = d; cp = p end
            end
        end
    end
    return cp, cd
end

S.ui = function(pcVal, mobVal) return S.IS_MOBILE and mobVal or pcVal end

local saveConfig
local updateFloatingButtons

local function updateHudScale()
    if S.topBarHUD then
        local width = 235 * S.hudScale
        local height = 29 * S.hudScale
        S.topBarHUD.Size = UDim2.new(0, width, 0, height)
        S.topBarHUD.Position = UDim2.new(0.5, -width/2, 0, 12)
    end
    if S.progressBarFrame then
        local width = 235 * S.hudScale
        local height = 15 * S.hudScale
        S.progressBarFrame.Size = UDim2.new(0, width, 0, height)
        S.progressBarFrame.Position = UDim2.new(0.5, -width/2, 0, 12 + 29 * S.hudScale + 5)
    end
end

local function updateLaggerButtonVisual()
    local fb = S._floatingButtons
    if not fb.lagger then return end
    local text = ""
    local active = false
    if S.speedMode then
        text = "OFF"
        active = false
    else
        if S.laggerMode == 1 then
            text = "1"
            active = true
        elseif S.laggerMode == 2 then
            text = "2"
            active = true
        else
            text = "OFF"
            active = false
        end
    end
    fb.l2Lagger.Text = text
    S._setPButtonActive(fb.lagger, fb.strokeLagger, fb.l1Lagger, fb.l2Lagger, active)
end

S.setupSpeedBillboard = function(char)
    local head = char:WaitForChild("Head", 5)
    if not head then return end
    local oldBB = head:FindFirstChild("NinoSpeedBB")
    if oldBB then oldBB:Destroy() end
    local bb = Instance.new("BillboardGui", head)
    bb.Name = "NinoSpeedBB"
    bb.Size = UDim2.new(0, 100, 0, 32)
    bb.StudsOffset = Vector3.new(0, 2.5, 0)
    bb.AlwaysOnTop = true
    local speedLbl = Instance.new("TextLabel", bb)
    speedLbl.Name = "SpeedBillLbl"
    speedLbl.Size = UDim2.new(1,0,1,0)
    speedLbl.BackgroundTransparency = 1
    speedLbl.Text = "0"
    speedLbl.TextColor3 = Color3.fromRGB(210,210,210)
    speedLbl.Font = Enum.Font.GothamBlack
    speedLbl.TextScaled = true
    speedLbl.TextStrokeTransparency = 0.1
    speedLbl.TextStrokeColor3 = Color3.new(0,0,0)
    S.speedCounterLabel = speedLbl
end

local _lastSpeedDisplay = -1
RunService.Heartbeat:Connect(function()
    if not (S.h and S.hrp) or not S.speedCounterLabel then return end
    local baseSpeed = S.getActiveSpeed()
    if baseSpeed ~= _lastSpeedDisplay then
        _lastSpeedDisplay = baseSpeed
        S.speedCounterLabel.Text = tostring(baseSpeed)
    end
end)

local DROP_ASCEND_DURATION = 0.2
local DROP_ASCEND_SPEED = 150

local function runDropBrainrot()
    if S.dropBrainrotActive then return end
    local char = LP.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    S.dropBrainrotActive = true
    local startTime = tick()
    local conn
    conn = RunService.Heartbeat:Connect(function()
        local r = char and char:FindFirstChild("HumanoidRootPart")
        if not r then
            conn:Disconnect()
            S.dropBrainrotActive = false
            return
        end
        if tick() - startTime >= DROP_ASCEND_DURATION then
            conn:Disconnect()
            local raycastParams = RaycastParams.new()
            raycastParams.FilterDescendantsInstances = {char}
            raycastParams.FilterType = Enum.RaycastFilterType.Exclude
            local rayResult = workspace:Raycast(r.Position, Vector3.new(0, -2000, 0), raycastParams)
            if rayResult then
                local hum = char:FindFirstChildOfClass("Humanoid")
                local offset = (hum and hum.HipHeight or 2) + (r.Size.Y / 2)
                r.CFrame = CFrame.new(r.Position.X, rayResult.Position.Y + offset, r.Position.Z)
                r.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            end
            S.dropBrainrotActive = false
            return
        end
        r.AssemblyLinearVelocity = Vector3.new(r.AssemblyLinearVelocity.X, DROP_ASCEND_SPEED, r.AssemblyLinearVelocity.Z)
    end)
end

S.startMovement = function()
    if S.moveConn then S.moveConn:Disconnect() end
    S.moveConn = RunService.RenderStepped:Connect(function()
        if not S.speedEnabled then return end
        if not (S.h and S.hrp) then return end
        if S.batAimbotEnabled or AutoPlay.Enabled then return end  -- AutoPlay reemplaza a autoLeft/Right
        local md = S.h.MoveDirection
        local spd = S.getActiveSpeed()
        if md.Magnitude > 0 then
            S.lastMoveDir = md
            S.hrp.Velocity = Vector3.new(md.X * spd, S.hrp.Velocity.Y, md.Z * spd)
        elseif S.antiRagdollEnabled and S.lastMoveDir.Magnitude > 0 then
            local anyHeld = false
            for key in pairs(S.MOVE_KEYS) do
                if UIS:IsKeyDown(key) then anyHeld = true; break end
            end
            if anyHeld then
                S.hrp.Velocity = Vector3.new(S.lastMoveDir.X * spd, S.hrp.Velocity.Y, S.lastMoveDir.Z * spd)
            end
        end
    end)
end

S.stopMovement = function()
    if S.moveConn then S.moveConn:Disconnect(); S.moveConn = nil end
end

S.restartMovement = function() S.stopMovement(); S.startMovement() end
S.speedEnabled = true
S.startMovement()

-- HOLD JUMP
local holdJumpConn = nil
local lastJumpTime = 0
local JUMP_COOLDOWN = 0.1

local function startHoldJump()
    if holdJumpConn then return end
    holdJumpConn = RunService.Heartbeat:Connect(function()
        if not S.holdJumpEnabled then return end
        local char = LP.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        if hum and root and hum.Health > 0 then
            local isJumping = false
            pcall(function()
                isJumping = UIS:IsKeyDown(Enum.KeyCode.Space) or hum.Jump
            end)
            if isJumping and tick() - lastJumpTime > JUMP_COOLDOWN then
                root.Velocity = Vector3.new(root.Velocity.X, 50, root.Velocity.Z)
                lastJumpTime = tick()
            end
        end
    end)
end

local function stopHoldJump()
    if holdJumpConn then
        holdJumpConn:Disconnect()
        holdJumpConn = nil
    end
end

-- INFINITE JUMP TRADICIONAL
local infJumpConn = nil
local infJumpHeartbeat = nil

function startInfiniteJump()
    if infJumpConn then return end
    infJumpConn = UIS.JumpRequest:Connect(function()
        if not S.infJumpEnabled then return end
        local char = LP.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.Velocity = Vector3.new(hrp.Velocity.X, 50, hrp.Velocity.Z)
        end
    end)
    infJumpHeartbeat = RunService.Heartbeat:Connect(function()
        if not S.infJumpEnabled then return end
        local char = LP.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        if hrp.Velocity.Y < -70 then
            hrp.Velocity = Vector3.new(hrp.Velocity.X, -70, hrp.Velocity.Z)
        end
    end)
end

function stopInfiniteJump()
    if infJumpConn then infJumpConn:Disconnect(); infJumpConn = nil end
    if infJumpHeartbeat then infJumpHeartbeat:Disconnect(); infJumpHeartbeat = nil end
end

-- AUTO TP DOWN
local function startAutoTpDown()
    if S.autoTpDownConn then S.autoTpDownConn:Disconnect() end
    S.autoTpDownTimer = 0
    S.autoTpDownConn = RunService.Heartbeat:Connect(function(dt)
        S.autoTpDownTimer = S.autoTpDownTimer + dt
        if S.autoTpDownTimer < 0.05 then return end
        S.autoTpDownTimer = 0
        
        if not S.autoTpDownEnabled then return end
        if S.dropBrainrotActive then return end
        
        local char = LP.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        if root.Position.Y >= S.autoTpDownHeightLimit then
            local rot = root.CFrame.Rotation
            root.CFrame = CFrame.new(root.Position.X, S.autoTpDownYTarget, root.Position.Z) * rot
            root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, 0, root.AssemblyLinearVelocity.Z)
        end
    end)
end

local function stopAutoTpDown()
    if S.autoTpDownConn then S.autoTpDownConn:Disconnect(); S.autoTpDownConn = nil end
end

-- ============================================================
-- BAT AIMBOT NORMAL
-- ============================================================
local prevAutoRotate = nil
local aimbotConn = nil

local function startBatAimbot()
    if aimbotConn then return end
    local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        if prevAutoRotate == nil then prevAutoRotate = hum.AutoRotate end
        hum.AutoRotate = false
    end
    aimbotConn = RunService.RenderStepped:Connect(function()
        if not S.batAimbotEnabled then return end
        local char = LP.Character; if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart"); if not root then return end
        local hum = char:FindFirstChildOfClass("Humanoid"); if not hum then return end
        if not char:FindFirstChildOfClass("Tool") then
            local bat = getBatOriginal()
            if bat then pcall(function() hum:EquipTool(bat) end) end
        end
        local targetPlr, targetDist = getClosestPlayerOriginal()
        if not targetPlr or not targetPlr.Character then return end
        local target = targetPlr.Character:FindFirstChild("HumanoidRootPart")
        if not target then return end
        local targetVel = target.AssemblyLinearVelocity
        local myPos = root.Position
        local targetPos = target.Position
        local predictPos = targetPos + targetVel * 0.14 + target.CFrame.LookVector * 0.3
        local direction = predictPos - myPos
        local flatDir = Vector3.new(direction.X, 0, direction.Z)
        if flatDir.Magnitude > 0 then flatDir = flatDir.Unit else flatDir = Vector3.new(0,0,0) end        
        local desiredHeight = targetPos.Y + 3.7
        local yVel = (desiredHeight - myPos.Y) * 19.5 + targetVel.Y * 0.8
        if hum.FloorMaterial ~= Enum.Material.Air then yVel = math.max(yVel, 13) end
        yVel = math.clamp(yVel, -70, 110)
        local desiredVel = Vector3.new(flatDir.X * S.batAimbotSpeed, yVel, flatDir.Z * S.batAimbotSpeed)
        root.AssemblyLinearVelocity = root.AssemblyLinearVelocity:Lerp(desiredVel, 0.8)
        local speed3 = targetVel.Magnitude
        local predictTime = math.clamp(speed3 / 150, 0.05, 0.2)
        local predictedPos = targetPos + targetVel * predictTime
        local toPredict = predictedPos - myPos
        if toPredict.Magnitude > 0.1 then
            local goalCF = CFrame.lookAt(myPos, predictedPos)
            local diffCF = root.CFrame:Inverse() * goalCF
            local rx, ry, rz = diffCF:ToEulerAnglesXYZ()
            rx = math.clamp(rx, -2.5, 2.5); ry = math.clamp(ry, -2.5, 2.5); rz = math.clamp(rz, -2.5, 2.5)
            root.AssemblyAngularVelocity = root.CFrame:VectorToWorldSpace(Vector3.new(rx * 42, ry * 42, rz * 42))
        end
        if targetDist <= HIT_DIST then trySwingOriginal() end
    end)
end

local function stopBatAimbot()
    if aimbotConn then aimbotConn:Disconnect(); aimbotConn = nil end
    local char = LP.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.AutoRotate = (prevAutoRotate == nil) and true or prevAutoRotate
        hum.PlatformStand = false
        pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end)
    end
    if root then
        root.AssemblyLinearVelocity = Vector3.new(0, root.AssemblyLinearVelocity.Y * 0.3, 0)
        root.AssemblyAngularVelocity = Vector3.zero
    end
    prevAutoRotate = nil
end

local function setBatAimbot(state)
    if S.batAimbotEnabled == state then return end
    S.batAimbotEnabled = state
    if state then
        if AutoPlay.Enabled then
            setAutoPlay(AutoPlay.Side, false)
        end
        startBatAimbot()
    else
        stopBatAimbot()
    end
    if S.batAimbotSetVisual then S.batAimbotSetVisual(state) end
    if S._setPButtonActive and S._btnBAT then
        S._setPButtonActive(S._btnBAT, S._bsBAT, S._l1BAT, S._l2BAT, state)
    end
    S.restartMovement()
    saveConfig()
end

-- ============================================================
-- AIMBOT BYPASS
-- ============================================================
local bypassState = {
    enabled = false,
    hittingCooldown = false,
    batSpeed = 56.5,
}
local bypassH, bypassHrp

local function getBatBypass()
    local char = LP.Character; if not char then return nil end
    local tool = char:FindFirstChild("Bat"); if tool then return tool end
    local bp2 = LP:FindFirstChild("Backpack")
    if bp2 then
        tool = bp2:FindFirstChild("Bat")
        if tool then tool.Parent = char; return tool end
    end
    return nil
end

local function tryHitBatBypass()
    if bypassState.hittingCooldown then return end
    bypassState.hittingCooldown = true
    pcall(function()
        local bat = getBatBypass()
        if bat then
            bat:Activate()
            local ev = bat:FindFirstChildWhichIsA("RemoteEvent")
            if ev then ev:FireServer() end
        end
    end)
    task.delay(0.08, function() bypassState.hittingCooldown = false end)
end

local function getClosestPlayerForBypass()
    if not bypassHrp then return nil, math.huge end
    local cp, cd = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local tr = p.Character:FindFirstChild("HumanoidRootPart")
            if tr then
                local d = (bypassHrp.Position - tr.Position).Magnitude
                if d < cd then cd = d; cp = p end
            end
        end
    end
    return cp, cd
end

local bypassAimbotConn = nil
local function startBypassAimbot()
    if bypassAimbotConn then return end
    bypassAimbotConn = RunService.Heartbeat:Connect(function()
        if not bypassState.enabled then return end
        if not (bypassH and bypassHrp) then return end
        local target, dist = getClosestPlayerForBypass()
        if target and target.Character then
            local tr = target.Character:FindFirstChild("HumanoidRootPart")
            if tr then
                local fp = tr.Position + tr.CFrame.LookVector * 1.5
                local dir = (fp - bypassHrp.Position).Unit
                local spd = bypassState.batSpeed
                bypassHrp.Velocity = Vector3.new(dir.X*spd, dir.Y*spd, dir.Z*spd)
                if dist <= 5 then tryHitBatBypass() end
            end
        end
    end)
end

local function stopBypassAimbot()
    if bypassAimbotConn then bypassAimbotConn:Disconnect(); bypassAimbotConn = nil end
end

local function setBypassEnabled(state)
    bypassState.enabled = state
    if state then
        startBypassAimbot()
    else
        stopBypassAimbot()
    end
end

local function setupBypassChar(char)
    task.wait(0.1)
    bypassH = char:WaitForChild("Humanoid", 5)
    bypassHrp = char:WaitForChild("HumanoidRootPart", 5)
end
LP.CharacterAdded:Connect(setupBypassChar)
if LP.Character then task.spawn(function() setupBypassChar(LP.Character) end) end

-- ============================================================
-- PANEL FLOTANTE DEL AIMBOT BYPASS
-- ============================================================
local bypassPanelGui = Instance.new("ScreenGui")
bypassPanelGui.Name = "NinoBypassToggle"
bypassPanelGui.ResetOnSpawn = false
bypassPanelGui.DisplayOrder = 9
bypassPanelGui.IgnoreGuiInset = true
bypassPanelGui.Parent = LP:WaitForChild("PlayerGui")

local bypassPanelFrame = Instance.new("Frame", bypassPanelGui)
bypassPanelFrame.Name = "BypassToggle"
bypassPanelFrame.Size = UDim2.new(0, 160, 0, 48)
bypassPanelFrame.Position = UDim2.new(1, -175, 0.5, -100)
bypassPanelFrame.BackgroundColor3 = Color3.fromRGB(4,4,6)
bypassPanelFrame.BackgroundTransparency = 0
bypassPanelFrame.BorderSizePixel = 0
bypassPanelFrame.Active = true
Instance.new("UICorner", bypassPanelFrame).CornerRadius = UDim.new(0,10)
local bypassStrokeFrame = Instance.new("UIStroke", bypassPanelFrame)
bypassStrokeFrame.Color = Color3.fromRGB(40,40,40)
bypassStrokeFrame.Thickness = 1
S.bypassToggleFrame = bypassPanelFrame

local bypassDragging = false
local bypassDragStart = nil
local bypassStartPos = nil

bypassPanelFrame.InputBegan:Connect(function(inp)
    if S.lockUIEnabled then return end
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        bypassDragging = true
        bypassDragStart = inp.Position
        bypassStartPos = bypassPanelFrame.Position
    end
end)

UIS.InputChanged:Connect(function(inp)
    if S.lockUIEnabled or not bypassDragging then return end
    if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
        local delta = inp.Position - bypassDragStart
        if delta.Magnitude > 2 then
            local newX = bypassStartPos.X.Offset + delta.X
            local newY = bypassStartPos.Y.Offset + delta.Y
            bypassPanelFrame.Position = UDim2.new(bypassStartPos.X.Scale, newX, bypassStartPos.Y.Scale, newY)
            saveConfig()
        end
    end
end)

UIS.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        bypassDragging = false
    end
end)

local bypassBtn = Instance.new("TextButton", bypassPanelFrame)
bypassBtn.Size = UDim2.new(1, -10, 1, -10)
bypassBtn.Position = UDim2.new(0,5,0,5)
bypassBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
bypassBtn.BorderSizePixel = 0
bypassBtn.Text = ""
Instance.new("UICorner", bypassBtn).CornerRadius = UDim.new(0,8)
local bypassBtnStroke = Instance.new("UIStroke", bypassBtn)
bypassBtnStroke.Color = Color3.fromRGB(55,55,55)
bypassBtnStroke.Thickness = 1
local bypassBtnLabel = Instance.new("TextLabel", bypassBtn)
bypassBtnLabel.Size = UDim2.new(1,0,1,0)
bypassBtnLabel.BackgroundTransparency = 1
bypassBtnLabel.Text = "AIMBOT\nBYPASS"
bypassBtnLabel.TextColor3 = Color3.fromRGB(255,255,255)
bypassBtnLabel.Font = Enum.Font.GothamBlack
bypassBtnLabel.TextSize = 14
bypassBtnLabel.TextWrapped = true
bypassBtnLabel.TextXAlignment = Enum.TextXAlignment.Center

bypassBtn.InputBegan:Connect(function(inp)
    if S.lockUIEnabled then return end
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        bypassDragging = true
        bypassDragStart = inp.Position
        bypassStartPos = bypassPanelFrame.Position
    end
end)

local function setBypassButtonActive(state)
    if state then
        bypassBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
        bypassBtnStroke.Color = Color3.fromRGB(150,150,150)
        bypassBtnLabel.TextColor3 = Color3.fromRGB(0,0,0)
    else
        bypassBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
        bypassBtnStroke.Color = Color3.fromRGB(55,55,55)
        bypassBtnLabel.TextColor3 = Color3.fromRGB(255,255,255)
    end
end

bypassBtn.MouseButton1Click:Connect(function()
    local newState = not bypassState.enabled
    setBypassEnabled(newState)
    setBypassButtonActive(newState)
    saveConfig()
end)

-- ============================================================
-- BAT COUNTER
-- ============================================================
local BAT_COUNTER_SLAP_LIST = {"Bat","Slap","Iron Slap","Gold Slap","Diamond Slap","Emerald Slap","Ruby Slap","Dark Matter Slap","Flame Slap","Nuclear Slap","Galaxy Slap","Glitched Slap"}

local function findBatForCounter()
    local c = LP.Character; if not c then return nil end
    local bp = LP:FindFirstChildOfClass("Backpack")
    for _, name in ipairs(BAT_COUNTER_SLAP_LIST) do
        local t = c:FindFirstChild(name) or (bp and bp:FindFirstChild(name))
        if t then return t end
    end
    for _, ch in ipairs(c:GetChildren()) do if ch:IsA("Tool") and ch.Name:lower():find("bat") then return ch end end
    if bp then for _, ch in ipairs(bp:GetChildren()) do if ch:IsA("Tool") and ch.Name:lower():find("bat") then return ch end end end
    return nil
end

local function swingBatForCounter(bat, char)
    local hum2 = char:FindFirstChildOfClass("Humanoid")
    if bat.Parent ~= char then if hum2 then pcall(function() hum2:EquipTool(bat) end) end; task.wait(0.03) end
    local remote = bat:FindFirstChildOfClass("RemoteEvent") or bat:FindFirstChildOfClass("RemoteFunction")
    if remote and remote:IsA("RemoteEvent") then
        pcall(function() remote:FireServer() end); task.wait(0.05); pcall(function() remote:FireServer() end)
    else pcall(function() bat:Activate() end); task.wait(0.05); pcall(function() bat:Activate() end) end
end

local function startBatCounter()
    if S.batCounterConn then S.batCounterConn:Disconnect() end
    S.batCounterConn = RunService.Heartbeat:Connect(function()
        if not S.batCounterEnabled then return end
        if S.batCounterDebounce then return end
        local char = LP.Character; if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid"); if not hum then return end
        local st = hum:GetState()
        local isRagged = st == Enum.HumanoidStateType.Physics or st == Enum.HumanoidStateType.Ragdoll or st == Enum.HumanoidStateType.FallingDown
        if isRagged then
            S.batCounterDebounce = true
            task.spawn(function()
                local bat = findBatForCounter()
                if bat then swingBatForCounter(bat, char) end
                task.wait(0.1)
                S.batCounterDebounce = false
            end)
        end
    end)
end

local function stopBatCounter()
    if S.batCounterConn then S.batCounterConn:Disconnect(); S.batCounterConn = nil end
    S.batCounterDebounce = false
end

-- ANTI RAGDOLL
local function startAntiRagdoll()
    if S.Conns.antiRag then return end
    S.Conns.antiRag = RunService.Heartbeat:Connect(function()
        if not S.antiRagdollEnabled then return end
        local char = LP.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            local st = hum:GetState()
            if st == Enum.HumanoidStateType.Physics or st == Enum.HumanoidStateType.Ragdoll or st == Enum.HumanoidStateType.FallingDown then
                hum:ChangeState(Enum.HumanoidStateType.Running)
                workspace.CurrentCamera.CameraSubject = hum
                pcall(function()
                    local pm = LP.PlayerScripts:FindFirstChild("PlayerModule")
                    if pm then require(pm:FindFirstChild("ControlModule")):Enable() end
                end)
                if root then
                    root.Velocity = Vector3.new(0,0,0)
                    root.RotVelocity = Vector3.new(0,0,0)
                end
            end
        end
        for _, obj in ipairs(char:GetDescendants()) do
            if obj:IsA("Motor6D") and not obj.Enabled then obj.Enabled = true end
        end
    end)
end

local function stopAntiRagdoll()
    if S.Conns.antiRag then S.Conns.antiRag:Disconnect(); S.Conns.antiRag = nil end
end

local function toggleAntiRag(on)
    S.antiRagdollEnabled = on
    if on then startAntiRagdoll() else stopAntiRagdoll() end
end

-- UNWALK
local savedAnimate = nil

local function startUnwalk()
    local c = LP.Character
    if not c then return end
    local hum = c:FindFirstChildOfClass("Humanoid")
    if hum then
        for _, t in ipairs(hum:GetPlayingAnimationTracks()) do
            t:Stop()
        end
    end
    local anim = c:FindFirstChild("Animate")
    if anim then
        if not savedAnimate then
            savedAnimate = anim:Clone()
        end
        anim:Destroy()
    end
    S.unwalkEnabled = true
end

local function stopUnwalk()
    if not S.unwalkEnabled then return end
    S.unwalkEnabled = false
    local c = LP.Character
    if c and savedAnimate then
        local existing = c:FindFirstChild("Animate")
        if existing and existing ~= savedAnimate then existing:Destroy() end
        savedAnimate.Parent = c
        savedAnimate.Disabled = false
        savedAnimate = nil
    end
end

-- MEDUSA COUNTER
local function findMedusa()
    local char = LP.Character
    if not char then return nil end
    for _, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") then
            local name = tool.Name:lower()
            if name:find("medusa") or name:find("head") or name:find("stone") then
                return tool
            end
        end
    end
    local bp = LP:FindFirstChild("Backpack")
    if bp then
        for _, tool in ipairs(bp:GetChildren()) do
            if tool:IsA("Tool") then
                local name = tool.Name:lower()
                if name:find("medusa") or name:find("head") or name:find("stone") then
                    return tool
                end
            end
        end
    end
    return nil
end

local function useMedusaCounter()
    if S.medusaDebounce then return end
    if tick() - S.medusaLastUsed < S.MEDUSA_COOLDOWN then return end
    local char = LP.Character
    if not char then return end
    S.medusaDebounce = true
    local med = findMedusa()
    if not med then
        S.medusaDebounce = false
        return
    end
    if med.Parent ~= char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum:EquipTool(med) end
    end
    pcall(function() med:Activate() end)
    S.medusaLastUsed = tick()
    S.medusaDebounce = false
end

local function onAnchorChanged(part)
    return part:GetPropertyChangedSignal("Anchored"):Connect(function()
        if part.Anchored and part.Transparency == 1 and S.medusaCounterEnabled then
            useMedusaCounter()
        end
    end)
end

local function setupMedusaCounter(char)
    for _, c in pairs(S.medusaConns) do pcall(function() c:Disconnect() end) end
    S.medusaConns = {}
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            table.insert(S.medusaConns, onAnchorChanged(part))
        end
    end
    table.insert(S.medusaConns, char.DescendantAdded:Connect(function(part)
        if part:IsA("BasePart") then
            table.insert(S.medusaConns, onAnchorChanged(part))
        end
    end))
end

local function stopMedusaCounter()
    for _, c in pairs(S.medusaConns) do pcall(function() c:Disconnect() end) end
    S.medusaConns = {}
end

-- FPS BOOST
local function applyFPSBoost()
    safeSetfpscap(999999999)
    removeCharacterAccessories()
    local function pO(v)
        pcall(function()
            if v:IsA("Model") then
                v.LevelOfDetail = Enum.ModelLevelOfDetail.Disabled
                v.ModelStreamingMode = Enum.ModelStreamingMode.Nonatomic
            elseif v:IsA("MeshPart") then
                v.CastShadow = false; v.DoubleSided = false
                v.RenderFidelity = Enum.RenderFidelity.Performance
            elseif v:IsA("BasePart") then
                v.CastShadow = false; v.Material = Enum.Material.Plastic; v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            elseif v:IsA("SpecialMesh") then
                v.TextureId = ""
            elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke")
                or v:IsA("Sparkles") or v:IsA("ParticleEmitter")
                or v:IsA("Trail") or v:IsA("Beam") then
                v.Enabled = false
            elseif v:IsA("SurfaceAppearance") or v:IsA("MaterialVariant") then
                v:Destroy()
            elseif v:IsA("Attachment") then
                v.Visible = false
            end
        end)
    end
    for _, v in pairs(workspace:GetDescendants()) do pO(v) end
    pcall(function()
        local L = Lighting
        for _, v in pairs(L:GetDescendants()) do
            pcall(function()
                if v:IsA("Sky") or v:IsA("Atmosphere") or v:IsA("BloomEffect")
                    or v:IsA("BlurEffect") or v:IsA("SunRaysEffect")
                    or v:IsA("DepthOfFieldEffect") or v:IsA("Clouds")
                    or v:IsA("PostEffect") or v:IsA("ColorCorrectionEffect") then
                    v:Destroy()
                end
            end)
        end
        safeSethiddenproperty(L, "Technology", Enum.Technology.Legacy)
        L.GlobalShadows = false; L.FogEnd = 9e9; L.Brightness = 0
        local ter = workspace:FindFirstChildOfClass("Terrain")
        if ter then
            safeSethiddenproperty(ter, "Decoration", false)
            ter.WaterReflectance = 0; ter.WaterTransparency = 0.7
            ter.WaterWaveSize = 0; ter.WaterWaveSpeed = 0
        end
    end)
    workspace.DescendantAdded:Connect(function(v)
        if S.fpsBoostEnabled then task.spawn(pO, v) end
    end)
end

local function stopFPSBoost()
    S.fpsBoostEnabled = false
    restoreAccessories()
end

-- TP FLOOR
local function runTPFloor()
    pcall(function()
        local char = LP.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local rp = RaycastParams.new()
        rp.FilterDescendantsInstances = {char}
        rp.FilterType = Enum.RaycastFilterType.Exclude
        local res = workspace:Raycast(hrp.Position, Vector3.new(0, -500, 0), rp)
        if res then
            hrp.CFrame = CFrame.new(hrp.Position.X, res.Position.Y + hrp.Size.Y/2 + 0.5, hrp.Position.Z)
            hrp.Velocity = Vector3.zero
            pcall(function() hrp.AssemblyLinearVelocity = Vector3.zero end)
            pcall(function() hrp.AssemblyAngularVelocity = Vector3.zero end)
        end
    end)
end

-- NOCLIP
local _noclipCache = {}
RunService.Stepped:Connect(function(_, dt)
    S._noclipTimer = S._noclipTimer + dt
    if S._noclipTimer < 0.15 then return end
    S._noclipTimer = 0
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local cached = _noclipCache[p]
            if not cached or cached.char ~= p.Character then
                local parts = {}
                for _, obj in ipairs(p.Character:GetDescendants()) do
                    if obj:IsA("BasePart") then table.insert(parts, obj) end
                end
                _noclipCache[p] = {char = p.Character, parts = parts}
                cached = _noclipCache[p]
            end
            for _, part in ipairs(cached.parts) do
                if part and part.Parent then part.CanCollide = false end
            end
        else
            _noclipCache[p] = nil
        end
    end
end)

-- FPS COUNTER
RunService.RenderStepped:Connect(function()
    S._fpsCount = S._fpsCount + 1
    local now = tick()
    if now - S._lastFpsTime >= 1 then
        S.currentFPS = math.floor(S._fpsCount/(now - S._lastFpsTime))
        S._fpsCount = 0
        S._lastFpsTime = now
    end
end)

-- SAVE CONFIG
saveConfig = function()
    pcall(function()
        local function ks(e)
            return {kb = e.kb and e.kb.Name or nil, gp = e.gp and e.gp.Name or nil}
        end
        local cfg = {
            normalSpeed = S.NS, carrySpeed = S.CS, laggerSpeed = S.LS, laggerSpeed2 = S.LS2,
            laggerMode = S.speedMode and 0 or S.laggerMode,
            dropBrainrotKey = ks(S.KB.DropBrainrot), autoLeftKey = ks(S.KB.AutoLeft),
            autoRightKey = ks(S.KB.AutoRight), autoBatKey = ks(S.KB.AutoBat),
            tpFloorKey = ks(S.KB.TPFlor), guiHideKey = ks(S.KB.GuiHide),
            speedToggleKey = ks(S.KB.SpeedToggle), laggerToggleKey = ks(S.KB.LaggerToggle),
            antiRagdoll = S.antiRagdollEnabled,
            infiniteJump = S.infJumpEnabled,
            medusaCounter = S.medusaCounterEnabled, carryMode = S.speedMode,
            batAimbot = S.batAimbotEnabled,
            batAimbotSpeed = S.batAimbotSpeed,
            unwalkEnabled = S.unwalkEnabled,
            lockUI = S.lockUIEnabled, fpsBoost = S.fpsBoostEnabled,
            hideOpiumButtons = S.hideOpiumButtonsEnabled or false,
            holdJumpEnabled = S.holdJumpEnabled,
            autoTpDownEnabled = S.autoTpDownEnabled, 
            autoTpDownYTarget = S.autoTpDownYTarget,
            autoTpDownHeightLimit = S.autoTpDownHeightLimit,
            autoTPDownKey = ks(S.KB.AutoTPDown),
            batCounter = S.batCounterEnabled,
            galaxyMode = galaxyOn,
            hudScale = S.hudScale,
            bypassTogglePos = {X = bypassPanelFrame.Position.X.Offset, Y = bypassPanelFrame.Position.Y.Offset},
            floatingPanelPos = S.floatingPanelFrame and {X = S.floatingPanelFrame.Position.X.Offset, Y = S.floatingPanelFrame.Position.Y.Offset} or nil,
            bypassAimbotEnabled = bypassState.enabled,
            ninoTimeEnabled = S.ninoTimeEnabled,
            -- Auto Play config
            autoPlayGoingSpeed = AutoPlay.GoingSpeed,
            autoPlayStealSpeed = AutoPlay.StealSpeed,
            -- Auto Grab config
            autoGrabEnabled = AutoGrab.AUTO_STEAL_ENABLED,
            autoGrabRange = AutoGrab.PRIME_RANGE,
            autoGrabDuration = AutoGrab.HOLD_MAX,
        }
        local ok, data = pcall(function() return HS:JSONEncode(cfg) end)
        if ok and data then safeWritefile(S.CONFIG_FILE, data) end
    end)
end

local function resetFloatingPanel()
    if S.floatingPanelFrame then
        S.floatingPanelFrame.Position = UDim2.new(1, -163, 0.5, -200)
        saveConfig()
    end
end

updateFloatingButtons = function()
    if not S._setPButtonActive then return end
    local fb = S._floatingButtons
    if fb.lagger then updateLaggerButtonVisual() end
    if fb.carry then S._setPButtonActive(fb.carry, fb.strokeCarry, fb.l1Carry, fb.l2Carry, S.speedMode) end
    if fb.autoLeft then 
        S._setPButtonActive(fb.autoLeft, fb.strokeAutoLeft, fb.l1AutoLeft, fb.l2AutoLeft, AutoPlay.Enabled and AutoPlay.Side == "left")
    end
    if fb.autoRight then 
        S._setPButtonActive(fb.autoRight, fb.strokeAutoRight, fb.l1AutoRight, fb.l2AutoRight, AutoPlay.Enabled and AutoPlay.Side == "right")
    end
    if fb.bat then S._setPButtonActive(fb.bat, fb.strokeBat, fb.l1Bat, fb.l2Bat, S.batAimbotEnabled) end
    if fb.autoTPDown then S._setPButtonActive(fb.autoTPDown, fb.strokeAutoTPDown, fb.l1AutoTPDown, fb.l2AutoTPDown, S.autoTpDownEnabled) end
end

local function setUILock(enabled)
    S.lockUIEnabled = enabled
    if S.mainMenuFrame then S.mainMenuFrame.Active = not enabled end
    if S.miniToggleButton then S.miniToggleButton.Active = not enabled end
    if S.floatingPanelFrame then S.floatingPanelFrame.Active = not enabled end
    if bypassPanelFrame then bypassPanelFrame.Active = not enabled end
end

local function makeDraggable(frame, isFloatingPanel)
    local dragging, dragStart, startPos = false, nil, nil
    frame.InputBegan:Connect(function(inp)
        if S.lockUIEnabled then return end
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = inp.Position
            startPos = frame.Position
            inp.Changed:Connect(function()
                if inp.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UIS.InputChanged:Connect(function(inp)
        if S.lockUIEnabled or not dragging then return end
        if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
            local delta = inp.Position - dragStart
            if delta.Magnitude > 2 then
                local newX = startPos.X.Offset + delta.X
                local newY = startPos.Y.Offset + delta.Y
                frame.Position = UDim2.new(startPos.X.Scale, newX, startPos.Y.Scale, newY)
                if isFloatingPanel then saveConfig() end
            end
        end
    end)
end

-- ============================================================
-- INTERFAZ PRINCIPAL
-- ============================================================
local function buildGui_createScrollingPages(rightPanel)
    local pages = {}
    for _, n in ipairs({"Speed", "Main", "Move", "Config"}) do
        local sf = Instance.new("ScrollingFrame", rightPanel)
        sf.Size = UDim2.new(1,0,1,0)
        sf.BackgroundTransparency = 1
        sf.BorderSizePixel = 0
        sf.ScrollBarThickness = 6
        sf.ScrollingEnabled = true
        sf.Visible = false
        sf.AutomaticCanvasSize = Enum.AutomaticSize.Y

        local ll = Instance.new("UIListLayout", sf)
        ll.SortOrder = Enum.SortOrder.LayoutOrder
        ll.Padding = UDim.new(0, 4)
        ll.FillDirection = Enum.FillDirection.Vertical

        local pp = Instance.new("UIPadding", sf)
        pp.PaddingLeft = UDim.new(0, 12)
        pp.PaddingRight = UDim.new(0, 12)
        pp.PaddingTop = UDim.new(0, 12)
        pp.PaddingBottom = UDim.new(0, 40)

        pages[n] = sf
    end
    return pages
end

local rowCounts = {Speed = 0, Main = 0, Move = 0, Config = 0}

local function mkCard(pg, pages, h)
    local C_CARD = Color3.fromRGB(20,20,20)
    rowCounts[pg] = rowCounts[pg] + 1
    local f = Instance.new("Frame", pages[pg])
    f.Size = UDim2.new(1,0,0,h or 38)
    f.BackgroundColor3 = C_CARD
    f.BorderSizePixel = 0
    f.LayoutOrder = rowCounts[pg]
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke", f)
    stroke.Color = Color3.fromRGB(60,60,60)
    stroke.Thickness = 0.5
    return f
end

local function mkToggle(pg, pages, label, defKey, defOn, onToggle, onKeyChanged)
    local C_ON = Color3.fromRGB(128,0,128)
    local C_OFF = Color3.fromRGB(60,60,60)
    local C_WHITE = Color3.fromRGB(255,255,255)
    local card = mkCard(pg, pages, 38)
    local lbl = Instance.new("TextLabel", card)
    lbl.Size = UDim2.new(0,140,1,0)
    lbl.Position = UDim2.new(0,12,0,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = C_WHITE
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local keyBtn = nil
    if defKey then
        local keyName = (defKey or Enum.KeyCode.Unknown).Name
        keyBtn = Instance.new("TextButton", card)
        keyBtn.Size = UDim2.new(0,60,0,24)
        keyBtn.Position = UDim2.new(1,-110,0.5,-12)
        keyBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
        keyBtn.BorderSizePixel = 0
        keyBtn.Text = keyName
        keyBtn.TextColor3 = C_WHITE
        keyBtn.Font = Enum.Font.GothamBold
        keyBtn.TextSize = 10
        Instance.new("UICorner", keyBtn).CornerRadius = UDim.new(0, 5)
        local listening = false
        keyBtn.MouseButton1Click:Connect(function()
            if listening then return end
            listening = true
            local prev = keyBtn.Text
            keyBtn.Text = "..."
            local conn
            conn = UIS.InputBegan:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.Keyboard or inp.UserInputType == Enum.UserInputType.Gamepad1 then
                    if inp.KeyCode ~= Enum.KeyCode.Escape then
                        keyBtn.Text = inp.KeyCode.Name
                        if onKeyChanged then onKeyChanged(inp.KeyCode, inp.UserInputType == Enum.UserInputType.Gamepad1) end
                    else
                        keyBtn.Text = prev
                    end
                    listening = false
                    conn:Disconnect()
                end
            end)
        end)
    end
    
    local pillBg = Instance.new("Frame", card)
    pillBg.Size = UDim2.new(0,28,0,16)
    pillBg.Position = UDim2.new(1,-36,0.5,-8)
    pillBg.BackgroundColor3 = defOn and C_ON or C_OFF
    pillBg.BorderSizePixel = 0
    Instance.new("UICorner", pillBg).CornerRadius = UDim.new(1,0)
    local dot = Instance.new("Frame", pillBg)
    dot.Size = UDim2.new(0,12,0,12)
    dot.Position = defOn and UDim2.new(1,-14,0.5,-6) or UDim2.new(0,2,0.5,-6)
    dot.BackgroundColor3 = defOn and Color3.fromRGB(20,20,20) or C_WHITE
    dot.BorderSizePixel = 0
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)
    local isOn = defOn or false
    local function setV(on)
        isOn = on
        pillBg.BackgroundColor3 = on and C_ON or C_OFF
        dot.Position = on and UDim2.new(1,-14,0.5,-6) or UDim2.new(0,2,0.5,-6)
        dot.BackgroundColor3 = on and Color3.fromRGB(20,20,20) or C_WHITE
    end
    local clickArea = Instance.new("TextButton", card)
    clickArea.Size = UDim2.new(1,0,1,0)
    clickArea.BackgroundTransparency = 1
    clickArea.Text = ""
    clickArea.ZIndex = 3
    clickArea.MouseButton1Click:Connect(function()
        isOn = not isOn
        setV(isOn)
        if onToggle then onToggle(isOn) end
    end)
    if defOn then setV(true) end
    return setV, keyBtn
end

local function mkSlider(pg, pages, label, minVal, maxVal, default, onChange)
    local C_WHITE = Color3.fromRGB(255,255,255)
    local card = mkCard(pg, pages, 55)
    local lbl = Instance.new("TextLabel", card)
    lbl.Size = UDim2.new(1,0,0,20)
    lbl.Position = UDim2.new(0,12,0,8)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = C_WHITE
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local valueLabel = Instance.new("TextLabel", card)
    valueLabel.Size = UDim2.new(0,40,0,20)
    valueLabel.Position = UDim2.new(1,-52,0,8)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(default)
    valueLabel.TextColor3 = C_WHITE
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextSize = 11
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    
    local sliderBg = Instance.new("Frame", card)
    sliderBg.Size = UDim2.new(1,-24,0,4)
    sliderBg.Position = UDim2.new(0,12,0,40)
    sliderBg.BackgroundColor3 = Color3.fromRGB(40,40,40)
    sliderBg.BorderSizePixel = 0
    Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(1,0)
    
    local sliderFill = Instance.new("Frame", sliderBg)
    sliderFill.Size = UDim2.new((default - minVal) / (maxVal - minVal), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(128,0,128)
    sliderFill.BorderSizePixel = 0
    Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(1,0)
    
    local knob = Instance.new("Frame", card)
    knob.Size = UDim2.new(0,12,0,12)
    knob.Position = UDim2.new((default - minVal) / (maxVal - minVal), 0, 0, 34)
    knob.BackgroundColor3 = Color3.fromRGB(128,0,128)
    knob.BorderSizePixel = 0
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)
    
    local dragging = false
    knob.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    
    UIS.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    local function updateSlider(posX)
        local relX = math.clamp((posX - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
        local val = minVal + (maxVal - minVal) * relX
        val = math.floor(val * 10) / 10
        knob.Position = UDim2.new(relX, -6, 0, 34)
        sliderFill.Size = UDim2.new(relX, 0, 1, 0)
        valueLabel.Text = tostring(val)
        onChange(val)
    end
    
    UIS.InputChanged:Connect(function(inp)
        if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(inp.Position.X)
        end
    end)
    
    sliderBg.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            updateSlider(inp.Position.X)
        end
    end)
end

local function mkInput(pg, pages, label, default, onChange)
    local C_WHITE = Color3.fromRGB(255,255,255)
    local card = mkCard(pg, pages, 38)
    local lbl = Instance.new("TextLabel", card)
    lbl.Size = UDim2.new(0.5,-10,1,0)
    lbl.Position = UDim2.new(0,12,0,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = C_WHITE
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local box = Instance.new("TextBox", card)
    box.Size = UDim2.new(0,80,0,28)
    box.Position = UDim2.new(1,-88,0.5,-14)
    box.BackgroundColor3 = Color3.fromRGB(40,40,40)
    box.BorderSizePixel = 0
    box.Text = tostring(default)
    box.TextColor3 = C_WHITE
    box.Font = Enum.Font.GothamBlack
    box.TextSize = 11
    box.ClearTextOnFocus = false
    pcall(function() box.ReturnKeyType = Enum.ReturnKeyType.Done end)
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)

    local lastVal = tostring(default)
    local isFocused = false

    local function applyValue()
        if not isFocused then return end
        isFocused = false
        local n = tonumber(box.Text)
        if n then
            lastVal = tostring(n)
            box.Text = lastVal
            onChange(n)
        else
            box.Text = lastVal
        end
        pcall(function() box:ReleaseFocus(false) end)
    end

    box.Focused:Connect(function()
        isFocused = true
    end)

    box.FocusLost:Connect(function()
        if isFocused then
            isFocused = false
            local n = tonumber(box.Text)
            if n then
                lastVal = tostring(n)
                box.Text = lastVal
                onChange(n)
            else
                box.Text = lastVal
            end
        end
    end)

    pcall(function()
        box.ReturnPressedFromOnScreenKeyboard:Connect(function()
            applyValue()
        end)
    end)

    UIS.TouchTap:Connect(function(positions)
        if not isFocused then return end
        pcall(function()
            local abs = box.AbsolutePosition
            local sz = box.AbsoluteSize
            local tp = positions[1]
            if tp then
                local inside = tp.X >= abs.X and tp.X <= abs.X + sz.X and tp.Y >= abs.Y and tp.Y <= abs.Y + sz.Y
                if not inside then applyValue() end
            end
        end)
    end)

    return box
end

local function buildGui_createMiniToggle(gui, showGuiFn)
    local C_WHITE = Color3.fromRGB(255,255,255)
    local miniToggleBtn = Instance.new("TextButton", gui)
    miniToggleBtn.Name = "MiniToggle"
    miniToggleBtn.Size = UDim2.new(0,160,0,36)
    miniToggleBtn.Position = UDim2.new(0,38,0,60)
    miniToggleBtn.BackgroundColor3 = Color3.fromRGB(10,10,10)
    miniToggleBtn.BorderSizePixel = 0
    miniToggleBtn.Text = ""
    miniToggleBtn.ZIndex = 20
    miniToggleBtn.Visible = false
    Instance.new("UICorner", miniToggleBtn).CornerRadius = UDim.new(0,8)
    local miniStroke = Instance.new("UIStroke", miniToggleBtn)
    miniStroke.Color = C_WHITE
    miniStroke.Thickness = 1
    miniStroke.Transparency = 0.92
    local miniMainText = Instance.new("TextLabel", miniToggleBtn)
    miniMainText.Size = UDim2.new(1,-38,1,0)
    miniMainText.Position = UDim2.new(0,32,0,0)
    miniMainText.BackgroundTransparency = 1
    miniMainText.Text = "NINO HUB"
    miniMainText.TextColor3 = C_WHITE
    miniMainText.Font = Enum.Font.GothamBlack
    miniMainText.TextSize = 14
    miniMainText.TextXAlignment = Enum.TextXAlignment.Left
    miniMainText.ZIndex = 21
    makeDraggable(miniToggleBtn, false)
    miniToggleBtn.MouseButton1Click:Connect(showGuiFn)
    return miniToggleBtn
end

-- ============================================================
-- TABS DE CONFIGURACIÓN
-- ============================================================
local function buildSpeedTab(pages)
    S.normalBox = mkInput("Speed", pages, "Normal Speed", S.NS, function(v)
        if v>0 and v<=500 then S.NS = v; S.restartMovement(); saveConfig() end
    end)
    S.carryBox = mkInput("Speed", pages, "Carry Speed", S.CS, function(v)
        if v>0 and v<=500 then S.CS = v; S.restartMovement(); saveConfig() end
    end)
    S.laggerBox = mkInput("Speed", pages, "Lagger Speed 1", S.LS, function(v)
        if v>0 and v<=500 then S.LS = v; S.restartMovement(); saveConfig() end
    end)
    S.lagger2Box = mkInput("Speed", pages, "Lagger Speed 2", S.LS2, function(v)
        if v>0 and v<=500 then S.LS2 = v; S.restartMovement(); saveConfig() end
    end)

    S.speedClk, _ = mkToggle("Speed", pages, "Carry Mode", S.KB.SpeedToggle.kb, false, function(on)
        if on and S.laggerMode ~= 0 then
            S.laggerMode = 0
            if S.setLaggerVisual then S.setLaggerVisual(false) end
            updateLaggerButtonVisual()
        end
        S.speedMode = on
        S.restartMovement()
        updateFloatingButtons()
        saveConfig()
    end, function(k, isGp)
        if isGp then S.KB.SpeedToggle.gp = k; S.KB.SpeedToggle.kb = nil
        else S.KB.SpeedToggle.kb = k; S.KB.SpeedToggle.gp = nil end
        saveConfig()
    end)

    S.setLaggerVisual, _ = mkToggle("Speed", pages, "Lagger Mode", S.KB.LaggerToggle.kb, false, function(on)
        if on then
            if S.speedMode then
                S.speedMode = false
                if S.speedClk then S.speedClk(false) end
            end
            if S.laggerMode == 0 then S.laggerMode = 1
            elseif S.laggerMode == 1 then S.laggerMode = 2
            else S.laggerMode = 0 end
        else S.laggerMode = 0 end
        updateLaggerButtonVisual()
        S.restartMovement()
        updateFloatingButtons()
        saveConfig()
    end, function(k, isGp)
        if isGp then S.KB.LaggerToggle.gp = k; S.KB.LaggerToggle.kb = nil
        else S.KB.LaggerToggle.kb = k; S.KB.LaggerToggle.gp = nil end
        saveConfig()
    end)
    
    mkInput("Speed", pages, "Bat Aimbot Speed", S.batAimbotSpeed, function(v)
        if v>0 and v<=500 then S.batAimbotSpeed = v; saveConfig() end
    end)
    
    -- Velocidades del Auto Play
    mkInput("Speed", pages, "Auto Play Going Speed", AutoPlay.GoingSpeed, function(v)
        if v>=10 and v<=200 then AutoPlay.GoingSpeed = v; saveAutoPlayConfig(); saveConfig() end
    end)
    
    mkInput("Speed", pages, "Auto Play Steal Speed", AutoPlay.StealSpeed, function(v)
        if v>=10 and v<=200 then AutoPlay.StealSpeed = v; saveAutoPlayConfig(); saveConfig() end
    end)
end

local function buildMainTab(pages)
    S.setDarkVisual, _ = mkToggle("Main", pages, "Galaxy Mode", nil, false, function(on)
        toggleGalaxyMode()
        saveConfig()
    end, nil)

    S.setFpsVisual, _ = mkToggle("Main", pages, "FPS Boost", nil, false, function(on)
        S.fpsBoostEnabled = on
        if on then applyFPSBoost() else stopFPSBoost() end
        saveConfig()
    end, nil)

    S.setInfJumpVisual, _ = mkToggle("Main", pages, "Infinite Jump", nil, false, function(on)
        if on and S.holdJumpEnabled then
            S.holdJumpEnabled = false
            stopHoldJump()
            if S.setHoldJumpVisual then S.setHoldJumpVisual(false) end
        end
        S.infJumpEnabled = on
        if on then startInfiniteJump() else stopInfiniteJump() end
        saveConfig()
    end, nil)

    S.setHoldJumpVisual, _ = mkToggle("Main", pages, "Hold Jump", nil, false, function(on)
        if on and S.infJumpEnabled then
            S.infJumpEnabled = false
            stopInfiniteJump()
            if S.setInfJumpVisual then S.setInfJumpVisual(false) end
        end
        S.holdJumpEnabled = on
        if on then startHoldJump() else stopHoldJump() end
        saveConfig()
    end, nil)

    S.setNinoTimeVisual, _ = mkToggle("Main", pages, "Nino Time", nil, true, function(on)
        S.ninoTimeEnabled = on
        if on then
            startNinoTime()
        else
            stopNinoTime()
        end
        saveConfig()
    end, nil)
end

local function buildMoveTab(pages)
    local batToggleVisual, _ = mkToggle("Move", pages, "Bat Aimbot", S.KB.AutoBat.kb, false, function(on)
        if on then
            if AutoPlay.Enabled then
                setAutoPlay(AutoPlay.Side, false)
            end
        end
        setBatAimbot(on)
        updateFloatingButtons()
    end, function(k, isGp)
        if isGp then S.KB.AutoBat.gp = k; S.KB.AutoBat.kb = nil
        else S.KB.AutoBat.kb = k; S.KB.AutoBat.gp = nil end
        saveConfig()
    end)
    S.batAimbotSetVisual = batToggleVisual

    S.setBatCounterVisual, _ = mkToggle("Move", pages, "Bat Counter", nil, false, function(on)
        S.batCounterEnabled = on
        if on then startBatCounter() else stopBatCounter() end
        saveConfig()
    end, nil)

    -- Auto Left Toggle (ahora controla Auto Play)
    local setALVis, _ = mkToggle("Move", pages, "Auto Left", S.KB.AutoLeft.kb, false, function(on)
        if on then
            if AutoPlay.Enabled and AutoPlay.Side == "right" then
                setAutoPlay("right", false)
            end
            if S.batAimbotEnabled then setBatAimbot(false) end
            setAutoPlay("left", true)
        else
            if AutoPlay.Enabled and AutoPlay.Side == "left" then
                setAutoPlay("left", false)
            end
        end
        if S.autoLeftSetVisual then S.autoLeftSetVisual(on and AutoPlay.Enabled and AutoPlay.Side == "left") end
        S.restartMovement(); updateFloatingButtons(); saveConfig()
    end, function(k, isGp)
        if isGp then S.KB.AutoLeft.gp = k; S.KB.AutoLeft.kb = nil
        else S.KB.AutoLeft.kb = k; S.KB.AutoLeft.gp = nil end
        saveConfig()
    end)
    S.autoLeftSetVisual = setALVis

    -- Auto Right Toggle (ahora controla Auto Play)
    local setARVis, _ = mkToggle("Move", pages, "Auto Right", S.KB.AutoRight.kb, false, function(on)
        if on then
            if AutoPlay.Enabled and AutoPlay.Side == "left" then
                setAutoPlay("left", false)
            end
            if S.batAimbotEnabled then setBatAimbot(false) end
            setAutoPlay("right", true)
        else
            if AutoPlay.Enabled and AutoPlay.Side == "right" then
                setAutoPlay("right", false)
            end
        end
        if S.autoRightSetVisual then S.autoRightSetVisual(on and AutoPlay.Enabled and AutoPlay.Side == "right") end
        S.restartMovement(); updateFloatingButtons(); saveConfig()
    end, function(k, isGp)
        if isGp then S.KB.AutoRight.gp = k; S.KB.AutoRight.kb = nil
        else S.KB.AutoRight.kb = k; S.KB.AutoRight.gp = nil end
        saveConfig()
    end)
    S.autoRightSetVisual = setARVis

    S.autoTpDownSetVisual, _ = mkToggle("Move", pages, "Auto TP Down", S.KB.AutoTPDown.kb, false, function(on)
        S.autoTpDownEnabled = on
        if on then startAutoTpDown() else stopAutoTpDown() end
        if S.autoTpDownFloatVisual then S.autoTpDownFloatVisual(on) end
        saveConfig()
    end, function(k, isGp)
        if isGp then S.KB.AutoTPDown.gp = k; S.KB.AutoTPDown.kb = nil
        else S.KB.AutoTPDown.kb = k; S.KB.AutoTPDown.gp = nil end
        saveConfig()
    end)

    S.setUnwalkVisual, _ = mkToggle("Move", pages, "Unwalk", nil, false, function(on)
        if on then startUnwalk() else stopUnwalk() end
        saveConfig()
    end, nil)

    S.setAntiRagVisual, _ = mkToggle("Move", pages, "Anti Ragdoll", nil, false, function(on)
        toggleAntiRag(on); saveConfig()
    end, nil)

    S.setMedusaVisual, _ = mkToggle("Move", pages, "Medusa Counter", nil, false, function(on)
        S.medusaCounterEnabled = on
        if on then setupMedusaCounter(LP.Character) else stopMedusaCounter() end
        saveConfig()
    end, nil)

    local function actionRow(pg, lbl, keyEntry)
        local card = mkCard(pg, pages, 38)
        local lblObj = Instance.new("TextLabel", card)
        lblObj.Size = UDim2.new(0,120,1,0); lblObj.Position = UDim2.new(0,12,0,0)
        lblObj.BackgroundTransparency = 1; lblObj.Text = lbl
        lblObj.TextColor3 = Color3.fromRGB(255,255,255); lblObj.Font = Enum.Font.GothamBold; lblObj.TextSize = 11
        lblObj.TextXAlignment = Enum.TextXAlignment.Left
        local keyBtn = Instance.new("TextButton", card)
        keyBtn.Size = UDim2.new(0,60,0,24); keyBtn.Position = UDim2.new(1,-70,0.5,-12)
        keyBtn.BackgroundColor3 = Color3.fromRGB(40,40,40); keyBtn.BorderSizePixel = 0
        keyBtn.Text = (keyEntry.kb or keyEntry.gp or Enum.KeyCode.Unknown).Name
        keyBtn.TextColor3 = Color3.fromRGB(255,255,255); keyBtn.Font = Enum.Font.GothamBold; keyBtn.TextSize = 10
        Instance.new("UICorner", keyBtn).CornerRadius = UDim.new(0,5)
        local listening = false
        keyBtn.MouseButton1Click:Connect(function()
            if listening then return end
            listening = true
            local prev = keyBtn.Text; keyBtn.Text = "..."
            local conn
            conn = UIS.InputBegan:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.Keyboard or inp.UserInputType == Enum.UserInputType.Gamepad1 then
                    if inp.KeyCode ~= Enum.KeyCode.Escape then
                        keyBtn.Text = inp.KeyCode.Name
                        if inp.UserInputType == Enum.UserInputType.Gamepad1 then
                            keyEntry.gp = inp.KeyCode; keyEntry.kb = nil
                        else
                            keyEntry.kb = inp.KeyCode; keyEntry.gp = nil
                        end
                        saveConfig()
                    else
                        keyBtn.Text = prev
                    end
                    conn:Disconnect(); listening = false
                end
            end)
        end)
    end
    actionRow("Move", "Drop Brainrot", S.KB.DropBrainrot)
    actionRow("Move", "TP Down", S.KB.TPFlor)
end

local function buildConfigTab(pages)
    local C_ON = Color3.fromRGB(128,0,128)
    local C_OFF = Color3.fromRGB(60,60,60)
    local C_WHITE = Color3.fromRGB(255,255,255)

    -- Auto Steal Toggle (AutoGrab)
    do
        local card = mkCard("Config", pages, 38)
        local lbl = Instance.new("TextLabel", card)
        lbl.Size = UDim2.new(0,120,1,0); lbl.Position = UDim2.new(0,12,0,0)
        lbl.BackgroundTransparency = 1; lbl.Text = "Auto Steal"; lbl.TextColor3 = C_WHITE
        lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 11
        local pill = Instance.new("Frame", card)
        pill.Size = UDim2.new(0,28,0,16); pill.Position = UDim2.new(1,-36,0.5,-8)
        pill.BackgroundColor3 = AutoGrab.AUTO_STEAL_ENABLED and C_ON or C_OFF
        pill.BorderSizePixel = 0
        Instance.new("UICorner", pill).CornerRadius = UDim.new(1,0)
        local dot = Instance.new("Frame", pill)
        dot.Size = UDim2.new(0,12,0,12); dot.Position = AutoGrab.AUTO_STEAL_ENABLED and UDim2.new(1,-14,0.5,-6) or UDim2.new(0,2,0.5,-6)
        dot.BackgroundColor3 = AutoGrab.AUTO_STEAL_ENABLED and Color3.fromRGB(20,20,20) or C_WHITE
        dot.BorderSizePixel = 0
        Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)
        local function setStealVis(on)
            pill.BackgroundColor3 = on and C_ON or C_OFF
            dot.Position = on and UDim2.new(1,-14,0.5,-6) or UDim2.new(0,2,0.5,-6)
            dot.BackgroundColor3 = on and Color3.fromRGB(20,20,20) or C_WHITE
        end
        S.setInstaGrab = setStealVis
        local click = Instance.new("TextButton", card)
        click.Size = UDim2.new(1,0,1,0); click.BackgroundTransparency = 1; click.Text = ""; click.ZIndex = 3
        click.MouseButton1Click:Connect(function()
            AutoGrab.AUTO_STEAL_ENABLED = not AutoGrab.AUTO_STEAL_ENABLED
            setStealVis(AutoGrab.AUTO_STEAL_ENABLED)
            if AutoGrab.AUTO_STEAL_ENABLED then startAutoSteal() else stopAutoSteal() end
            saveConfig()
        end)
    end

    S.radInput = mkInput("Config", pages, "Steal Range", AutoGrab.PRIME_RANGE, function(v)
        if v>=1 and v<=300 then AutoGrab.PRIME_RANGE = math.floor(v) end; saveConfig()
    end)

    S.stealDurationBox = mkInput("Config", pages, "Steal Duration", AutoGrab.HOLD_MAX, function(v)
        if v >= 0.05 and v <= 5 then AutoGrab.HOLD_MAX = v; AutoGrab.HOLD_MIN = v * 0.5; saveConfig() end
    end)

    mkSlider("Config", pages, "HUD Size", 0.5, 2, S.hudScale, function(v)
        S.hudScale = v
        updateHudScale()
        saveConfig()
    end)

    mkInput("Config", pages, "TP Y Target", S.autoTpDownYTarget, function(v)
        local n = tonumber(v); if n and n >= -500 and n <= 500 then S.autoTpDownYTarget = n; saveConfig() end
    end)
    
    mkInput("Config", pages, "TP Height Limit", S.autoTpDownHeightLimit, function(v)
        local n = tonumber(v); if n and n >= 1 and n <= 1000 then S.autoTpDownHeightLimit = n; saveConfig() end
    end)

    do
        local card = mkCard("Config", pages, 38)
        local lbl = Instance.new("TextLabel", card)
        lbl.Size = UDim2.new(0,100,1,0); lbl.Position = UDim2.new(0,12,0,0)
        lbl.BackgroundTransparency = 1; lbl.Text = "Hide GUI"; lbl.TextColor3 = C_WHITE
        lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 11
        local keyBtn = Instance.new("TextButton", card)
        keyBtn.Size = UDim2.new(0,60,0,24); keyBtn.Position = UDim2.new(1,-70,0.5,-12)
        keyBtn.BackgroundColor3 = Color3.fromRGB(40,40,40); keyBtn.BorderSizePixel = 0
        keyBtn.Text = (S.KB.GuiHide.kb or S.KB.GuiHide.gp or Enum.KeyCode.Unknown).Name
        keyBtn.TextColor3 = C_WHITE; keyBtn.Font = Enum.Font.GothamBold; keyBtn.TextSize = 10
        Instance.new("UICorner", keyBtn).CornerRadius = UDim.new(0,5)
        local listening = false
        keyBtn.MouseButton1Click:Connect(function()
            if listening then return end
            listening = true
            local prev = keyBtn.Text; keyBtn.Text = "..."
            local conn
            conn = UIS.InputBegan:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.Keyboard or inp.UserInputType == Enum.UserInputType.Gamepad1 then
                    if inp.KeyCode ~= Enum.KeyCode.Escape then
                        keyBtn.Text = inp.KeyCode.Name
                        if inp.UserInputType == Enum.UserInputType.Gamepad1 then
                            S.KB.GuiHide.gp = inp.KeyCode; S.KB.GuiHide.kb = nil
                        else
                            S.KB.GuiHide.kb = inp.KeyCode; S.KB.GuiHide.gp = nil
                        end
                        saveConfig()
                    else
                        keyBtn.Text = prev
                    end
                    conn:Disconnect(); listening = false
                end
            end)
        end)
    end

    do
        local card = mkCard("Config", pages, 38)
        local lbl = Instance.new("TextLabel", card)
        lbl.Size = UDim2.new(0,100,1,0); lbl.Position = UDim2.new(0,12,0,0)
        lbl.BackgroundTransparency = 1; lbl.Text = "Lock UI"; lbl.TextColor3 = C_WHITE
        lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 11
        local pill = Instance.new("Frame", card)
        pill.Size = UDim2.new(0,28,0,16); pill.Position = UDim2.new(1,-36,0.5,-8)
        pill.BackgroundColor3 = C_OFF; pill.BorderSizePixel = 0
        Instance.new("UICorner", pill).CornerRadius = UDim.new(1,0)
        local dot = Instance.new("Frame", pill)
        dot.Size = UDim2.new(0,12,0,12); dot.Position = UDim2.new(0,2,0.5,-6)
        dot.BackgroundColor3 = C_WHITE; dot.BorderSizePixel = 0
        Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)
        local lockOn = false
        local function setLockVis(on)
            lockOn = on
            pill.BackgroundColor3 = on and C_ON or C_OFF
            dot.Position = on and UDim2.new(1,-14,0.5,-6) or UDim2.new(0,2,0.5,-6)
            dot.BackgroundColor3 = on and Color3.fromRGB(20,20,20) or C_WHITE
        end
        S.setLockUI_Visual = setLockVis
        local click = Instance.new("TextButton", card)
        click.Size = UDim2.new(1,0,1,0); click.BackgroundTransparency = 1; click.Text = ""; click.ZIndex = 3
        click.MouseButton1Click:Connect(function()
            lockOn = not lockOn; setLockVis(lockOn); setUILock(lockOn); saveConfig()
        end)
    end

    do
        local card = mkCard("Config", pages, 38)
        local lbl = Instance.new("TextLabel", card)
        lbl.Size = UDim2.new(0,140,1,0); lbl.Position = UDim2.new(0,12,0,0)
        lbl.BackgroundTransparency = 1; lbl.Text = "Hide Buttons"; lbl.TextColor3 = C_WHITE
        lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 11
        local pill = Instance.new("Frame", card)
        pill.Size = UDim2.new(0,28,0,16); pill.Position = UDim2.new(1,-36,0.5,-8)
        pill.BackgroundColor3 = C_OFF; pill.BorderSizePixel = 0
        Instance.new("UICorner", pill).CornerRadius = UDim.new(1,0)
        local dot = Instance.new("Frame", pill)
        dot.Size = UDim2.new(0,12,0,12); dot.Position = UDim2.new(0,2,0.5,-6)
        dot.BackgroundColor3 = C_WHITE; dot.BorderSizePixel = 0
        Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)
        local hideButtonsOn = false
        local function setHideButtonsVis(on)
            hideButtonsOn = on
            pill.BackgroundColor3 = on and C_ON or C_OFF
            dot.Position = on and UDim2.new(1,-14,0.5,-6) or UDim2.new(0,2,0.5,-6)
            dot.BackgroundColor3 = on and Color3.fromRGB(20,20,20) or C_WHITE
        end
        S.setHideOpiumButtons = setHideButtonsVis
        local click2 = Instance.new("TextButton", card)
        click2.Size = UDim2.new(1,0,1,0); click2.BackgroundTransparency = 1; click2.Text = ""; click2.ZIndex = 3
        click2.MouseButton1Click:Connect(function()
            hideButtonsOn = not hideButtonsOn
            setHideButtonsVis(hideButtonsOn)
            if S.floatingPanelGui then S.floatingPanelGui.Enabled = not hideButtonsOn end
            pcall(function()
                local pg = LP:FindFirstChild("PlayerGui")
                if pg then
                    local opiumGui = pg:FindFirstChild("OpiumGGV5_2")
                    if opiumGui then opiumGui.Enabled = not hideButtonsOn end
                end
            end)
            S.hideOpiumButtonsEnabled = hideButtonsOn
            saveConfig()
        end)
    end

    do
        local card = mkCard("Config", pages, 38)
        local lbl = Instance.new("TextLabel", card)
        lbl.Size = UDim2.new(0,140,1,0); lbl.Position = UDim2.new(0,12,0,0)
        lbl.BackgroundTransparency = 1; lbl.Text = "Reset Panel"; lbl.TextColor3 = C_WHITE
        lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 11
        local resetBtn = Instance.new("TextButton", card)
        resetBtn.Size = UDim2.new(0,80,0,28)
        resetBtn.Position = UDim2.new(1,-90,0.5,-14)
        resetBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
        resetBtn.BorderSizePixel = 0
        resetBtn.Text = "Reset"
        resetBtn.TextColor3 = C_WHITE
        resetBtn.Font = Enum.Font.GothamBold
        resetBtn.TextSize = 11
        Instance.new("UICorner", resetBtn).CornerRadius = UDim.new(0,6)
        resetBtn.MouseButton1Click:Connect(function()
            local originalText = resetBtn.Text
            resetBtn.Text = "..."
            task.spawn(function()
                resetFloatingPanel()
                task.wait(0.2)
                resetBtn.Text = originalText
            end)
        end)
    end
end

-- ============================================================
-- BUILD GUI PRINCIPAL
-- ============================================================
local function buildGui()
    local C_BG_OUTER  = Color3.fromRGB(8,8,8)
    local C_BG_INNER  = Color3.fromRGB(10,10,10)
    local C_WHITE     = Color3.fromRGB(255,255,255)
    local C_DIM       = Color3.fromRGB(140,140,140)
    local C_ACCENT    = Color3.fromRGB(128,0,128)
    local C_BORDER    = Color3.fromRGB(80,80,80)
    local C_CARD_BG   = Color3.fromRGB(20,20,20)
    local C_ACTIVE_BG = Color3.fromRGB(35,35,35)

    local TOTAL_W  = 480
    local TOTAL_H  = 482
    local SIDEBAR_W = 155

    local old = game:GetService("CoreGui"):FindFirstChild("Ninohub")
    if old then old:Destroy() end

    local gui = Instance.new("ScreenGui")
    gui.Name = "Ninohub"
    gui.ResetOnSpawn = false
    gui.DisplayOrder = 100
    gui.IgnoreGuiInset = true
    pcall(function() gui.Parent = game:GetService("CoreGui") end)
    if not gui.Parent then gui.Parent = LP:WaitForChild("PlayerGui") end

    local main = Instance.new("Frame", gui)
    main.Name = "Main"
    main.Size = UDim2.new(0, TOTAL_W, 0, TOTAL_H)
    main.Position = UDim2.new(0, 40, 0, 0)
    main.BackgroundColor3 = C_BG_OUTER
    main.BorderSizePixel = 0
    main.ClipsDescendants = true
    main.Visible = true
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)
    local mainStroke = Instance.new("UIStroke", main)
    mainStroke.Color = C_BORDER
    mainStroke.Thickness = 1
    S.mainMenuFrame = main
    makeDraggable(main, false)

    local sidebar = Instance.new("Frame", main)
    sidebar.Size = UDim2.new(0, SIDEBAR_W, 1, 0)
    sidebar.Position = UDim2.new(0,0,0,0)
    sidebar.BackgroundColor3 = C_BG_OUTER
    sidebar.BorderSizePixel = 0
    sidebar.ClipsDescendants = true
    Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 12)

    local divider = Instance.new("Frame", main)
    divider.Size = UDim2.new(0,1,1,-24)
    divider.Position = UDim2.new(0,SIDEBAR_W,0,12)
    divider.BackgroundColor3 = C_BORDER
    divider.BorderSizePixel = 0

    local headerFrame = Instance.new("Frame", sidebar)
    headerFrame.Size = UDim2.new(1,0,0,200)
    headerFrame.Position = UDim2.new(0,0,0,0)
    headerFrame.BackgroundTransparency = 1

    local logoContainer = Instance.new("Frame", headerFrame)
    logoContainer.Size = UDim2.new(1,0,1,0)
    logoContainer.BackgroundTransparency = 1

    local logoImage = Instance.new("ImageLabel", logoContainer)
    logoImage.Size = UDim2.new(1,0,1,0)
    logoImage.BackgroundTransparency = 1
    logoImage.Image = "rbxassetid://135894687762727"
    logoImage.ScaleType = Enum.ScaleType.Crop
    logoImage.ImageColor3 = Color3.fromRGB(128,0,128)
    logoImage.ImageTransparency = 0.45

    local fadeGradient = Instance.new("UIGradient", logoImage)
    fadeGradient.Rotation = 90
    fadeGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.2),
        NumberSequenceKeypoint.new(0.55, 0.3),
        NumberSequenceKeypoint.new(1, 1)
    })

    local overlay = Instance.new("Frame", headerFrame)
    overlay.Size = UDim2.new(1,0,1,0)
    overlay.BackgroundColor3 = Color3.fromRGB(8,8,8)
    overlay.BackgroundTransparency = 0.35
    overlay.BorderSizePixel = 0

    local overlayGrad = Instance.new("UIGradient", overlay)
    overlayGrad.Rotation = 90
    overlayGrad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.8),
        NumberSequenceKeypoint.new(0.6, 0.2),
        NumberSequenceKeypoint.new(1, 0)
    })

    local titleLabel = Instance.new("TextLabel", headerFrame)
    titleLabel.Size = UDim2.new(1,-16,0,32)
    titleLabel.Position = UDim2.new(0,8,0,10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "NINO HUB"
    titleLabel.TextColor3 = Color3.fromRGB(255,255,255)
    titleLabel.Font = Enum.Font.GothamBlack
    titleLabel.TextSize = 22
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center

    local logoBadge = Instance.new("TextLabel", headerFrame)
    logoBadge.Size = UDim2.new(0,120,0,120)
    logoBadge.Position = UDim2.new(0.5,-60,0,30)
    logoBadge.BackgroundColor3 = Color3.fromRGB(0,0,0)
    logoBadge.BackgroundTransparency = 0.2
    logoBadge.BorderSizePixel = 0
    logoBadge.Text = "N"
    logoBadge.TextColor3 = Color3.fromRGB(255,255,255)
    logoBadge.Font = Enum.Font.GothamBlack
    logoBadge.TextSize = 80
    logoBadge.TextXAlignment = Enum.TextXAlignment.Center
    logoBadge.TextYAlignment = Enum.TextYAlignment.Center
    Instance.new("UICorner", logoBadge).CornerRadius = UDim.new(0, 20)

    local subLabel = Instance.new("TextLabel", headerFrame)
    subLabel.Size = UDim2.new(1,-16,0,16)
    subLabel.Position = UDim2.new(0,8,0,42)
    subLabel.BackgroundTransparency = 1
    subLabel.Text = "NINO HUB"
    subLabel.TextColor3 = Color3.fromRGB(180,180,180)
    subLabel.Font = Enum.Font.Gotham
    subLabel.TextSize = 10
    subLabel.TextXAlignment = Enum.TextXAlignment.Center

    local accentLine = Instance.new("Frame", headerFrame)
    accentLine.Size = UDim2.new(0,40,0,2)
    accentLine.Position = UDim2.new(0.5,-20,0,62)
    accentLine.BackgroundColor3 = Color3.fromRGB(128,0,128)
    accentLine.BackgroundTransparency = 0.6
    accentLine.BorderSizePixel = 0
    Instance.new("UICorner", accentLine).CornerRadius = UDim.new(1,0)

    local logoDiv = Instance.new("Frame", sidebar)
    logoDiv.Size = UDim2.new(1,-20,0,1)
    logoDiv.Position = UDim2.new(0,10,0,200)
    logoDiv.BackgroundColor3 = C_BORDER
    logoDiv.BorderSizePixel = 0

    local TAB_NAMES = {"Speed", "Main", "Move", "Config"}
    local tabBtns = {}

    local tabListFrame = Instance.new("Frame", sidebar)
    tabListFrame.Size = UDim2.new(1,0,1,-210)
    tabListFrame.Position = UDim2.new(0,0,0,205)
    tabListFrame.BackgroundTransparency = 1

    local tabLL = Instance.new("UIListLayout", tabListFrame)
    tabLL.SortOrder = Enum.SortOrder.LayoutOrder
    tabLL.Padding = UDim.new(0, 8)
    local tabPad = Instance.new("UIPadding", tabListFrame)
    tabPad.PaddingLeft = UDim.new(0, 12)
    tabPad.PaddingRight = UDim.new(0, 12)
    tabPad.PaddingTop = UDim.new(0, 8)

    local function switchTab(name) end

    for i, name in ipairs(TAB_NAMES) do
        local btn = Instance.new("TextButton", tabListFrame)
        btn.Size = UDim2.new(1,0,0,36)
        btn.BackgroundColor3 = C_CARD_BG
        btn.BorderSizePixel = 0
        btn.Text = ""
        btn.LayoutOrder = i
        btn.AutoButtonColor = false

        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
        local stroke = Instance.new("UIStroke", btn)
        stroke.Color = C_BORDER
        stroke.Thickness = 2
        stroke.Transparency = 0

        local lbl = Instance.new("TextLabel", btn)
        lbl.Size = UDim2.new(1,0,1,0)
        lbl.BackgroundTransparency = 1
        lbl.Text = name
        lbl.TextColor3 = C_DIM
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 13
        lbl.TextXAlignment = Enum.TextXAlignment.Center

        local activeIndicator = Instance.new("Frame", btn)
        activeIndicator.Size = UDim2.new(0.8,0,0,2)
        activeIndicator.Position = UDim2.new(0.1,0,1,-2)
        activeIndicator.BackgroundColor3 = C_ACCENT
        activeIndicator.BorderSizePixel = 0
        activeIndicator.Visible = (name == "Speed")
        Instance.new("UICorner", activeIndicator).CornerRadius = UDim.new(1,0)

        tabBtns[name] = {bg = btn, lbl = lbl, ind = activeIndicator, stroke = stroke}
        btn.MouseButton1Click:Connect(function()
            switchTab(name)
        end)
    end

    local rightPanel = Instance.new("Frame", main)
    rightPanel.Size = UDim2.new(0, TOTAL_W - SIDEBAR_W - 1, 1, 0)
    rightPanel.Position = UDim2.new(0, SIDEBAR_W+1, 0, 0)
    rightPanel.BackgroundColor3 = C_BG_INNER
    rightPanel.BorderSizePixel = 0
    rightPanel.ClipsDescendants = true
    Instance.new("UICorner", rightPanel).CornerRadius = UDim.new(0, 12)

    local topBar = Instance.new("Frame", rightPanel)
    topBar.Size = UDim2.new(1,0,0,44)
    topBar.BackgroundColor3 = C_BG_INNER
    topBar.BorderSizePixel = 0
    local topBarDiv = Instance.new("Frame", rightPanel)
    topBarDiv.Size = UDim2.new(1,-20,0,1)
    topBarDiv.Position = UDim2.new(10,0,0,44)
    topBarDiv.BackgroundColor3 = C_BORDER
    topBarDiv.BorderSizePixel = 0

    local panelTitle = Instance.new("TextLabel", topBar)
    panelTitle.Size = UDim2.new(1,-50,1,0)
    panelTitle.Position = UDim2.new(0,16,0,0)
    panelTitle.BackgroundTransparency = 1
    panelTitle.Text = "Speed"
    panelTitle.TextColor3 = C_WHITE
    panelTitle.Font = Enum.Font.GothamBlack
    panelTitle.TextSize = 16
    panelTitle.TextXAlignment = Enum.TextXAlignment.Left

    local closeBtn = Instance.new("TextButton", topBar)
    closeBtn.Size = UDim2.new(0,28,0,28)
    closeBtn.Position = UDim2.new(1,-34,0.5,-14)
    closeBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
    closeBtn.BorderSizePixel = 0
    closeBtn.Text = "–"
    closeBtn.TextColor3 = C_WHITE
    closeBtn.Font = Enum.Font.GothamBlack
    closeBtn.TextSize = 20
    closeBtn.AutoButtonColor = false
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1,0)

    closeBtn.MouseButton1Click:Connect(function()
        main.Visible = false
        if S.miniToggleButton then S.miniToggleButton.Visible = true end
    end)

    local contentArea = Instance.new("Frame", rightPanel)
    contentArea.Size = UDim2.new(1,0,1,-45)
    contentArea.Position = UDim2.new(0,0,0,45)
    contentArea.BackgroundTransparency = 1

    local pages = buildGui_createScrollingPages(contentArea)
    local activePage = pages["Speed"]
    activePage.Visible = true

    switchTab = function(name)
        if activePage then activePage.Visible = false end
        activePage = pages[name]
        activePage.Visible = true
        panelTitle.Text = name
        for tName, tData in pairs(tabBtns) do
            local isActive = (tName == name)
            tData.lbl.TextColor3 = isActive and C_WHITE or C_DIM
            tData.ind.Visible = isActive
            tData.bg.BackgroundColor3 = isActive and C_ACTIVE_BG or C_CARD_BG
            tData.stroke.Transparency = isActive and 0 or 0.4
        end
    end

    buildSpeedTab(pages)
    buildMainTab(pages)
    buildMoveTab(pages)
    buildConfigTab(pages)

    local function showGui()
        main.Visible = true
        if S.miniToggleButton then S.miniToggleButton.Visible = false end
    end
    S.miniToggleButton = buildGui_createMiniToggle(gui, showGui)

    UIS.InputBegan:Connect(function(input, gpe)
        if input.UserInputType ~= Enum.UserInputType.Keyboard and input.UserInputType ~= Enum.UserInputType.Gamepad1 then return end
        local kc = input.KeyCode
        local function match(entry)
            return kc == entry.kb or (entry.gp and kc == entry.gp)
        end
        if gpe then
            if match(S.KB.GuiHide) then
                if main.Visible then
                    main.Visible = false
                    if S.miniToggleButton then S.miniToggleButton.Visible = true end
                else
                    showGui()
                end
            end
            return
        end
        if match(S.KB.DropBrainrot) then
            task.spawn(runDropBrainrot)
        elseif match(S.KB.TPFlor) then
            runTPFloor()
        elseif match(S.KB.AutoLeft) then
            if AutoPlay.Enabled and AutoPlay.Side == "left" then
                setAutoPlay("left", false)
            else
                if AutoPlay.Enabled and AutoPlay.Side == "right" then
                    setAutoPlay("right", false)
                end
                if S.batAimbotEnabled then setBatAimbot(false) end
                setAutoPlay("left", true)
            end
            if S.autoLeftSetVisual then S.autoLeftSetVisual(AutoPlay.Enabled and AutoPlay.Side == "left") end
            updateAutoPlayUI()
            S.restartMovement(); updateFloatingButtons(); saveConfig()
        elseif match(S.KB.AutoRight) then
            if AutoPlay.Enabled and AutoPlay.Side == "right" then
                setAutoPlay("right", false)
            else
                if AutoPlay.Enabled and AutoPlay.Side == "left" then
                    setAutoPlay("left", false)
                end
                if S.batAimbotEnabled then setBatAimbot(false) end
                setAutoPlay("right", true)
            end
            if S.autoRightSetVisual then S.autoRightSetVisual(AutoPlay.Enabled and AutoPlay.Side == "right") end
            updateAutoPlayUI()
            S.restartMovement(); updateFloatingButtons(); saveConfig()
        elseif match(S.KB.AutoBat) then
            local newState = not S.batAimbotEnabled
            if newState and AutoPlay.Enabled then
                setAutoPlay(AutoPlay.Side, false)
            end
            setBatAimbot(newState)
        elseif match(S.KB.GuiHide) then
            if main.Visible then
                main.Visible = false
                if S.miniToggleButton then S.miniToggleButton.Visible = true end
            else
                showGui()
            end
        elseif match(S.KB.SpeedToggle) then
            if S.laggerMode ~= 0 then
                S.laggerMode = 0
                if S.setLaggerVisual then S.setLaggerVisual(false) end
                updateLaggerButtonVisual()
            end
            S.speedMode = not S.speedMode
            if S.speedClk then S.speedClk(S.speedMode) end
            S.restartMovement(); updateFloatingButtons(); saveConfig()
        elseif match(S.KB.LaggerToggle) then
            if S.speedMode then
                S.speedMode = false
                if S.speedClk then S.speedClk(false) end
            end
            S.laggerMode = (S.laggerMode == 1) and 2 or 1
            updateLaggerButtonVisual()
            if S.setLaggerVisual then S.setLaggerVisual(true) end
            S.restartMovement(); updateFloatingButtons(); saveConfig()
        elseif match(S.KB.AutoTPDown) then
            S.autoTpDownEnabled = not S.autoTpDownEnabled
            if S.autoTpDownEnabled then startAutoTpDown() else stopAutoTpDown() end
            if S.autoTpDownSetVisual then S.autoTpDownSetVisual(S.autoTpDownEnabled) end
            if S.autoTpDownFloatVisual then S.autoTpDownFloatVisual(S.autoTpDownEnabled) end
            saveConfig()
        end
    end)

    showGui()
end

-- ============================================================
-- PANEL FLOTANTE PRINCIPAL
-- ============================================================
local function createFloatingButtonPanel()
    local panelGui = Instance.new("ScreenGui")
    panelGui.Name = "Ninohub_FloatingPanel"; panelGui.ResetOnSpawn = false
    panelGui.IgnoreGuiInset = true; panelGui.DisplayOrder = 8
    if not pcall(function() panelGui.Parent = game:GetService("CoreGui") end) then
        panelGui.Parent = LP:WaitForChild("PlayerGui")
    end
    S.floatingPanelGui = panelGui
    local panelFrame = Instance.new("Frame", panelGui)
    panelFrame.Size = UDim2.new(0, 155, 0, 0)
    panelFrame.Position = UDim2.new(1, -163, 0.5, -200)
    panelFrame.BackgroundColor3 = Color3.fromRGB(4,4,6)
    panelFrame.BackgroundTransparency = 1
    panelFrame.BorderSizePixel = 0
    panelFrame.Active = true
    panelFrame.AutomaticSize = Enum.AutomaticSize.Y
    Instance.new("UICorner", panelFrame).CornerRadius = UDim.new(0,14)
    S.floatingPanelFrame = panelFrame
    makeDraggable(panelFrame, true)
    
    local btnGrid = Instance.new("Frame", panelFrame)
    btnGrid.Size = UDim2.new(1,-8,0,0)
    btnGrid.Position = UDim2.new(0,4,0,20)
    btnGrid.BackgroundTransparency = 1
    btnGrid.AutomaticSize = Enum.AutomaticSize.Y
    
    local gridLayout = Instance.new("UIGridLayout", btnGrid)
    gridLayout.CellSize = UDim2.new(0.5,-4,0,65)
    gridLayout.CellPadding = UDim2.new(0,8,0,10)
    gridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    gridLayout.FillDirectionMaxCells = 2
    
    local pad = Instance.new("UIPadding", btnGrid)
    pad.PaddingLeft = UDim.new(0,2)
    pad.PaddingRight = UDim.new(0,2)
    pad.PaddingTop = UDim.new(0,2)
    pad.PaddingBottom = UDim.new(0,2)
    
    local BLACK_OFF = Color3.fromRGB(0,0,0)
    local WHITE_ON = Color3.fromRGB(255,255,255)
    local STROKE_OFF = Color3.fromRGB(80,80,80)
    local STROKE_ON = Color3.fromRGB(150,150,150)
    
    local function makePButton(label1, label2, order)
        local btn = Instance.new("TextButton", btnGrid)
        btn.LayoutOrder = order
        btn.BackgroundColor3 = BLACK_OFF
        btn.BorderSizePixel = 0
        btn.Text = ""
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)
        local stroke = Instance.new("UIStroke", btn)
        stroke.Color = Color3.fromRGB(100,100,100)
        stroke.Thickness = 2
        local t1 = Instance.new("TextLabel", btn)
        t1.Size = UDim2.new(1,0,0.55,0)
        t1.Position = UDim2.new(0,0,0.06,0)
        t1.BackgroundTransparency = 1
        t1.Text = label1
        t1.TextColor3 = WHITE_ON
        t1.Font = Enum.Font.GothamBlack
        t1.TextSize = 12
        t1.TextXAlignment = Enum.TextXAlignment.Center
        local t2 = Instance.new("TextLabel", btn)
        t2.Size = UDim2.new(1,0,0.4,0)
        t2.Position = UDim2.new(0,0,0.55,0)
        t2.BackgroundTransparency = 1
        t2.Text = label2
        t2.TextColor3 = WHITE_ON
        t2.Font = Enum.Font.GothamBlack
        t2.TextSize = 10
        t2.TextXAlignment = Enum.TextXAlignment.Center
        if label1 == "DROP" then
            t2.Visible = false
            t1.Size = UDim2.new(1,0,1,0)
            t1.Position = UDim2.new(0,0,0,0)
            t1.TextSize = 13
        end
        return btn, stroke, t1, t2
    end
    
    local function setButtonActive(btn, stroke, label1, label2, active)
        btn.BackgroundColor3 = active and WHITE_ON or BLACK_OFF
        stroke.Color = active and STROKE_ON or STROKE_OFF
        local textColor = active and Color3.fromRGB(0,0,0) or WHITE_ON
        if label1 then label1.TextColor3 = textColor end
        if label2 then label2.TextColor3 = textColor end
    end
    S._setPButtonActive = setButtonActive

    local btnDROP, bsDROP, l1DROP, l2DROP = makePButton("DROP", "BRAINROT", 1)
    local btnAL, bsAL, l1AL, l2AL = makePButton("AUTO", "LEFT", 2)
    local btnBAT, bsBAT, l1BAT, l2BAT = makePButton("BAT", "AIMBOT", 3)
    local btnAR, bsAR, l1AR, l2AR = makePButton("AUTO", "RIGHT", 4)
    local btnTP, bsTP, l1TP, l2TP = makePButton("TP", "DOWN", 5)
    local btnCS, bsCS, l1CS, l2CS = makePButton("CARRY", "SPD", 6)
    local btnLAG, bsLAG, l1LAG, l2LAG = makePButton("LAGGER", "MODE", 7)
    local btnATD, bsATD, l1ATD, l2ATD = makePButton("AUTO TP", "DOWN", 8)

    S._btnAAL = btnAL; S._bsAAL = bsAL; S._l1AAL = l1AL; S._l2AAL = l2AL
    S._btnAAR = btnAR; S._bsAAR = bsAR; S._l1AAR = l1AR; S._l2AAR = l2AR
    S._btnBAT = btnBAT; S._bsBAT = bsBAT; S._l1BAT = l1BAT; S._l2BAT = l2BAT

    S._floatingButtons = {
        lagger = btnLAG, strokeLagger = bsLAG, l1Lagger = l1LAG, l2Lagger = l2LAG,
        carry = btnCS, strokeCarry = bsCS, l1Carry = l1CS, l2Carry = l2CS,
        autoLeft = btnAL, strokeAutoLeft = bsAL, l1AutoLeft = l1AL, l2AutoLeft = l2AL,
        autoRight = btnAR, strokeAutoRight = bsAR, l1AutoRight = l1AR, l2AutoRight = l2AR,
        bat = btnBAT, strokeBat = bsBAT, l1Bat = l1BAT, l2Bat = l2BAT,
        autoTPDown = btnATD, strokeAutoTPDown = bsATD, l1AutoTPDown = l1ATD, l2AutoTPDown = l2ATD,
    }

    l1LAG.Text = "LAGGER"
    l2LAG.Text = (S.laggerMode == 1 and "1") or "2"
    setButtonActive(btnLAG, bsLAG, l1LAG, l2LAG, true)
    setButtonActive(btnCS, bsCS, l1CS, l2CS, S.speedMode)
    setButtonActive(btnAL, bsAL, l1AL, l2AL, AutoPlay.Enabled and AutoPlay.Side == "left")
    setButtonActive(btnAR, bsAR, l1AR, l2AR, AutoPlay.Enabled and AutoPlay.Side == "right")
    setButtonActive(btnBAT, bsBAT, l1BAT, l2BAT, S.batAimbotEnabled)
    setButtonActive(btnATD, bsATD, l1ATD, l2ATD, S.autoTpDownEnabled)

    S.autoTpDownFloatVisual = function(state)
        setButtonActive(btnATD, bsATD, l1ATD, l2ATD, state)
    end

    btnDROP.MouseButton1Click:Connect(function()
        setButtonActive(btnDROP, bsDROP, l1DROP, l2DROP, true)
        task.delay(0.5, function() setButtonActive(btnDROP, bsDROP, l1DROP, l2DROP, false) end)
        task.spawn(runDropBrainrot)
    end)
    btnTP.MouseButton1Click:Connect(function()
        setButtonActive(btnTP, bsTP, l1TP, l2TP, true)
        task.delay(0.35, function() setButtonActive(btnTP, bsTP, l1TP, l2TP, false) end)
        runTPFloor()
    end)
    btnBAT.MouseButton1Click:Connect(function()
        local newState = not S.batAimbotEnabled
        if newState and AutoPlay.Enabled then
            setAutoPlay(AutoPlay.Side, false)
        end
        setBatAimbot(newState)
    end)
    btnAL.MouseButton1Click:Connect(function()
        if AutoPlay.Enabled and AutoPlay.Side == "left" then
            setAutoPlay("left", false)
        else
            if AutoPlay.Enabled and AutoPlay.Side == "right" then
                setAutoPlay("right", false)
            end
            if S.batAimbotEnabled then setBatAimbot(false); setButtonActive(btnBAT, bsBAT, l1BAT, l2BAT, false) end
            setAutoPlay("left", true)
        end
        if S.autoLeftSetVisual then S.autoLeftSetVisual(AutoPlay.Enabled and AutoPlay.Side == "left") end
        setButtonActive(btnAL, bsAL, l1AL, l2AL, AutoPlay.Enabled and AutoPlay.Side == "left")
        setButtonActive(btnAR, bsAR, l1AR, l2AR, AutoPlay.Enabled and AutoPlay.Side == "right")
        S.restartMovement(); updateFloatingButtons(); saveConfig()
    end)
    btnAR.MouseButton1Click:Connect(function()
        if AutoPlay.Enabled and AutoPlay.Side == "right" then
            setAutoPlay("right", false)
        else
            if AutoPlay.Enabled and AutoPlay.Side == "left" then
                setAutoPlay("left", false)
            end
            if S.batAimbotEnabled then setBatAimbot(false); setButtonActive(btnBAT, bsBAT, l1BAT, l2BAT, false) end
            setAutoPlay("right", true)
        end
        if S.autoRightSetVisual then S.autoRightSetVisual(AutoPlay.Enabled and AutoPlay.Side == "right") end
        setButtonActive(btnAR, bsAR, l1AR, l2AR, AutoPlay.Enabled and AutoPlay.Side == "right")
        setButtonActive(btnAL, bsAL, l1AL, l2AL, AutoPlay.Enabled and AutoPlay.Side == "left")
        S.restartMovement(); updateFloatingButtons(); saveConfig()
    end)
    btnLAG.MouseButton1Click:Connect(function()
        if S.laggerMode == 1 then S.laggerMode = 2
        else S.laggerMode = 1 end
        if S.speedMode then
            S.speedMode = false
            if S.speedClk then S.speedClk(false) end
            setButtonActive(btnCS, bsCS, l1CS, l2CS, false)
        end
        updateLaggerButtonVisual()
        if S.setLaggerVisual then S.setLaggerVisual(true) end
        S.restartMovement()
        updateFloatingButtons()
        saveConfig()
    end)
    btnCS.MouseButton1Click:Connect(function()
        local newState = not S.speedMode
        if newState and S.laggerMode ~= 0 then
            S.laggerMode = 0
            if S.setLaggerVisual then S.setLaggerVisual(false) end
            updateLaggerButtonVisual()
        end
        S.speedMode = newState
        if S.speedClk then S.speedClk(newState) end
        setButtonActive(btnCS, bsCS, l1CS, l2CS, newState)
        S.restartMovement(); updateFloatingButtons(); saveConfig()
    end)
    btnATD.MouseButton1Click:Connect(function()
        local newState = not S.autoTpDownEnabled
        S.autoTpDownEnabled = newState
        if newState then startAutoTpDown() else stopAutoTpDown() end
        if S.autoTpDownSetVisual then S.autoTpDownSetVisual(newState) end
        if S.autoTpDownFloatVisual then S.autoTpDownFloatVisual(newState) end
        saveConfig()
    end)
end

-- ============================================================
-- HUD PRINCIPAL
-- ============================================================
local function createHUD()
    local HudGui = Instance.new("ScreenGui")
    HudGui.Name = "Ninohub_PhazeHUD"; HudGui.ResetOnSpawn = false
    HudGui.IgnoreGuiInset = true; HudGui.DisplayOrder = 15
    if not pcall(function() HudGui.Parent = game:GetService("CoreGui") end) then
        HudGui.Parent = LP:WaitForChild("PlayerGui")
    end
    
    S.topBarHUD = Instance.new("Frame")
    S.topBarHUD.Size = UDim2.new(0,235 * S.hudScale, 0,29 * S.hudScale)
    S.topBarHUD.Position = UDim2.new(0.5, -235 * S.hudScale / 2, 0, 12)
    S.topBarHUD.BackgroundColor3 = Color3.fromRGB(255,255,255)
    S.topBarHUD.BackgroundTransparency = 0.1
    S.topBarHUD.BorderSizePixel = 0
    S.topBarHUD.Visible = true
    S.topBarHUD.Parent = HudGui
    Instance.new("UICorner", S.topBarHUD).CornerRadius = UDim.new(0,9)
    local topStroke = Instance.new("UIStroke", S.topBarHUD)
    topStroke.Thickness = 1.3
    topStroke.Color = Color3.fromRGB(128,0,128)
    topStroke.Transparency = 0.88
    
    local topLabel = Instance.new("TextLabel", S.topBarHUD)
    topLabel.Size = UDim2.new(1,-10,1,0)
    topLabel.Position = UDim2.new(0,5,0,0)
    topLabel.BackgroundTransparency = 1
    topLabel.Text = "NINO HUB | FPS: 0 PING: 0ms"
    topLabel.TextColor3 = Color3.fromRGB(0,0,0)
    topLabel.Font = Enum.Font.GothamBold
    topLabel.TextSize = 12.5
    topLabel.TextStrokeTransparency = 0.6
    topLabel.TextStrokeColor3 = Color3.fromRGB(128,0,128)
    topLabel.ClipsDescendants = true
    
    S.progressBarFrame = Instance.new("Frame")
    S.progressBarFrame.Size = UDim2.new(0,235 * S.hudScale, 0,15 * S.hudScale)
    S.progressBarFrame.Position = UDim2.new(0.5, -235 * S.hudScale / 2, 0, 12 + 29 * S.hudScale + 5)
    S.progressBarFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    S.progressBarFrame.BackgroundTransparency = 0.35
    S.progressBarFrame.BorderSizePixel = 0
    S.progressBarFrame.Visible = true
    S.progressBarFrame.Parent = HudGui
    S.progressBarFrame.ClipsDescendants = true
    Instance.new("UICorner", S.progressBarFrame).CornerRadius = UDim.new(0,6)
    local progStroke = Instance.new("UIStroke", S.progressBarFrame)
    progStroke.Thickness = 1.1
    progStroke.Color = Color3.fromRGB(128,0,128)
    progStroke.Transparency = 0.88
    
    S.progressFill = Instance.new("Frame", S.progressBarFrame)
    S.progressFill.Size = UDim2.new(0,0,1,0)
    S.progressFill.Position = UDim2.new(0,0,0,0)
    S.progressFill.BackgroundColor3 = Color3.fromRGB(128,0,128)
    S.progressFill.BorderSizePixel = 0
    Instance.new("UICorner", S.progressFill).CornerRadius = UDim.new(0,4)
    
    S.progressPct = Instance.new("TextLabel", S.progressBarFrame)
    S.progressPct.Size = UDim2.new(1,0,1,0)
    S.progressPct.BackgroundTransparency = 1
    S.progressPct.Text = "0%"
    S.progressPct.TextColor3 = Color3.fromRGB(0,0,0)
    S.progressPct.Font = Enum.Font.GothamBold
    S.progressPct.TextSize = 10.5
    S.progressPct.TextStrokeTransparency = 0.7
    
    local _hudTimer = 0
    RunService.Heartbeat:Connect(function(dt)
        _hudTimer = _hudTimer + dt
        if _hudTimer >= 0.5 then
            _hudTimer = 0
            local ping = 0
            pcall(function() ping = math.floor(LP:GetNetworkPing()*1000) end)
            topLabel.Text = "NINO HUB | FPS: "..S.currentFPS.." PING: "..ping.."ms"
        end
    end)
end

-- ============================================================
-- INICIALIZACIÓN
-- ============================================================
buildGui()
createFloatingButtonPanel()
createHUD()

local function loadConfig()
    if not safeIsfile(S.CONFIG_FILE) then return end
    local data = safeReadfile(S.CONFIG_FILE)
    if not data then return end
    local ok, cfg = pcall(function() return HS:JSONDecode(data) end)
    if not ok or type(cfg) ~= "table" then return end

    if cfg.normalSpeed then S.NS = cfg.normalSpeed; if S.normalBox then S.normalBox.Text = tostring(S.NS) end end
    if cfg.carrySpeed then S.CS = cfg.carrySpeed; if S.carryBox then S.carryBox.Text = tostring(S.CS) end end
    if cfg.laggerSpeed then S.LS = cfg.laggerSpeed; if S.laggerBox then S.laggerBox.Text = tostring(S.LS) end end
    if cfg.laggerSpeed2 then S.LS2 = cfg.laggerSpeed2; if S.lagger2Box then S.lagger2Box.Text = tostring(S.LS2) end end
    if cfg.laggerMode then S.laggerMode = cfg.laggerMode end
    if cfg.hudScale then S.hudScale = cfg.hudScale; updateHudScale() end
    if cfg.batAimbotSpeed then S.batAimbotSpeed = cfg.batAimbotSpeed end

    if S.laggerMode == 0 then S.laggerMode = 1 end

    local function tryLoadKey(entry, kbName, gpName)
        if kbName and Enum.KeyCode[kbName] then
            entry.kb = Enum.KeyCode[kbName]; entry.gp = nil
        elseif gpName and Enum.KeyCode[gpName] then
            entry.gp = Enum.KeyCode[gpName]; entry.kb = nil
        end
    end
    if cfg.dropBrainrotKey then tryLoadKey(S.KB.DropBrainrot, cfg.dropBrainrotKey.kb, cfg.dropBrainrotKey.gp) end
    if cfg.autoLeftKey then tryLoadKey(S.KB.AutoLeft, cfg.autoLeftKey.kb, cfg.autoLeftKey.gp) end
    if cfg.autoRightKey then tryLoadKey(S.KB.AutoRight, cfg.autoRightKey.kb, cfg.autoRightKey.gp) end
    if cfg.autoBatKey then tryLoadKey(S.KB.AutoBat, cfg.autoBatKey.kb, cfg.autoBatKey.gp) end
    if cfg.tpFloorKey then tryLoadKey(S.KB.TPFlor, cfg.tpFloorKey.kb, cfg.tpFloorKey.gp) end
    if cfg.guiHideKey then tryLoadKey(S.KB.GuiHide, cfg.guiHideKey.kb, cfg.guiHideKey.gp) end
    if cfg.speedToggleKey then tryLoadKey(S.KB.SpeedToggle, cfg.speedToggleKey.kb, cfg.speedToggleKey.gp) end
    if cfg.laggerToggleKey then tryLoadKey(S.KB.LaggerToggle, cfg.laggerToggleKey.kb, cfg.laggerToggleKey.gp) end
    if cfg.autoTPDownKey then tryLoadKey(S.KB.AutoTPDown, cfg.autoTPDownKey.kb, cfg.autoTPDownKey.gp) end

    if cfg.autoTpDownYTarget then S.autoTpDownYTarget = cfg.autoTpDownYTarget end
    if cfg.autoTpDownHeightLimit then S.autoTpDownHeightLimit = cfg.autoTpDownHeightLimit end

    if cfg.antiRagdoll then toggleAntiRag(true); if S.setAntiRagVisual then S.setAntiRagVisual(true) end end
    if cfg.infiniteJump and not cfg.holdJumpEnabled then S.infJumpEnabled = true; startInfiniteJump(); if S.setInfJumpVisual then S.setInfJumpVisual(true) end end
    if cfg.holdJumpEnabled then S.infJumpEnabled = false; if S.setInfJumpVisual then S.setInfJumpVisual(false) end; S.holdJumpEnabled = true; startHoldJump(); if S.setHoldJumpVisual then S.setHoldJumpVisual(true) end end
    if cfg.medusaCounter then S.medusaCounterEnabled = true; setupMedusaCounter(LP.Character); if S.setMedusaVisual then S.setMedusaVisual(true) end end
    if cfg.carryMode then S.speedMode = true; S.laggerMode = 0; if S.speedClk then S.speedClk(true) end end
    if cfg.laggerMode and cfg.laggerMode > 0 and not cfg.carryMode then S.laggerMode = cfg.laggerMode; if S.setLaggerVisual then S.setLaggerVisual(true) end end
    if cfg.batAimbot then setBatAimbot(true) end
    if cfg.batCounter then S.batCounterEnabled = true; startBatCounter(); if S.setBatCounterVisual then S.setBatCounterVisual(true) end end
    if cfg.unwalkEnabled then S.unwalkEnabled = true; startUnwalk(); if S.setUnwalkVisual then S.setUnwalkVisual(true) end end
    if cfg.lockUI then S.lockUIEnabled = true; setUILock(true); if S.setLockUI_Visual then S.setLockUI_Visual(true) end end
    if cfg.hideOpiumButtons then S.hideOpiumButtonsEnabled = true; if S.setHideOpiumButtons then S.setHideOpiumButtons(true) end; if S.floatingPanelGui then S.floatingPanelGui.Enabled = false end end
    if cfg.fpsBoost then S.fpsBoostEnabled = true; applyFPSBoost(); if S.setFpsVisual then S.setFpsVisual(true) end end
    if cfg.galaxyMode then galaxyOn = true; updateGalaxy(); if S.setDarkVisual then S.setDarkVisual(true) end end
    if cfg.autoTpDownEnabled then S.autoTpDownEnabled = true; startAutoTpDown(); if S.autoTpDownSetVisual then S.autoTpDownSetVisual(true) end end
    if cfg.bypassAimbotEnabled then 
        setBypassEnabled(true)
        setBypassButtonActive(true)
    end
    if cfg.ninoTimeEnabled ~= nil then
        S.ninoTimeEnabled = cfg.ninoTimeEnabled
        if S.ninoTimeEnabled then
            startNinoTime()
        else
            stopNinoTime()
        end
        if S.setNinoTimeVisual then S.setNinoTimeVisual(S.ninoTimeEnabled) end
    else
        startNinoTime()
        if S.setNinoTimeVisual then S.setNinoTimeVisual(true) end
    end
    
    -- Auto Play config
    if cfg.autoPlayGoingSpeed then
        AutoPlay.GoingSpeed = cfg.autoPlayGoingSpeed
    end
    if cfg.autoPlayStealSpeed then
        AutoPlay.StealSpeed = cfg.autoPlayStealSpeed
    end
    saveAutoPlayConfig()
    
    -- Auto Grab config
    if cfg.autoGrabEnabled ~= nil then
        AutoGrab.AUTO_STEAL_ENABLED = cfg.autoGrabEnabled
        if S.setInstaGrab then S.setInstaGrab(AutoGrab.AUTO_STEAL_ENABLED) end
        if AutoGrab.AUTO_STEAL_ENABLED then startAutoSteal() else stopAutoSteal() end
    end
    if cfg.autoGrabRange then
        AutoGrab.PRIME_RANGE = cfg.autoGrabRange
        if S.radInput then S.radInput.Text = tostring(cfg.autoGrabRange) end
    end
    if cfg.autoGrabDuration then
        AutoGrab.HOLD_MAX = cfg.autoGrabDuration
        AutoGrab.HOLD_MIN = cfg.autoGrabDuration * 0.5
        if S.stealDurationBox then S.stealDurationBox.Text = tostring(cfg.autoGrabDuration) end
    end

    if cfg.floatingPanelPos and S.floatingPanelFrame then
        local x = cfg.floatingPanelPos.X or -163
        local y = cfg.floatingPanelPos.Y or -200
        S.floatingPanelFrame.Position = UDim2.new(1, x, 0.5, y)
    end
    
    if cfg.bypassTogglePos and bypassPanelFrame then
        local x = cfg.bypassTogglePos.X or -175
        local y = cfg.bypassTogglePos.Y or -100
        bypassPanelFrame.Position = UDim2.new(1, x, 0.5, y)
    end

    local fb = S._floatingButtons
    if fb.lagger then updateLaggerButtonVisual() end

    S.restartMovement()
    updateFloatingButtons()
    updateAutoPlayUI()
end

task.wait(0.5); loadConfig()

task.spawn(function()
    task.wait(0.2)
    if S.antiRagdollEnabled then startAntiRagdoll() end
    if S.unwalkEnabled then startUnwalk() end
    if S.medusaCounterEnabled and LP.Character then setupMedusaCounter(LP.Character) end
    if S.batAimbotEnabled then startBatAimbot() end
    if S.batCounterEnabled then startBatCounter() end
    if S.infJumpEnabled then startInfiniteJump() end
    if S.holdJumpEnabled then startHoldJump() end
    if S.autoTpDownEnabled then startAutoTpDown() end
    if AutoGrab.AUTO_STEAL_ENABLED then startAutoSteal() end
    if S.fpsBoostEnabled then applyFPSBoost() end
    if galaxyOn then updateGalaxy() end
    if bypassState.enabled then startBypassAimbot() end
    if S.ninoTimeEnabled then startNinoTime() end
end)

if LP.Character then task.wait(0.3); S.setupSpeedBillboard(LP.Character) end

LP.CharacterAdded:Connect(function(char)
    if AutoPlay.Enabled then
        setAutoPlay(AutoPlay.Side, false)
    end
    if S.batAimbotEnabled then stopBatAimbot() end
    if S.batCounterEnabled then stopBatCounter() end

    if S.antiRagdollEnabled then task.wait(0.1); startAntiRagdoll() end
    if S.unwalkEnabled then task.wait(0.5); startUnwalk() end
    if S.medusaCounterEnabled then setupMedusaCounter(char) end
    task.wait(0.3)
    S.h = char:WaitForChild("Humanoid", 5)
    S.hrp = char:WaitForChild("HumanoidRootPart", 5)
    if S.h and S.hrp then S.setupSpeedBillboard(char) end
    if AutoPlay.Enabled then
        setAutoPlay(AutoPlay.Side, true)
    end
    if S.batAimbotEnabled then startBatAimbot() end
    if S.batCounterEnabled then startBatCounter() end
    S.restartMovement()
    if S.infJumpEnabled then startInfiniteJump() end
    if S.holdJumpEnabled then startHoldJump() end
    if S.autoTpDownEnabled then startAutoTpDown() end
    if AutoGrab.AUTO_STEAL_ENABLED then startAutoSteal() end
    if S.fpsBoostEnabled then
        task.wait(0.5); applyFPSBoost()
        if galaxyOn then task.wait(0.3); updateGalaxy() end
    else
        if galaxyOn then updateGalaxy() end
    end
    if bypassState.enabled then setupBypassChar(char); startBypassAimbot() end
    if S.ninoTimeEnabled then 
        setupStunDetection(char)
        createStunTimerBillboard()
    end
end)

if LP.Character then
    task.spawn(function()
        local char = LP.Character
        if S.antiRagdollEnabled then startAntiRagdoll() end
        if S.unwalkEnabled then startUnwalk() end
        if S.medusaCounterEnabled then setupMedusaCounter(char) end
        S.h = char:FindFirstChildOfClass("Humanoid")
        S.hrp = char:FindFirstChild("HumanoidRootPart")
        if S.h and S.hrp then S.setupSpeedBillboard(char) end
        if AutoPlay.Enabled then
            setAutoPlay(AutoPlay.Side, true)
        end
        S.restartMovement()
        if S.infJumpEnabled then startInfiniteJump() end
        if S.holdJumpEnabled then startHoldJump() end
        if S.batAimbotEnabled then startBatAimbot() end
        if S.batCounterEnabled then startBatCounter() end
        if S.autoTpDownEnabled then startAutoTpDown() end
        if AutoGrab.AUTO_STEAL_ENABLED then startAutoSteal() end
        if S.fpsBoostEnabled then
            applyFPSBoost()
            if galaxyOn then task.wait(0.3); updateGalaxy() end
        else
            if galaxyOn then updateGalaxy() end
        end
        if bypassState.enabled then setupBypassChar(char); startBypassAimbot() end
        if S.ninoTimeEnabled then 
            setupStunDetection(char)
            createStunTimerBillboard()
        end
    end)
end