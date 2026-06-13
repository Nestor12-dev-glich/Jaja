-- ╔═══════════════════════════════════════════════════════════════════════════╗
-- ║                    NINO MEGA FINAL - ALL IN ONE                           ║
-- ║  ATR Autoplay + AutoGrab Prime + Speed Bypass + Instant Reset +           ║
-- ║  Medusa Counter + Bat Aimbot + All Features Combined                      ║
-- ║                                                                           ║
-- ║  discord.gg/MSJyWr49a | ATR auto play v1                                 ║
-- ╚═══════════════════════════════════════════════════════════════════════════╝

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local Stats = game:GetService("Stats")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local UIS = UserInputService

local Player = Players.LocalPlayer
local workspace = workspace

-- ========== CONFIGURATION ==========
local ConfigFileName = "NINO_MEGA_Config.json"
local Values = { 
    -- ATR Autoplay
    GoingSpeed = 55, 
    StealSpeed = 29,
    -- Speed Bypass (Nither)
    SpeedBypassEnabled = false,
    SpeedAmount = 31.25,
    LagAmount = 0.011200,
    -- AutoGrab
    AUTO_STEAL_ENABLED = false,
    HOLD_MIN = 1.3,
    HOLD_MAX = 2.6,
    ENTRY_DELAY = 0.3,
    COOLDOWN = 0.05,
    STEAL_RANGE = 10,
    PRIME_RANGE = 80,
    -- Instant Reset
    InstaResetEnabled = false,
    -- Medusa
    MedusaCounterEnabled = false,
    MedusaAutoResetEnabled = false,
    -- Bat Aimbot
    BatAimbotEnabled = false,
}

-- ========== CONFIG FILE MANAGEMENT ==========
local function loadConfig()
    if not readfile or not isfile then return end
    pcall(function()
        if isfile(ConfigFileName) then
            local data = HttpService:JSONDecode(readfile(ConfigFileName))
            for k, v in pairs(data) do
                Values[k] = v
            end
        end
    end)
end

local function saveConfig()
    if not writefile then return end
    pcall(function()
        writefile(ConfigFileName, HttpService:JSONEncode(Values))
    end)
end

loadConfig()

-- ========== WAYPOINTS (ATR AUTOPLAY) ==========
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

-- ========== PROXY PART (ATR AUTOPLAY) ==========
local proxy = nil
local function ensureProxy()
    local char = Player.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    if not proxy or proxy.Parent ~= char then
        if proxy then proxy:Destroy() end
        proxy = Instance.new("Part")
        proxy.Name = "Nino_MegaProxy"
        proxy.Size = Vector3.new(1,1,1)
        proxy.Transparency = 1
        proxy.CanCollide = false
        proxy.Massless = true
        proxy.Parent = char
        local weld = Instance.new("Weld")
        weld.Part0 = hrp
        weld.Part1 = proxy
        weld.C0 = CFrame.new(0,0,0)
        weld.Parent = proxy
    end
    return proxy
end

-- ========== MOVEMENT HELPER (ATR AUTOPLAY) ==========
local function moveTo(target, speed)
    local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local dir = (target - hrp.Position)
    local moveDir = Vector3.new(dir.X, 0, dir.Z).Unit
    local hum = Player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum:Move(moveDir, false) end
    if proxy then
        local currentVel = proxy.AssemblyLinearVelocity
        proxy.AssemblyLinearVelocity = Vector3.new(moveDir.X * speed, currentVel.Y, moveDir.Z * speed)
    end
end

local function stopMoving()
    if proxy then proxy.AssemblyLinearVelocity = Vector3.new(0,0,0) end
    local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum:Move(Vector3.zero, false) end
end

-- ========== PATROL LOGIC (ATR AUTOPLAY) ==========
local activeConnection = nil
local activeWaypoints = nil
local waypointIndex = 1
local currentPhase = 1

