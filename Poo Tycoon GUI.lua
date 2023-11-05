--[[
Game : https://www.roblox.com/games/9969599224
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
GUI Made by : xTheAlex14 : https://teppyboy.github.io/Mirrors/Documentations/Zypher_UI/zypher.wtf/docs/uilibdocs.html
]]--
---- vars ----
kVars = {}
kVars.WindowName = "Poo Tycoon GUI"
kVars.lp = game:GetService('Players').LocalPlayer
kVars.vu = game:GetService('VirtualUser')
kVars.uis = game:GetService('UserInputService')
kVars.rs = game:GetService('ReplicatedStorage')
kVars.humanoid = kVars.lp.Character:WaitForChild('Humanoid')
kVars.hrp = kVars.lp.Character:WaitForChild('HumanoidRootPart')

---- destroy old gui if exists ----
if game:GetService("CoreGui"):FindFirstChild(kVars.WindowName) then
    game:GetService("CoreGui"):FindFirstChild(kVars.WindowName):Destroy()
    wait(2)
end

---- antiAFK ----
kVars.connectAntiAfk = game:GetService('Players').LocalPlayer.Idled:connect(function()
    kVars.vu:CaptureController()
    kVars.vu:ClickButton2(Vector2.new())
 end)

---- gui build ----
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/teppyboy/RbxScripts/master/Misc/UI_Libraries/Zypher/Library.lua"))()
local Window = library:CreateMain({
    projName = kVars.WindowName,
    Resizable = true,
    MinSize = UDim2.new(0,300,0,300),
    MaxSize = UDim2.new(0,800,0,800),
})

local pageMain = Window:CreateCategory("Main")
local sectionFarm = pageMain:CreateSection("Farm")

local pageTeleport = Window:CreateCategory("Teleport")
local sectionTPToPlayer = pageTeleport:CreateSection("Teleport To Player")

local pageCharacter = Window:CreateCategory("Character")
local sectionCharacter = pageCharacter:CreateSection("Options")

local pageMisc = Window:CreateCategory("Misc")
local sectionKeybinds = pageMisc:CreateSection("KeyBinds")
local sectionWorld = pageMisc:CreateSection("World Options")
local sectionMisc = pageMisc:CreateSection("Options")

local pageCredits = Window:CreateCategory("Credits")
local sectionCreditsKeath = pageCredits:CreateSection("Coded by : Keathunsar")
local sectionCreditsAlex = pageCredits:CreateSection("UI-Lib by : xTheAlex14")

----========== page main ==========----
---- Farm ----
kVars.boolMoney = false
sectionFarm:Create("Toggle", "Collect Money",function(bool)
    kVars.boolMoney = bool
    if bool then
        fMoney()
    end
end,{default = kVars.boolMoney})

function fMoney()
    spawn(function()
        while kVars.boolMoney do
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, game:GetService("Workspace")["keathunsar's Tycoon"].Bank.Pad, 0)
            wait()
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, game:GetService("Workspace")["keathunsar's Tycoon"].Bank.Pad, 1)
        end
    end)
end

kVars.boolBuyButtons = false
sectionFarm:Create("Toggle", "Buy all buttons",function(bool)
    kVars.boolBuyButtons = bool
    if bool then
        fBuyButtons()
    end
end,{default = kVars.boolBuyButtons})

function fBuyButtons()
    spawn(function()
        while kVars.boolBuyButtons do
            wait()
            for i,v in pairs(game:GetService("Workspace")[game.Players.LocalPlayer.name .. "'s Tycoon"]:GetChildren()) do
                if kVars.boolBuyButtons == false then return end
                if v:FindFirstChild("TouchInterest") then
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
                    wait()
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)
                end
            end
        end
    end)
end

kVars.boolTPToBoxes = false
sectionFarm:Create("Toggle", "TP to boxes",function(bool)
    kVars.boolTPToBoxes = bool
    if bool then
        fTPToBoxes()
    end
end,{default = kVars.boolTPToBoxes})

function fTPToBoxes()
    spawn(function()
        while kVars.boolTPToBoxes do
            wait()
            pcall(function()
                for i,v in pairs(game:GetService("Workspace").BoxDump:GetChildren()) do
                    if kVars.boolTPToBoxes == false then return end
                    if (v.Position - kVars.hrp.Position).magnitude > 4 then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                        wait(.3)
                        fireproximityprompt(v.ProximityPrompt, 2)
                    end
                end
            end)
        end
    end)
end

sectionFarm:Create("Button", "Collect all hidden Poo's", function()
    for i,v in pairs(game:GetService("Workspace").FindThePoop:GetChildren()) do
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
        wait()
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)
    end
end,{animated = true})


----========== page teleport ==========----
---- section teleport to player ----
kVars.SelectedTPToPlayer = kVars.lp.name
sectionTPToPlayer:Create("TextBox", "Enter Users Name", function(value)
    kVars.SelectedTPToPlayer = value
end,{text = "Enter Users Name"})

