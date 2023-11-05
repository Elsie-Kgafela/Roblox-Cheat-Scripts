--[[
Game : https://www.roblox.com/games/5490351219
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats : https://discord.gg/MhMB3c2CBn
GUI Made by : xTheAlex14 : https://teppyboy.github.io/Mirrors/Documentations/Zypher_UI/zypher.wtf/docs/uilibdocs.html
]]--
---- vars ----
kVars = {}
kVars.WindowName = "Clicker Madness GUI"
kVars.placeID = 5490351219
kVars.players = game:GetService('Players')
kVars.lp = kVars.players.LocalPlayer
kVars.vu = game:GetService('VirtualUser')
kVars.uis = game:GetService('UserInputService')
kVars.rs = game:GetService('ReplicatedStorage')
kVars.char = kVars.lp.Character or kVars.lp.CharacterAdded:Wait()
kVars.humanoid = kVars.char:WaitForChild('Humanoid')
kVars.hrp = kVars.char:WaitForChild('HumanoidRootPart')
kVars.pGui = kVars.lp:WaitForChild("PlayerGui")
kVars.Http = game:GetService("HttpService")
kVars.connect = {}
kVars.bool = {}
kVars.str = {}
kVars.num = {}

---- check for correct game ----
if kVars.placeID ~= game.PlaceId then 
    warn("#### - This Script is not for this game. - ####")
    script:Destroy()
    return 
end

---- destroy old gui if exists ----
if game:GetService("CoreGui"):FindFirstChild(kVars.WindowName) then
    game:GetService("CoreGui"):FindFirstChild(kVars.WindowName):Destroy()
    wait(2)
end

---- antiAFK ----
kVars.connect.antiAFK = game:GetService('Players').LocalPlayer.Idled:connect(function()
    kVars.vu:CaptureController()
    kVars.vu:ClickButton2(Vector2.new())
 end)

---- gui build ----
kVars.GUI = {}
kVars.GUI.page = {}
kVars.GUI.section = {}
kVars.GUI.library = loadstring(game:HttpGet("https://raw.githubusercontent.com/teppyboy/RbxScripts/master/Misc/UI_Libraries/Zypher/Library.lua"))()
kVars.GUI.window = kVars.GUI.library:CreateMain({
    projName = kVars.WindowName,
    Resizable = true,
    MinSize = UDim2.new(0,400,0,400),
    MaxSize = UDim2.new(0,750,0,500),
})

kVars.GUI.page.main = kVars.GUI.window:CreateCategory("Main")
kVars.GUI.section.farm = kVars.GUI.page.main:CreateSection("Farm")

kVars.GUI.page.eggsPets = kVars.GUI.window:CreateCategory("Eggs/Pets")
kVars.GUI.section.eggs = kVars.GUI.page.eggsPets:CreateSection("Eggs")
kVars.GUI.section.pets = kVars.GUI.page.eggsPets:CreateSection("Pets")
kVars.GUI.section.deletePets = kVars.GUI.page.eggsPets:CreateSection("Delete Pets")

kVars.GUI.page.teleport = kVars.GUI.window:CreateCategory("Teleport")
kVars.GUI.section.tpToPlayer = kVars.GUI.page.teleport:CreateSection("Teleport To Player")
kVars.GUI.section.tpToLocations = kVars.GUI.page.teleport:CreateSection("Teleport To Locations")

kVars.GUI.page.character = kVars.GUI.window:CreateCategory("Character")
kVars.GUI.section.character = kVars.GUI.page.character:CreateSection("Options")

kVars.GUI.page.misc = kVars.GUI.window:CreateCategory("Misc")
kVars.GUI.section.keybinds = kVars.GUI.page.misc:CreateSection("KeyBinds")
kVars.GUI.section.world = kVars.GUI.page.misc:CreateSection("World Options")
kVars.GUI.section.options = kVars.GUI.page.misc:CreateSection("Options")
kVars.GUI.section.esp = kVars.GUI.page.misc:CreateSection("ESP")

kVars.GUI.page.credits = kVars.GUI.window:CreateCategory("Credits")
kVars.GUI.section.keath = kVars.GUI.page.credits:CreateSection("Coded by : Keathunsar")
kVars.GUI.section.alex = kVars.GUI.page.credits:CreateSection("UI-Lib by : xTheAlex14")

----========== page main ==========----
---- Farm ----
kVars.GUI.section.farm:Create("Toggle", "Click",function(bool)
    kVars.boolClick = bool
    if bool then
        fClick()
    end
end,{default = kVars.boolClick})