local function startPatrol(waypoints)
    if activeConnection then activeConnection:Disconnect() end
    activeWaypoints = waypoints
    waypointIndex = 1
    currentPhase = 1
    ensureProxy()
    activeConnection = RunService.Stepped:Connect(function()
        if not activeWaypoints then return end
        local char = Player.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local target = activeWaypoints[waypointIndex]
        if not target then return end
        
        local dist = (target - hrp.Position).Magnitude
        local speed = (currentPhase <= 2) and Values.GoingSpeed or Values.StealSpeed
        if dist < 2.5 then
            waypointIndex = waypointIndex + 1
            if waypointIndex > #activeWaypoints then
                activeConnection:Disconnect()
                activeConnection = nil
                activeWaypoints = nil
                if Enabled.AutoLeft then
                    Enabled.AutoLeft = false
                elseif Enabled.AutoRight then
                    Enabled.AutoRight = false
                end
                if updateButtonUI then updateButtonUI() end
                stopMoving()
                return
            end
            if waypointIndex == 3 then
                currentPhase = 3
            end
        else
            moveTo(target, speed)
        end
    end)
end

local function stopPatrol()
    if activeConnection then activeConnection:Disconnect(); activeConnection = nil end
    activeWaypoints = nil
    waypointIndex = 1
    stopMoving()
end

-- ========== SPEED BYPASS (NITHER - message script) ==========
local speedBypassEnabled = Values.SpeedBypassEnabled
local speedBypassActive = false

local function setupSpeedBypass()
    pcall(function()
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.Brightness = 1
        Lighting.EnvironmentDiffuseScale = 0
        Lighting.EnvironmentSpecularScale = 0
        for _, e in pairs(Lighting:GetChildren()) do
            if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect")
            or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                e.Enabled = false
            end
        end
        for _, obj in pairs(workspace:GetDescendants()) do
            pcall(function()
                if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or obj:IsA("Fire") then
                    obj.Enabled = false
                end
                if obj:IsA("Decal") or obj:IsA("Texture") then
                    obj.Transparency = 1
                end
                if obj:IsA("BasePart") then
                    obj.Material = Enum.Material.Plastic
                    obj.Reflectance = 0
                    obj.CastShadow = false
                end
            end)
        end
    end)
end

RunService.RenderStepped:Connect(function()
    if not speedBypassActive then return end
    local char = Player.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hrp and hum and hum.MoveDirection.Magnitude > 0 then
            hrp.Velocity = Vector3.new(
                hum.MoveDirection.X * Values.SpeedAmount,
                hrp.Velocity.Y,
                hum.MoveDirection.Z * Values.SpeedAmount
            )
        end
    end
    local t = tick()
    while tick() - t < Values.LagAmount do end
end)

-- ========== INSTANT RESET (NRHUB) ==========
local resetRemote = nil
local resetCooldown = false
local RESET_GUID = HttpService:GenerateGUID(false)

local function findResetRemote()
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") and obj.Name:sub(1,3) == "RE/" then
            return obj
        end
    end
    return nil
end

local function instaReset()
    if resetCooldown then return end
    if not resetRemote then
        resetRemote = findResetRemote()
        if not resetRemote then return end
    end
    resetCooldown = true
    local character = Player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if humanoid and humanoid.Health <= 0 then
        pcall(function() resetRemote:FireServer(RESET_GUID, Player, "balloon") end)
        resetCooldown = false
        return
    end
    local resetDetected = false
    local conns = {}
    if humanoid then
        table.insert(conns, humanoid.Died:Connect(function() resetDetected = true end))
        table.insert(conns, humanoid:GetPropertyChangedSignal("Health"):Connect(function() if humanoid.Health <= 0 then resetDetected = true end end))
    end
    if character then table.insert(conns, character.AncestryChanged:Connect(function(_, parent) if not parent then resetDetected = true end end)) end
    task.spawn(function()
        for _ = 1, 50 do
            if resetDetected then break end
            pcall(function() resetRemote:FireServer(RESET_GUID, Player, "balloon") end)
            task.wait()
        end
        for _, conn in ipairs(conns) do pcall(function() conn:Disconnect() end) end
        resetCooldown = false
    end)
end

-- ========== MEDUSA COUNTER (NRHUB) ==========
local medusaConnections = {}
local medusaState = {
    lastUsed = 0,
    debounce = false,
    counterEnabled = Values.MedusaCounterEnabled,
    autoResetEnabled = Values.MedusaAutoResetEnabled,
}