sectionTPToPlayer:Create("Button", "Teleport To Player", function()
    for i,v in pairs(game.Players:GetPlayers()) do
        if kVars.SelectedTPToPlayer ~= nil and kVars.SelectedTPToPlayer ~= kVars.lp.name then
            if string.lower(v.DisplayName) == string.lower(kVars.SelectedTPToPlayer) then
                kVars.hrp.CFrame = v.Character.HumanoidRootPart.CFrame                
            end
        end
    end
end,{animated = true})


----========== page character ==========----
---- section Character ----
kVars.walkSpeed = kVars.humanoid.WalkSpeed
sectionCharacter:Create("Slider", "Walk Speed", function(value)
    kVars.walkSpeed = value
    kVars.humanoid.WalkSpeed = value
end,{min = 16, max = 500, default = kVars.humanoid.walkSpeed, precise = false, changablevalue = true})

kVars.jumpHeight = kVars.humanoid.JumpHeight
sectionCharacter:Create("Slider", "Jump Height", function(value)
    kVars.jumpHeight = value
    kVars.humanoid.JumpHeight = value
end,{min = 7.2, max = 500, default = kVars.humanoid.jumpHeight, precise = true, changablevalue = true})


kVars.plrAdded = game.Players.LocalPlayer.CharacterAdded:Connect(function(child)
    kVars.humanoid = kVars.lp.Character:WaitForChild('Humanoid', 999999)
    kVars.hrp = kVars.lp.Character:WaitForChild('HumanoidRootPart', 999999)
    task.wait(1)
    kVars.humanoid.WalkSpeed = kVars.walkSpeed
    kVars.humanoid.JumpHeight = kVars.jumpHeight
end)

kVars.boolInfJump = false
sectionCharacter:Create("Toggle", "Inf Jump",function(bool)
    kVars.boolInfJump = bool
end,{default = kVars.boolInfJump})

kVars.connectJumpRequest = game:GetService("UserInputService").JumpRequest:Connect(function()
	if kVars.boolInfJump then
		kVars.humanoid:ChangeState("Jumping")
	end
end)

----========== page misc ==========----
---- section keybinds ----
kVars.OpenCloseMenuKey = Enum.KeyCode.F5
sectionKeybinds:Create("KeyBind", "Open Close Menu", function(key)
    kVars.OpenCloseMenuKey = key
end,{default = kVars.OpenCloseMenuKey})


kVars.connectInputBegan = kVars.uis.InputBegan:Connect(function(key)
    if key.UserInputType == Enum.UserInputType.Keyboard and key.KeyCode == kVars.OpenCloseMenuKey then
        if game:GetService("CoreGui"):FindFirstChild(kVars.WindowName).Enabled then
            game:GetService("CoreGui"):FindFirstChild(kVars.WindowName).Enabled = false
        else
            game:GetService("CoreGui"):FindFirstChild(kVars.WindowName).Enabled = true
        end
    end
end)

---- section world ----

if game.Lighting.FogStart < 100 then
    kVars.boolFog = true
else
    kVars.boolFog = false
end
sectionWorld:Create("Toggle", "Fog",function(bool)
    kVars.boolFog = bool
    if bool then
        game.Lighting.FogStart = 0
    else
        game.Lighting.FogStart = math.huge
    end
end,{default = kVars.boolFog})

sectionWorld:Create("Toggle", "Blur",function(bool)
    game:GetService("Lighting").Blur.Enabled = bool
end,{default = game:GetService("Lighting").Blur.Enabled})

---- sections options ----
sectionMisc:Create("Toggle", "Purchase Prompt",function(bool)
    game:GetService("CoreGui").PurchasePrompt.Enabled = bool
end,{default = game:GetService("CoreGui").PurchasePrompt.Enabled})

----========== page credits ==========----
---- keaths ----
sectionCreditsKeath:Create("Button", "https://github.com/dady172172/Roblox-Cheats", function()
    setclipboard('https://github.com/dady172172/Roblox-Cheats')
end,{animated = true})

sectionCreditsKeath:Create("Button", "https://discord.gg/MhMB3c2CBn", function()
    setclipboard('https://discord.gg/MhMB3c2CBn')
end,{animated = true})

---- alex ----
sectionCreditsAlex:Create("Button", "https://teppyboy.github.io/", function()
    setclipboard('https://teppyboy.github.io/Mirrors/Documentations/Zypher_UI/zypher.wtf/docs/main.html')
end,{animated = true})

----========== delete script if re-injecting ==========----

kVars.cR = game:GetService("CoreGui").ChildRemoved:Connect(function(child)
    if child.name == kVars.WindowName then
        for i,v in pairs(kVars) do
            if type(v) == "boolean" then
                kVars[i] = false
            end
        end
        kVars.connectAntiAfk:Disconnect()
        kVars.connectInputBegan:Disconnect()
        kVars.connectJumpRequest:Disconnect()
        kVars.plrAdded:Disconnect()
        wait(1)
        script:Destroy()
        kVars.cR:Disconnect()
    end
end)

game:GetService("CoreGui")[kVars.WindowName].Motherframe.Size = UDim2.new(0,480,0,340)