function fClick()
    spawn(function()
        while kVars.boolClick do
            task.wait()
            firesignal(kVars.pGui.Click.Button.MouseButton1Down)
        end
    end)
end

kVars.GUI.section.farm:Create("Toggle", "Collect",function(bool)
    kVars.boolCollect = bool
    if bool then
        fCollect()
    end
end,{default = kVars.boolCollect})

function fCollect()
    spawn(function()
        while kVars.boolCollect do
            wait()
            for i,v in pairs(game:GetService("Workspace").ScriptObjects:GetChildren()) do
                if v:FindFirstChild("HumanoidRootPart") then
                    firetouchinterest(kVars.hrp, v.HumanoidRootPart, 0)
                end
            end
        end
    end)
end

kVars.GUI.section.farm:Create("Button", "Unlock Auto Rebirth", function()
    kVars.lp.Gamepasses.AutoRebirth.Value = true
end,{animated = true})


----========== page Eggs/Pets ==========----
---- section Eggs ----
kVars.eggsList = {}
for i,v in pairs(game:GetService("Workspace").EggCapsules:GetChildren()) do
    table.insert(kVars.eggsList, tostring(v.EggID.Value))
end
table.sort(kVars.eggsList)

kVars.selectedEgg = kVars.eggsList[1]
kVars.GUI.section.eggs:Create("DropDown", "Select and egg to open", function(value)
    kVars.selectedEgg = value
end,{options = kVars.eggsList, default = kVars.eggsList[1], search = true})

kVars.GUI.section.eggs:Create("Toggle", "Open",function(bool)
    kVars.boolOpenEgg = bool
    if bool then
        fOpenEgg()
    end
end,{default = kVars.boolOpenEgg})

function fOpenEgg()
    spawn(function()
        while kVars.boolOpenEgg do
            wait()
            kVars.rs.Aero.AeroRemoteServices.EggService.Purchase:FireServer(kVars.selectedEgg)
        end
    end)
end

---- section Pets ----
kVars.GUI.section.pets:Create("Button", "Equip Best", function()
    local pets = HttpService:JSONDecode(game.Players.LocalPlayer.Data.Pets.Value)
    for i,v in pairs(pets) do -- unequip all pets
        if v.Equipped then
            game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.PetService.UnequipPet:FireServer(i)
        end
    end
    
    
end,{animated = true})


kVars.GUI.section.pets:Create("Toggle", "Craft",function(bool)
    kVars.boolCraft = bool
    if bool then
        fCraft()
    end
end,{default = kVars.boolCraft})

function fCraft()
    spawn(function()
        while kVars.boolCraft do
            wait()
            for i,v in pairs(kVars.lp.PlayerGui.Pets.Main.Content.Main:GetChildren()) do
                wait()
                if kVars.boolCraft == false then break end
                pcall(function()
                    if v:FindFirstChild("Craft") then
                        firesignal(v:FindFirstChild("Craft").MouseButton1Down)
                    end
                end)
            end
        end
    end)
end



kVars.petsList = require(game.ReplicatedStorage.Aero.Shared.List.Pets)
kVars.petsNamesList = {}
for i,v in pairs(kVars.petsList) do
    if not table.find(kVars.petsList,v.DisplayName) then
        table.insert(kVars.petsNamesList, tostring(v.DisplayName))
    end    
end
table.sort(kVars.petsNamesList)
table.insert(kVars.petsNamesList, 1, "NONE")


for i=1,5 do
    kVars["selectedPet" .. i] = kVars.petsNamesList[1]
    kVars.GUI.section.deletePets:Create("DropDown", "Select a pet", function(value)
        kVars["selectedPet" .. i] = value
    end,{options = kVars.petsNamesList, default = kVars.petsNamesList[1], search = true})
    
end

kVars.GUI.section.deletePets:Create("Toggle", "Delete pet by name *Carful",function(bool)
    kVars.bool.delPet = bool
    if bool then
        fDelPet()
    end
end,{default = kVars.bool.delPet})

function fDelPet()
    spawn(function()
        while kVars.bool.delPet do
            wait()
            local plrPets = game:GetService("HttpService"):JSONDecode(kVars.lp.Data.Pets.Value)
            local delPetsList = {}
            for a=1,5 do
                local b = kVars["selectedPet" .. a]
                for i,v in pairs(plrPets) do
                    if string.find(string.lower(v.ID), string.lower(b)) then
                        table.insert(delPetsList, i)
                    end
                end                
            end
            if delPetsList[1] then
                kVars.rs.Aero.AeroRemoteServices.PetService.DeletePets:FireServer(delPetsList)
            end
        end
    end)