local function findMedusa()
    local char = Player.Character
    if not char then return nil end
    local tools = {"Medusa Head", "Stone Head", "Medusa"}
    local tool = char:FindFirstChild("Medusa Head")
    if tool then return tool end
    local bp = Player:FindFirstChild("Backpack")
    if bp then tool = bp:FindFirstChild("Medusa Head"); if tool then return tool end end
    return nil
end

local function useMedusaCounter()
    if medusaState.debounce then return end
    if tick() - medusaState.lastUsed < 25 then return end
    local char = Player.Character
    if not char then return end
    medusaState.debounce = true
    local med = findMedusa()
    if not med then medusaState.debounce = false; return end
    if med.Parent ~= char then 
        local hum2 = char:FindFirstChildOfClass("Humanoid")
        if hum2 then hum2:EquipTool(med) end
    end
    pcall(function() med:Activate() end)
    medusaState.lastUsed = tick()
    medusaState.debounce = false
end

local function onAnchorChanged(part)
    return part:GetPropertyChangedSignal("Anchored"):Connect(function()
        if part.Anchored and part.Transparency == 1 then
            if medusaState.autoResetEnabled then 
                instaReset() 
            end
            if medusaState.counterEnabled then 
                useMedusaCounter() 
            end
        end
    end)
end

local function setupMedusaCounter(char)
    stopMedusaCounter()
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then table.insert(medusaConnections, onAnchorChanged(part)) end
    end
    table.insert(medusaConnections, char.DescendantAdded:Connect(function(part)
        if part:IsA("BasePart") then table.insert(medusaConnections, onAnchorChanged(part)) end
    end))
end

function stopMedusaCounter()
    for _, c in pairs(medusaConnections) do pcall(function() c:Disconnect() end) end
    medusaConnections = {}
end

-- ========== BAT AIMBOT (NRHUB) ==========
local batState = {
    enabled = false,
    conn = nil,
    hittingCooldown = false,
    target = nil,
}

local function getBat()
    local char = Player.Character
    if not char then return nil end
    local bp = Player:FindFirstChild("Backpack")
    local SlapList = {"Bat","Slap","Iron Slap","Gold Slap","Diamond Slap","Emerald Slap","Ruby Slap","Dark Matter Slap","Flame Slap","Nuclear Slap","Galaxy Slap","Glitched Slap"}
    local tool = char:FindFirstChild("Bat")
    if tool then return tool end
    if bp then tool = bp:FindFirstChild("Bat"); if tool then tool.Parent = char; return tool end end
    for _, name in ipairs(SlapList) do
        local t = char:FindFirstChild(name) or (bp and bp:FindFirstChild(name))
        if t then return t end
    end
end

local function tryHitBat()
    if batState.hittingCooldown then return end
    batState.hittingCooldown = true
    local bat = getBat()
    if bat then
        pcall(function()
            bat:Activate()
            local evt = bat:FindFirstChildWhichIsA("RemoteEvent")
            if evt then evt:FireServer() end
        end)
    end
    task.delay(0.12, function() batState.hittingCooldown = false end)
end

local function getAutoBatTarget()
    local char = Player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    if batState.target and batState.target.Parent then
        local hum = batState.target.Parent:FindFirstChildOfClass("Humanoid")
        local ff = batState.target.Parent:FindFirstChildOfClass("ForceField")
        if hum and hum.Health > 0 and not ff then return batState.target end
    end
    batState.target = nil
    local closest, minDist = nil, math.huge
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= Player and plr.Character then
            local tRoot = plr.Character:FindFirstChild("HumanoidRootPart")
            if tRoot then
                local hum = tRoot.Parent:FindFirstChildOfClass("Humanoid")
                local ff = tRoot.Parent:FindFirstChildOfClass("ForceField")
                if hum and hum.Health > 0 and not ff then
                    local dist = (tRoot.Position - root.Position).Magnitude
                    if dist < minDist then minDist = dist; closest = tRoot end
                end
            end
        end
    end
    batState.target = closest
    return batState.target
end

local function startBatAimbot()
    if batState.conn then return end
    batState.enabled = true
    batState.conn = RunService.Heartbeat:Connect(function()
        if not batState.enabled then return end
        local char = Player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local target = getAutoBatTarget()
        if target and target.Parent then
            local tVel = target.AssemblyLinearVelocity
            local predict = math.clamp(tVel.Magnitude / 130, 0.05, 0.18)
            local predictedPos = target.Position + (tVel * predict)
            local forward = target.CFrame.LookVector
            local frontPos = predictedPos + forward * 4
            local dir = (frontPos - root.Position)
            if dir.Magnitude > 0.1 then
                dir = dir.Unit
                root.AssemblyLinearVelocity = Vector3.new(dir.X * 55, dir.Y * 55, dir.Z * 55)
            end
            local dist = (target.Position - root.Position).Magnitude
            if dist <= 8 then tryHitBat() end
        end
    end)
end

local function stopBatAimbot()
    batState.enabled = false
    if batState.conn then batState.conn:Disconnect(); batState.conn = nil end
    batState.target = nil
end

-- ========== AUTO GRAB PRIME ==========
local AnimalsData = nil
local plots = nil
local allAnimalsCache = {}
local PromptMemoryCache = {}
local InternalStealCache = {}
local stealConnection = nil

local StealState = {
    active = false,
    startTime = 0,
    phase = "idle",
    label = "",
}

local function setupAutograb()
    pcall(function()
        plots = workspace:WaitForChild("Plots")
        local Packages = ReplicatedStorage:WaitForChild("Packages")
        local Datas = ReplicatedStorage:WaitForChild("Datas")
        AnimalsData = require(Datas:WaitForChild("Animals"))
    end)
end

local function isMyBaseAnimal(animalData)
    if not animalData or not animalData.plot then return false end
    local plot = plots:FindFirstChild(animalData.plot)
    if not plot or not plot:FindFirstChild("Owner") then return false end
    local owner = plot.Owner
    if not owner or not owner.Value then return false end
    return owner.Value == Player.Name
end

local function findProximityPromptForAnimal(animalData)
    if not animalData then return nil end
    local cached = PromptMemoryCache[animalData.uid]
    if cached and cached.Parent then return cached end

    local plot = plots:FindFirstChild(animalData.plot)
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
            PromptMemoryCache[animalData.uid] = p
            return p
        end
    end
    return nil
end

local function getAnimalPosition(animalData)
    local plot = plots:FindFirstChild(animalData.plot)
    if not plot then return nil end
    local podiums = plot:FindFirstChild("AnimalPodiums")
    if not podiums then return nil end
    local podium = podiums:FindFirstChild(animalData.slot)
    if not podium then return nil end
    return podium:GetPivot().Position
end

local function distToAnimal(animalData)
    local character = Player.Character
    if not character then return math.huge end
    local hrp = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("UpperTorso")
    if not hrp then return math.huge end
    local pos = getAnimalPosition(animalData)
    if not pos then return math.huge end
    return (hrp.Position - pos).Magnitude
end

local function pickClosest()
    local character = Player.Character
    if not character then return nil end
    local hrp = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("UpperTorso")
    if not hrp then return nil end

    local best, bestDist = nil, math.huge
    for _, animalData in ipairs(allAnimalsCache) do
        if isMyBaseAnimal(animalData) then continue end
        local pos = getAnimalPosition(animalData)
        if not pos then continue end
        local dist = (hrp.Position - pos).Magnitude
        if dist > Values.PRIME_RANGE then continue end
        if dist < bestDist then
            bestDist = dist
            best = animalData
        end
    end
    return best
end

local function updateProgressBar(p)
    if progressFill then
        progressFill.Size = UDim2.new(p, 0, 1, 0)
    end
    if percentLabel then
        percentLabel.Text = math.floor(p * 100) .. "%"
    end
end

local function buildStealCallbacks(prompt)
    if InternalStealCache[prompt] then return end
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
        InternalStealCache[prompt] = data
    end
end