end


----========== page teleport ==========----
---- section teleport to player ----
kVars.SelectedTPToPlayer = kVars.lp.name
kVars.GUI.section.tpToPlayer:Create("TextBox", "Enter Users Name", function(value)
    kVars.SelectedTPToPlayer = value
end,{text = "Enter Users Name"})

kVars.GUI.section.tpToPlayer:Create("Button", "Teleport To Player", function()
    for i,v in pairs(game.Players:GetPlayers()) do
        if kVars.SelectedTPToPlayer ~= nil and kVars.SelectedTPToPlayer ~= kVars.lp.name then
            if string.lower(v.DisplayName) == string.lower(kVars.SelectedTPToPlayer) then
                kVars.hrp.CFrame = v.Character.HumanoidRootPart.CFrame                
            end
        end
    end
end,{animated = true})

kVars.GUI.section.tpToLocations:Create("Button", "Spawn", function()
    local v = game:GetService("Workspace").SpawnLocation
    kVars.char:SetPrimaryPartCFrame(CFrame.new(v.CFrame.x, (v.CFrame.y + 3), v.CFrame.z))
end,{animated = true})

kVars.WorldsOrder = {"Lava", "Desert", "Ocean", "Winter", "Toxic", "Candy", "Forest", "Storm", "Blocks", "Space", "Dominus", "Infinity", "Future", "City", "Moon", "Fire"}
for i,v in pairs(kVars.WorldsOrder) do
    if game:GetService("Workspace").Worlds:FindFirstChild(v) then
        if game:GetService("Workspace").Worlds[v]:FindFirstChild("Teleport") then
            local temp = game:GetService("Workspace").Worlds[v].Teleport
            kVars.GUI.section.tpToLocations:Create("Button", v, function()
                kVars.char:SetPrimaryPartCFrame(CFrame.new(temp.CFrame.x, temp.CFrame.y, temp.CFrame.z))
            end,{animated = true})
        end
    end
end


----========== page character ==========----
---- section Character ----
kVars.num.walkSpeed = kVars.humanoid.WalkSpeed
kVars.GUI.section.character:Create("Slider", "Walk Speed", function(value)
    kVars.num.walkSpeed = value
    kVars.humanoid.WalkSpeed = value
end,{min = 16, max = 500, default = kVars.num.walkSpeed, precise = false, changablevalue = true})

kVars.num.jumpPower = kVars.humanoid.JumpPower
kVars.GUI.section.character:Create("Slider", "Jump Power", function(value)
    kVars.num.jumpPower = value
    kVars.humanoid.JumpPower = value
end,{min = 7.2, max = 500, default = kVars.num.jumpPower, precise = true, changablevalue = true})

kVars.num.jumpHeight = kVars.humanoid.JumpHeight
kVars.GUI.section.character:Create("Slider", "Jump Height", function(value)
    kVars.num.jumpHeight = value
    kVars.humanoid.JumpHeight = value
end,{min = 7.2, max = 500, default = kVars.num.jumpHeight, precise = true, changablevalue = true})


kVars.connect.CharacterAdded = game.Players.LocalPlayer.CharacterAdded:Connect(function(child)
    kVars.humanoid = kVars.lp.Character:WaitForChild('Humanoid', 999999)
    kVars.hrp = kVars.lp.Character:WaitForChild('HumanoidRootPart', 999999)
    task.wait(1)
    kVars.humanoid.WalkSpeed = kVars.num.walkSpeed
    kVars.humanoid.JumpHeight = kVars.num.jumpHeight
    kVars.humanoid.JumpPower = kVars.num.jumpPower
end)

kVars.bool.infJump = false
kVars.GUI.section.character:Create("Toggle", "Inf Jump",function(bool)
    kVars.bool.infJump = bool
end,{default = kVars.bool.infJump})

kVars.connect.jumpRequest = game:GetService("UserInputService").JumpRequest:Connect(function()
	if kVars.bool.infJump then
		kVars.humanoid:ChangeState("Jumping")
	end
end)

----========== page misc ==========----
---- section keybinds ----
kVars.OpenCloseMenuKey = Enum.KeyCode.F5
kVars.GUI.section.keybinds:Create("KeyBind", "Open Close Menu", function(key)
    kVars.OpenCloseMenuKey = key
end,{default = kVars.OpenCloseMenuKey})