local function executeStealAsync(prompt, animalData)
    local data = InternalStealCache[prompt]
    if not data or not data.ready then return false end
    data.ready = false

    local label = animalData.name or "Animal"
    StealState.active = true
    StealState.startTime = tick()
    StealState.phase = "holding"
    StealState.label = label

    task.spawn(function()
        for _, fn in ipairs(data.holdCallbacks) do task.spawn(fn) end

        local holdStart = tick()
        while tick() - holdStart < Values.HOLD_MIN do
            local elapsed = tick() - StealState.startTime
            local p = math.clamp(elapsed / Values.HOLD_MAX, 0, 1)
            updateProgressBar(p)
            task.wait()
        end

        StealState.phase = "waitingRange"
        local alreadyInRange = distToAnimal(animalData) <= Values.STEAL_RANGE
        local fired = false

        while true do
            local elapsed = tick() - StealState.startTime
            if elapsed > Values.HOLD_MAX then break end
            if not prompt.Parent then break end
            if distToAnimal(animalData) <= Values.STEAL_RANGE then
                if not alreadyInRange then task.wait(Values.ENTRY_DELAY) end
                for _, fn in ipairs(data.triggerCallbacks) do task.spawn(fn) end
                fired = true
                break
            end
            local p = math.clamp(elapsed / Values.HOLD_MAX, 0, 1)
            updateProgressBar(p)
            task.wait()
        end

        if fired then
            StealState.active = false
            updateProgressBar(1)
            task.wait(0.3)
            updateProgressBar(0)
        else
            StealState.active = false
            updateProgressBar(0)
        end

        task.wait(Values.COOLDOWN)
        data.ready = true
    end)
    return true
end

local function attemptSteal(prompt, animalData)
    if not prompt or not prompt.Parent then return false end
    buildStealCallbacks(prompt)
    if not InternalStealCache[prompt] then return false end
    return executeStealAsync(prompt, animalData)
end

local function scanAllPlots()
    if not plots or not AnimalsData then return 0 end
    local newCache = {}
    for _, plot in ipairs(plots:GetChildren()) do
        if plot:FindFirstChild("AnimalPodiums") then
            for _, podium in ipairs(plot.AnimalPodiums:GetChildren()) do
                local base = podium:FindFirstChild("Base")
                if base and base:FindFirstChild("Spawn") then
                    table.insert(newCache, {
                        name = podium.Name or "Animal",
                        plot = plot.Name,
                        slot = podium.Name,
                        uid = plot.Name .. "_" .. podium.Name,
                    })
                end
            end
        end
    end
    allAnimalsCache = newCache
    return #allAnimalsCache
end

local function startAutoSteal()
    if stealConnection then return end
    stealConnection = RunService.Heartbeat:Connect(function()
        if not Values.AUTO_STEAL_ENABLED then return end
        if StealState.active then return end
        local target = pickClosest()
        if not target then return end
        local prompt = PromptMemoryCache[target.uid]
        if not prompt or not prompt.Parent then
            prompt = findProximityPromptForAnimal(target)
        end
        if prompt then attemptSteal(prompt, target) end
    end)
end

local function stopAutoSteal()
    if not stealConnection then return end
    stealConnection:Disconnect()
    stealConnection = nil
end

-- ========== UI MAIN PANEL ==========
local Enabled = { AutoLeft = false, AutoRight = false, AutoGrab = false, SpeedBypass = false, InstaReset = false, BatAimbot = false }
local isLocked = false
local updateButtonUI = nil
local progressFill = nil
local progressBarBg = nil
local percentLabel = nil

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NinoMegaFinal"
screenGui.ResetOnSpawn = false
pcall(function()
    if gethui then screenGui.Parent = gethui()
    elseif syn and syn.protect_gui then syn.protect_gui(screenGui) screenGui.Parent = game:GetService("CoreGui")
    else screenGui.Parent = Player:WaitForChild("PlayerGui") end
end)

local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 220, 0, 500)
panel.Position = UDim2.new(0.5, -110, 0.5, -250)
panel.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
panel.BackgroundTransparency = 0.15
panel.BorderSizePixel = 0
panel.Parent = screenGui
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 10)
local stroke = Instance.new("UIStroke", panel)
stroke.Color = Color3.fromRGB(100, 50, 150)
stroke.Thickness = 2.5

local titleBar = Instance.new("Frame", panel)
titleBar.Size = UDim2.new(1, 0, 0, 50)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 20, 40)
titleBar.BorderSizePixel = 0

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(0.7, 0, 0.5, 0)
title.BackgroundTransparency = 1
title.Text = "NINO MEGA"
title.TextColor3 = Color3.fromRGB(150, 100, 200)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Position = UDim2.new(0, 10, 0, 5)

local subtitle = Instance.new("TextLabel", titleBar)
subtitle.Size = UDim2.new(1, -20, 0, 20)
subtitle.Position = UDim2.new(0, 10, 0, 25)
subtitle.BackgroundTransparency = 1
subtitle.Text = "All-In-One Script"
subtitle.TextColor3 = Color3.fromRGB(120, 120, 130)
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 10
subtitle.TextXAlignment = Enum.TextXAlignment.Left

local lockBtn = Instance.new("TextButton", titleBar)
lockBtn.Size = UDim2.new(0, 32, 0, 32)
lockBtn.Position = UDim2.new(1, -40, 0, 9)
lockBtn.BackgroundColor3 = Color3.fromRGB(50, 30, 70)
lockBtn.Text = "🔓"
lockBtn.TextColor3 = Color3.fromRGB(200, 150, 220)
lockBtn.Font = Enum.Font.GothamBold
lockBtn.TextSize = 16
lockBtn.AutoButtonColor = false
Instance.new("UICorner", lockBtn).CornerRadius = UDim.new(0, 6)

local dragging = false
local dragStart, startPos
titleBar.InputBegan:Connect(function(input)
    if isLocked then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = panel.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not dragging or isLocked then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        panel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

lockBtn.MouseButton1Click:Connect(function()
    isLocked = not isLocked
    lockBtn.Text = isLocked and "🔒" or "🔓"
    lockBtn.BackgroundColor3 = isLocked and Color3.fromRGB(80, 50, 100) or Color3.fromRGB(50, 30, 70)
end)

local content = Instance.new("Frame", panel)
content.Size = UDim2.new(1, -16, 1, -65)
content.Position = UDim2.new(0, 8, 0, 60)
content.BackgroundTransparency = 1

-- Scroll Frame para más botones
local scrolling = Instance.new("ScrollingFrame", content)
scrolling.Size = UDim2.new(1, 0, 1, 0)
scrolling.CanvasSize = UDim2.new(0, 0, 0, 1000)
scrolling.ScrollBarThickness = 4
scrolling.BackgroundTransparency = 1

-- Speed controls
local function makeSpeedRow(y, label, key)
    local lbl = Instance.new("TextLabel", scrolling)
    lbl.Size = UDim2.new(0.5, 0, 0, 22)
    lbl.Position = UDim2.new(0, 0, 0, y)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = Color3.fromRGB(180, 180, 190)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 9
    
    local box = Instance.new("TextBox", scrolling)
    box.Size = UDim2.new(0.45, 0, 0, 22)
    box.Position = UDim2.new(0.55, 0, 0, y)
    box.BackgroundColor3 = Color3.fromRGB(35, 25, 45)
    box.Text = tostring(Values[key])
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Font = Enum.Font.GothamBold
    box.TextSize = 10
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)
    
    box.FocusLost:Connect(function()
        local n = tonumber(box.Text)
        if n then
            n = math.clamp(n, 10, 200)
            Values[key] = n
            box.Text = tostring(n)
            saveConfig()
        else
            box.Text = tostring(Values[key])
        end
    end)
end

makeSpeedRow(0, "Going Spd", "GoingSpeed")
makeSpeedRow(26, "Steal Spd", "StealSpeed")