kVars.connect.inputBegan = kVars.uis.InputBegan:Connect(function(key)
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
    kVars.bool.fog = true
else
    kVars.bool.fog = false
end
kVars.GUI.section.world:Create("Toggle", "Fog",function(bool)
    kVars.bool.fog = bool
    if bool then
        game.Lighting.FogStart = 0
    else
        game.Lighting.FogStart = math.huge
    end
end,{default = kVars.bool.fog})

---- sections options ----
kVars.bool.popEffect = kVars.pGui.PopupEffects.Enabled
kVars.GUI.section.options:Create("Toggle", "Disable Popup Effects",function(bool)
    kVars.bool.popEffect = bool
    kVars.pGui.PopupEffects.Enabled = bool
end,{default = kVars.bool.popEffect})

kVars.GUI.section.options:Create("Button", "Destroy this GUI",function()
    game:GetService("CoreGui"):FindFirstChild(kVars.WindowName):Destroy()
end,{animated = true})

kVars.GUI.section.options:Create("Toggle", "Purchase Prompt",function(bool)
    game:GetService("CoreGui").PurchasePrompt.Enabled = bool
end,{default = game:GetService("CoreGui").PurchasePrompt.Enabled})

---- section ESP ----
local sides = {Enum.NormalId.Top, Enum.NormalId.Bottom, Enum.NormalId.Left, Enum.NormalId.Right, Enum.NormalId.Front, Enum.NormalId.Back}

function EspChar()
    --pcall(function()
        local players = game:GetService("Players")
        for i,v in pairs(players:GetChildren()) do
            local char = v.Character or v.CharacterAdded:Wait()
            if v.Name ~= game.Players.LocalPlayer.Name then
                for _,a in pairs(char:GetChildren()) do
                    if not a:FindFirstChild("ESP") then
                        if a.ClassName == "MeshPart" or a.ClassName == "Part" then
                            for _,y in pairs(sides) do
                                local sg = Instance.new("SurfaceGui")
                                sg.Name = "ESP"
                                sg.Face = y
                                sg.Adornee = a
                                sg.Parent = a
                                sg.AlwaysOnTop = true
                                sg.MaxDistance = math.huge
                                sg.LightInfluence = 0
                                sg.Brightness = 1000
                                sg.ZOffset = 1
                                local fr = Instance.new("Frame")
                                fr.Name = "ESP"
                                fr.Parent = sg
                                fr.Size = UDim2.new(1,0,1,0)
                                fr.BackgroundColor3 = Color3.new(0, 1, 0)
                                fr.Transparency = 0.3
                            end
                        end
                    end
                end
            end
        end
    --end)
end

local function EspCharOFF()
    --pcall(function()
        for a,b in pairs(kVars.players:GetChildren()) do
            local char = b.Character or b.CharacterAdded:Wait()
            for c,d in pairs(char:GetChildren()) do
                for e,f in pairs(d:GetChildren()) do
                    if f.Name == "ESP" then
                        f:Destroy()
                    end
                end
            end
        end
    --end)
end

local function espChams()
    kVars.connect.playerAdded = kVars.players.PlayerAdded:Connect(function(player) ---- player joins game
        kVars.connect.characterAdded2 = player.CharacterAdded:Connect(function(char) ---- Character is added to workspace
            if player.Name ~= kVars.lp.Name then
                repeat
                    task.wait(.2)
                until player.Character and player.Character.Humanoid and player.Character.HumanoidRootPart
                task.wait(1)
                EspChar()
            end
        end)  
    end)
end

kVars.GUI.section.esp:Create("Toggle", "Player ESP Chams",function(bool)
    if bool then
        espChams()
        EspChar()
    elseif not bool then
        kVars.connect.playerAdded:Disconnect()
        EspCharOFF()
    end
end,{default = false})

kVars.Esp = {}
kVars.bool.Esp = false
kVars.GUI.section.esp:Create("Toggle", "Player ESP name/box",function(bool)
    kVars.bool.Esp = bool
    if not bool then
        for i,v in pairs(kVars.players:GetChildren()) do
            if kVars.Esp[v.Name] then
                wait()
                kVars.Esp[v.Name].txt.Visible = false   
            end
        end    
    else
        fEsp()
    end
end,{default = kVars.bool.Esp})

kVars.connect.playerRemoving = kVars.players.PlayerRemoving:Connect(function(p)
    if kVars.Esp[p.Name] then
        wait()
        kVars.Esp[p.Name].txt.Visible = false
        table.remove(kVars.Esp[p.Name])
    end
end)

function mean(t)
    local add = 0
    for i,v in pairs(t) do
        add = add + v
    end
    return add / #t
end

function fEsp()
    spawn(function()
        local cam = game:GetService("Workspace").CurrentCamera
        while kVars.bool.Esp do
            task.wait()
            pcall(function()
                for i,v in pairs(kVars.players:GetChildren()) do
                    if not kVars.bool.Esp then break end
                    task.wait()
                    local char = v.Character or v.CharacterAdded:Wait()
                    local charHead = char:WaitForChild("Head")
                    local charHrp = char:WaitForChild("HumanoidRootPart")
                    if char and charHead then
                        if v.Name ~= kVars.lp.Name then
                            if not kVars.Esp[v.Name] then
                                kVars.Esp[v.Name] = {}
                                kVars.Esp[v.Name].txt = Drawing.new("Text")
                                kVars.Esp[v.Name].txt.Visible = false
                                kVars.Esp[v.Name].txt.Size = 16
                                kVars.Esp[v.Name].txt.Color = Color3.fromRGB(0, 255, 60)
                                kVars.Esp[v.Name].txt.Transparency = 1
                                kVars.Esp[v.Name].txt.ZIndex = 1
                                kVars.Esp[v.Name].txt.Center = true
                                kVars.Esp[v.Name].txt.Font = 3
                                kVars.Esp[v.Name].txt.Outline = true
                                kVars.Esp[v.Name].txt.OutlineColor = Color3.fromRGB(0, 0, 0)
                                kVars.Esp[v.Name].txt.Text = v.Name
                            end
                            local vector1, onScreen1 = cam:WorldToViewportPoint(charHead.Position)

                            if onScreen1 then
                                local screenPosHead, onscreenPosHead = cam:WorldToViewportPoint(charHead.Position)
                                local screenPosHrp, onscreenPosHrp = cam:WorldToViewportPoint(charHrp.Position)
                                local diffScreen = (screenPosHead - screenPosHrp).Magnitude
                                kVars.Esp[v.Name].txt.Visible = true
                                kVars.Esp[v.Name].txt.Position = Vector2.new((screenPosHead.x), (screenPosHead.y - diffScreen))
                            else
                                kVars.Esp[v.Name].txt.Visible = false
            
                            end
                            
                        end
                    end
                end
            end)
            
        end
    end)
end


----========== page credits ==========----
---- keaths ----
kVars.GUI.section.keath:Create("Button", "https://github.com/dady172172/Roblox-Cheats", function()
    setclipboard('https://github.com/dady172172/Roblox-Cheats')
end,{animated = true})

kVars.GUI.section.keath:Create("Button", "https://discord.gg/MhMB3c2CBn", function()
    setclipboard('https://discord.gg/MhMB3c2CBn')
end,{animated = true})

---- alex ----
kVars.GUI.section.alex:Create("Button", "https://teppyboy.github.io/", function()
    setclipboard('https://teppyboy.github.io/Mirrors/Documentations/Zypher_UI/zypher.wtf/docs/main.html')
end,{animated = true})

----========== set window size after load ==========----
kVars.MotherFrame = game:GetService("CoreGui"):FindFirstChild(kVars.WindowName):WaitForChild("Motherframe")
kVars.MotherFrame.Size = UDim2.new(0, 495, 0, 400)
kVars.screenSize = game:GetService("Workspace"):WaitForChild("Camera").ViewportSize
kVars.MotherFrame.Position = UDim2.new(0, (kVars.screenSize.X / 2) - (kVars.MotherFrame.Size.X.Offset / 2), 0, (kVars.screenSize.Y / 2) - (kVars.MotherFrame.Size.Y.Offset / 2))

----========== delete script if re-injecting ==========----

kVars.cR = game:GetService("CoreGui").ChildRemoved:Connect(function(child)
    if child.name == kVars.WindowName then
        for i,v in pairs(kVars.bool) do
            v = false
        end
        for i,v in pairs(kVars) do
            if type(v) == "boolean" then
                kVars[i] = false
            end
        end
        for i,v in pairs(kVars.connect) do
            v:Disconnect()
        end
        wait(1)
        script:Destroy()
        kVars.cR:Disconnect()
    end
end)