-- Auto buttons helper
local function makeButton(y, text, key, callback, is_toggle)
    local btn = Instance.new("TextButton", scrolling)
    btn.Size = UDim2.new(1, 0, 0, 28)
    btn.Position = UDim2.new(0, 0, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(45, 30, 65)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(220, 180, 240)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Buttons section
local leftBtn = makeButton(60, "AUTO LEFT: OFF", nil, function()
    if Enabled.AutoLeft then
        stopPatrol()
        Enabled.AutoLeft = false
    else
        stopPatrol()
        Enabled.AutoRight = false
        Enabled.AutoLeft = true
        startPatrol(leftWaypoints)
    end
    updateButtonUI()
end)

local rightBtn = makeButton(92, "AUTO RIGHT: OFF", nil, function()
    if Enabled.AutoRight then
        stopPatrol()
        Enabled.AutoRight = false
    else
        stopPatrol()
        Enabled.AutoLeft = false
        Enabled.AutoRight = true
        startPatrol(rightWaypoints)
    end
    updateButtonUI()
end)

local grabBtn = makeButton(124, "AUTO GRAB: OFF", nil, function()
    if Enabled.AutoGrab then
        stopAutoSteal()
        Enabled.AutoGrab = false
    else
        setupAutograb()
        scanAllPlots()
        Values.AUTO_STEAL_ENABLED = true
        Enabled.AutoGrab = true
        startAutoSteal()
    end
    updateButtonUI()
end)

local speedBtn = makeButton(156, "SPEED BYPASS: OFF", nil, function()
    if Enabled.SpeedBypass then
        speedBypassActive = false
        Enabled.SpeedBypass = false
    else
        setupSpeedBypass()
        speedBypassActive = true
        Enabled.SpeedBypass = true
    end
    updateButtonUI()
end)

local resetBtn = makeButton(188, "INSTA RESET", nil, function()
    instaReset()
end)

local medusaCounterBtn = makeButton(220, "MEDUSA COUNTER: OFF", nil, function()
    if Enabled.MedusaCounter then
        medusaState.counterEnabled = false
        stopMedusaCounter()
        Enabled.MedusaCounter = false
    else
        medusaState.counterEnabled = true
        if Player.Character then setupMedusaCounter(Player.Character) end
        Enabled.MedusaCounter = true
    end
    updateButtonUI()
end)

local medusaResetBtn = makeButton(252, "MEDUSA AUTO RESET: OFF", nil, function()
    if Enabled.MedusaAutoReset then
        medusaState.autoResetEnabled = false
        Enabled.MedusaAutoReset = false
    else
        medusaState.autoResetEnabled = true
        if Player.Character then setupMedusaCounter(Player.Character) end
        Enabled.MedusaAutoReset = true
    end
    updateButtonUI()
end)

local batBtn = makeButton(284, "BAT AIMBOT: OFF", nil, function()
    if Enabled.BatAimbot then
        stopBatAimbot()
        Enabled.BatAimbot = false
    else
        startBatAimbot()
        Enabled.BatAimbot = true
    end
    updateButtonUI()
end)

-- Progress bar
local progressBarBg = Instance.new("Frame", scrolling)
progressBarBg.Size = UDim2.new(1, 0, 0, 16)
progressBarBg.Position = UDim2.new(0, 0, 0, 320)
progressBarBg.BackgroundColor3 = Color3.fromRGB(30, 25, 40)
progressBarBg.BorderSizePixel = 0
Instance.new("UICorner", progressBarBg).CornerRadius = UDim.new(0, 6)

progressFill = Instance.new("Frame", progressBarBg)
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = Color3.fromRGB(150, 100, 200)
progressFill.BorderSizePixel = 0
Instance.new("UICorner", progressFill).CornerRadius = UDim.new(0, 6)

percentLabel = Instance.new("TextLabel", progressBarBg)
percentLabel.Size = UDim2.new(1, 0, 1, 0)
percentLabel.BackgroundTransparency = 1
percentLabel.Font = Enum.Font.GothamBold
percentLabel.TextSize = 10
percentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
percentLabel.Text = "0%"
percentLabel.TextXAlignment = Enum.TextXAlignment.Center

local statusLabel = Instance.new("TextLabel", scrolling)
statusLabel.Size = UDim2.new(1, 0, 0, 50)
statusLabel.Position = UDim2.new(0, 0, 0, 345)
statusLabel.BackgroundColor3 = Color3.fromRGB(30, 25, 40)
statusLabel.BackgroundTransparency = 0.3
statusLabel.Text = "✓ Ready"
statusLabel.TextColor3 = Color3.fromRGB(150, 200, 150)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 11
statusLabel.TextWrapped = true
Instance.new("UICorner", statusLabel).CornerRadius = UDim.new(0, 6)

updateButtonUI = function()
    leftBtn.BackgroundColor3 = Enabled.AutoLeft and Color3.fromRGB(100, 50, 150) or Color3.fromRGB(45, 30, 65)
    leftBtn.Text = Enabled.AutoLeft and "AUTO LEFT: ON ✓" or "AUTO LEFT: OFF"
    
    rightBtn.BackgroundColor3 = Enabled.AutoRight and Color3.fromRGB(100, 50, 150) or Color3.fromRGB(45, 30, 65)
    rightBtn.Text = Enabled.AutoRight and "AUTO RIGHT: ON ✓" or "AUTO RIGHT: OFF"
    
    grabBtn.BackgroundColor3 = Enabled.AutoGrab and Color3.fromRGB(100, 50, 150) or Color3.fromRGB(45, 30, 65)
    grabBtn.Text = Enabled.AutoGrab and "AUTO GRAB: ON ✓" or "AUTO GRAB: OFF"
    
    speedBtn.BackgroundColor3 = Enabled.SpeedBypass and Color3.fromRGB(100, 50, 150) or Color3.fromRGB(45, 30, 65)
    speedBtn.Text = Enabled.SpeedBypass and "SPEED BYPASS: ON ✓" or "SPEED BYPASS: OFF"
    
    medusaCounterBtn.BackgroundColor3 = (Enabled.MedusaCounter or Enabled.MedusaAutoReset) and Color3.fromRGB(100, 50, 150) or Color3.fromRGB(45, 30, 65)
    medusaCounterBtn.Text = (Enabled.MedusaCounter or Enabled.MedusaAutoReset) and "MEDUSA: ON ✓" or "MEDUSA: OFF"
    
    batBtn.BackgroundColor3 = Enabled.BatAimbot and Color3.fromRGB(100, 50, 150) or Color3.fromRGB(45, 30, 65)
    batBtn.Text = Enabled.BatAimbot and "BAT AIMBOT: ON ✓" or "BAT AIMBOT: OFF"
end

updateButtonUI()

-- ========== HOTKEYS ==========
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.R then
        if Enabled.InstaReset == false then
            instaReset()
        end
    elseif input.KeyCode == Enum.KeyCode.L then
        if Enabled.AutoLeft then
            stopPatrol()
            Enabled.AutoLeft = false
        else
            stopPatrol()
            Enabled.AutoRight = false
            Enabled.AutoLeft = true
            startPatrol(leftWaypoints)
        end
        updateButtonUI()
    elseif input.KeyCode == Enum.KeyCode.K then
        if Enabled.AutoRight then
            stopPatrol()
            Enabled.AutoRight = false
        else
            stopPatrol()
            Enabled.AutoLeft = false
            Enabled.AutoRight = true
            startPatrol(rightWaypoints)
        end
        updateButtonUI()
    end
end)

-- ========== AUTO-ANTI DROP ==========
RunService.Stepped:Connect(function()
    local c = Player.Character
    if c then
        local hrp = c:FindFirstChild("HumanoidRootPart")
        if hrp and hrp.Position.Y < -10 then
            hrp.Position = Vector3.new(hrp.Position.X, -6.5, hrp.Position.Z)
        end
    end
end)

-- ========== CHARACTER RESPAWN HANDLING ==========
Player.CharacterAdded:Connect(function(char)
    task.wait(0.8)
    if Enabled.AutoLeft then
        stopPatrol()
        startPatrol(leftWaypoints)
    elseif Enabled.AutoRight then
        stopPatrol()
        startPatrol(rightWaypoints)
    end
    if Enabled.MedusaCounter or Enabled.MedusaAutoReset then
        setupMedusaCounter(char)
    end
end)

print("✅ NINO MEGA FINAL Script Loaded Successfully!")
print("   Features: ATR Autoplay + AutoGrab Prime + Speed Bypass +")
print("   Instant Reset + Medusa Counter + Bat Aimbot + More!")
print("")
print("Hotkeys:")
print("   L = Auto Left")
print("   K = Auto Right") 
print("   R = Instant Reset")
print("")
print("✓ All features integrated and ready to use!")
