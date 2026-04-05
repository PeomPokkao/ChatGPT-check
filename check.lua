_G.AUTOFARM = serthfstgh

    getgenv().ToTargets = function(p)
        task.spawn(function()
            pcall(function()
                if game:GetService("Players").LocalPlayer:DistanceFromCharacter(p.Position) <= 250 then 
                    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = p
                elseif not game.Players.LocalPlayer.Character:FindFirstChild("Root")then 
                    local K = Instance.new("Part",game.Players.LocalPlayer.Character)
                    K.Size = Vector3.new(1,0.5,1)
                    K.Name = "Root"
                    K.Anchored = true
                    K.Transparency = 1
                    K.CanCollide = false
                    K.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,20,0)
                end
                local U = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-p.Position).Magnitude
                local z = game:service("TweenService")
                local B = TweenInfo.new((p.Position-game.Players.LocalPlayer.Character.Root.Position).Magnitude/300,Enum.EasingStyle.Linear)
                local S,g = pcall(function()
                local q = z:Create(game.Players.LocalPlayer.Character.Root,B,{CFrame = p})
                q:Play()
            end)
            if not S then 
                return g
            end
            game.Players.LocalPlayer.Character.Root.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                if S and game.Players.LocalPlayer.Character:FindFirstChild("Root") then 
                    pcall(function()
                        if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-p.Position).Magnitude >= 20 then 
                            spawn(function()
                                pcall(function()
                                    if (game.Players.LocalPlayer.Character.Root.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 150 then 
                                        game.Players.LocalPlayer.Character.Root.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                    else 
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players.LocalPlayer.Character.Root.CFrame
                                    end
                                end)
                            end)
                        elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-p.Position).Magnitude >= 10 and(game.Players.LocalPlayer.Character.HumanoidRootPart.Position-p.Position).Magnitude < 20 then 
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p
                        elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-p.Position).Magnitude < 10 then 
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p
                        end
                    end)
                end
            end)
        end)
    end

    function Hop()
        local PlaceID = game.PlaceId
        local AllIDs = {}
        local foundAnything = ""
        local actualHour = os.date("!*t").hour
        local Deleted = false
        function TPReturner()
            local Site;
            if foundAnything == "" then
                Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
            else
                Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
            end
            local ID = ""
            if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
                foundAnything = Site.nextPageCursor
            end
            local num = 0;
            for i,v in pairs(Site.data) do
                local Possible = true
                ID = tostring(v.id)
                if tonumber(v.maxPlayers) > tonumber(v.playing) then
                    for _,Existing in pairs(AllIDs) do
                        if num ~= 0 then
                            if ID == tostring(Existing) then
                                Possible = false
                            end
                        else
                            if tonumber(actualHour) ~= tonumber(Existing) then
                                local delFile = pcall(function()
                                    AllIDs = {}
                                    table.insert(AllIDs, actualHour)
                                end)
                            end
                        end
                        num = num + 1
                    end
                    if Possible == true then
                        table.insert(AllIDs, ID)
                        wait()
                        pcall(function()
                            wait()
                            game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                        end)
                        wait(4)
                    end
                end
            end
        end
        function Teleport() 
            while wait() do
                pcall(function()
                    TPReturner()
                    if foundAnything ~= "" then
                        TPReturner()
                    end
                end)
            end
        end
        Teleport()
    end

    function Attack()
        pcall(function()
            wait()
            game:GetService'VirtualUser':CaptureController()
            game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
        end)
    end

    function toTarget(targetPos, targetCFrame)
        local tweenfunc = {}
        local tween_s = game:service"TweenService"
        local info = TweenInfo.new((targetPos - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude/300, Enum.EasingStyle.Linear)
        local tween = tween_s:Create(game:GetService("Players").LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = targetCFrame * CFrame.fromAxisAngle(Vector3.new(1,0,0), math.rad(0))})
        tween:Play()
    
        function tweenfunc:Stop()
            tween:Cancel()
            return tween
        end
    
        if not tween then return tween end
        return tweenfunc
    end

    function EquipTool(Tool)
        pcall(function()
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack[Tool])
        end)
    end

    task.spawn(function()
        while wait() do
        pcall(function()
        if _G.AUTOFARM  then
        if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
            local Noclip = Instance.new("BodyVelocity")
            Noclip.Name = "BodyClip"
            Noclip.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
            Noclip.MaxForce = Vector3.new(100000,100000,100000)
            Noclip.Velocity = Vector3.new(0,0,0)
        end
            for _, no in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
                if no:IsA("BasePart") then
                    no.CanCollide = false    
                end
            end
        else
            if game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
               game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
            end
        end
        end)
        end
    end)

    function AutoHaki()
        if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") then
            wait(1)
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
        end
    end

    local placeId = game.PlaceId;
                         if placeId == 2753915549 then
                            OldWorld = true;
                         elseif placeId == 4442272183 then
                            NewWorld = true;
                         elseif placeId == 7449423635 then
                            Three = true;
                            do
                               local count = 0;
                               for i,v in pairs(game:GetService("Workspace").Map.Turtle:GetChildren()) do
                                  if v.Name == "Model" and #v:GetChildren() >= 40 and v:FindFirstChild("Meshes/Plank7") and i > 20 then
                                     v:Destroy()
                                     count = count + 1
                                     if count > 2 then
                                        break
                                     end
                                  end
                               end
                            end
                         end
                         function CheckQuest()
                            local MyLevel = game.Players.LocalPlayer.Data.Level.Value
                            if OldWorld then
                               if MyLevel == 1 or MyLevel <= 9 then -- Bandit
                                Ms = "Bandit [Lv. 5]"
                                NaemQuest = "BanditQuest1"
                                LevelQuest = 1
                                NameMon = "Bandit"
                                CFrameQuest = CFrame.new(1061.66699, 16.5166187, 1544.52905, -0.942978859, -3.33851502e-09, 0.332852632, 7.04340497e-09, 1, 2.99841325e-08, -0.332852632, 3.06188177e-08, -0.942978859)
                                CFrameMon = CFrame.new(1199.31287, 52.2717781, 1536.91516, -0.929782331, 6.60215846e-08, -0.368109822, 3.9077392e-08, 1, 8.06501603e-08, 0.368109822, 6.06023249e-08, -0.929782331)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 10 or MyLevel <= 14 then -- Monkey
                                magbring = 400
                                Ms = "Monkey [Lv. 14]"
                                NaemQuest = "JungleQuest"
                                LevelQuest = 1
                                NameMon = "Monkey"
                                CFrameQuest = CFrame.new(-1604.12012, 36.8521118, 154.23732, 0.0648873374, -4.70858913e-06, -0.997892559, 1.41431883e-07, 1, -4.70933674e-06, 0.997892559, 1.64442184e-07, 0.0648873374)
                                CFrameMon = CFrame.new(-1502.74609, 98.5633316, 90.6417007, 0.836947978, 0, 0.547282517, -0, 1, -0, -0.547282517, 0, 0.836947978)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 500 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 15 or MyLevel <= 29 then -- Gorilla
                                magbring = 240
                                Ms = "Gorilla [Lv. 20]"
                                NaemQuest = "JungleQuest"
                                LevelQuest = 2
                                NameMon = "Gorilla"
                                CFrameQuest = CFrame.new(-1604.12012, 36.8521118, 154.23732, 0.0648873374, -4.70858913e-06, -0.997892559, 1.41431883e-07, 1, -4.70933674e-06, 0.997892559, 1.64442184e-07, 0.0648873374)
                                CFrameMon = CFrame.new(-1223.52808, 6.27936459, -502.292664, 0.310949147, -5.66602516e-08, 0.950426519, -3.37275488e-08, 1, 7.06501808e-08, -0.950426519, -5.40241736e-08, 0.310949147)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 30 or MyLevel <= 39 then -- Pirate
                                Dis = 150
                                Ms = "Pirate [Lv. 35]"
                                NaemQuest = "BuggyQuest1"
                                LevelQuest = 1
                                NameMon = "Pirate"
                                CFrameQuest = CFrame.new(-1139.59717, 4.75205183, 3825.16211, -0.959730506, -7.5857054e-09, 0.280922383, -4.06310328e-08, 1, -1.11807175e-07, -0.280922383, -1.18718916e-07, -0.959730506)
                                CFrameMon = CFrame.new(-1219.32324, 4.75205183, 3915.63452, -0.966492832, -6.91238853e-08, 0.25669381, -5.21195496e-08, 1, 7.3047012e-08, -0.25669381, 5.72206496e-08, -0.966492832)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 40 or MyLevel <= 59 then -- Brute
                                Dis = 150
                                Ms = "Brute [Lv. 45]"
                                NaemQuest = "BuggyQuest1"
                                LevelQuest = 2
                                NameMon = "Brute"
                                CFrameQuest = CFrame.new(-1139.59717, 4.75205183, 3825.16211, -0.959730506, -7.5857054e-09, 0.280922383, -4.06310328e-08, 1, -1.11807175e-07, -0.280922383, -1.18718916e-07, -0.959730506)
                                CFrameMon = CFrame.new(-1146.49646, 96.0936813, 4312.1333, -0.978175163, -1.53222057e-08, 0.207781896, -3.33316912e-08, 1, -8.31738873e-08, -0.207781896, -8.82843523e-08, -0.978175163)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 60 or MyLevel <= 74 then -- Desert Bandit
                                Ms = "Desert Bandit [Lv. 60]"
                                NaemQuest = "DesertQuest"
                                LevelQuest = 1
                                NameMon = "Desert Bandit"
                                CFrameQuest = CFrame.new(897.031128, 6.43846416, 4388.97168, -0.804044724, 3.68233266e-08, 0.594568789, 6.97835176e-08, 1, 3.24365246e-08, -0.594568789, 6.75715199e-08, -0.804044724)
                                CFrameMon = CFrame.new(932.788818, 6.4503746, 4488.24609, -0.998625934, 3.08948351e-08, 0.0524050146, 2.79967303e-08, 1, -5.60361286e-08, -0.0524050146, -5.44919629e-08, -0.998625934)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 500 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 75 or MyLevel <= 89 then -- Desert Officre
                                Ms = "Desert Officer [Lv. 70]"
                                NaemQuest = "DesertQuest"
                                LevelQuest = 2
                                NameMon = "Desert Officer"
                                CFrameQuest = CFrame.new(897.031128, 6.43846416, 4388.97168, -0.804044724, 3.68233266e-08, 0.594568789, 6.97835176e-08, 1, 3.24365246e-08, -0.594568789, 6.75715199e-08, -0.804044724)
                                CFrameMon = CFrame.new(1580.03198, 4.61375761, 4366.86426, 0.135744005, -6.44280718e-08, -0.990743816, 4.35738308e-08, 1, -5.90598574e-08, 0.990743816, -3.51534837e-08, 0.135744005)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 90 or MyLevel <= 99 then -- Snow Bandits
                                Ms = "Snow Bandit [Lv. 90]"
                                NaemQuest = "SnowQuest"
                                LevelQuest = 1
                                NameMon = "Snow Bandits"
                                CFrameQuest = CFrame.new(1384.14001, 87.272789, -1297.06482, 0.348555952, -2.53947841e-09, -0.937287986, 1.49860568e-08, 1, 2.86358204e-09, 0.937287986, -1.50443711e-08, 0.348555952)
                                CFrameMon = CFrame.new(1370.24316, 102.403511, -1411.52905, 0.980274439, -1.12995728e-08, 0.197641045, -9.57343449e-09, 1, 1.04655214e-07, -0.197641045, -1.04482936e-07, 0.980274439)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 500 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 100 or MyLevel <= 119 then -- Snowman
                                Ms = "Snowman [Lv. 100]"
                                NaemQuest = "SnowQuest"
                                LevelQuest = 2
                                NameMon = "Snowman"
                                CFrameQuest = CFrame.new(1384.14001, 87.272789, -1297.06482, 0.348555952, -2.53947841e-09, -0.937287986, 1.49860568e-08, 1, 2.86358204e-09, 0.937287986, -1.50443711e-08, 0.348555952)
                                CFrameMon = CFrame.new(1370.24316, 102.403511, -1411.52905, 0.980274439, -1.12995728e-08, 0.197641045, -9.57343449e-09, 1, 1.04655214e-07, -0.197641045, -1.04482936e-07, 0.980274439)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 120 or MyLevel <= 149 then -- Chief Petty Officer
                                Ms = "Chief Petty Officer [Lv. 120]"
                                NaemQuest = "MarineQuest2"
                                LevelQuest = 1
                                NameMon = "Chief Petty Officer"
                                CFrameQuest = CFrame.new(-5035.0835, 28.6520386, 4325.29443, 0.0243340395, -7.08064647e-08, 0.999703884, -6.36926814e-08, 1, 7.23777944e-08, -0.999703884, -6.54350671e-08, 0.0243340395)
                                CFrameMon = CFrame.new(-4882.8623, 22.6520386, 4255.53516, 0.273695946, -5.40380647e-08, -0.96181643, 4.37720793e-08, 1, -4.37274998e-08, 0.96181643, -3.01326679e-08, 0.273695946)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 500 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 150 or MyLevel <= 174 then -- Sky Bandit
                                Ms = "Sky Bandit [Lv. 150]"
                                NaemQuest = "SkyQuest"
                                LevelQuest = 1
                                NameMon = "Sky Bandit"
                                CFrameQuest = CFrame.new(-4841.83447, 717.669617, -2623.96436, -0.875942111, 5.59710216e-08, -0.482416272, 3.04023082e-08, 1, 6.08195947e-08, 0.482416272, 3.86078725e-08, -0.875942111)
                                CFrameMon = CFrame.new(-4970.74219, 294.544342, -2890.11353, -0.994874597, -8.61311236e-08, -0.101116329, -9.10836206e-08, 1, 4.43614923e-08, 0.101116329, 5.33441664e-08, -0.994874597)
                                if _G.AUTOFARM and _G.By_Pass and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275, 872.54248, -1667.55688))
                                end
                            elseif MyLevel == 175 or MyLevel <= 189 then -- Dark Master
                                Ms = "Dark Master [Lv. 175]"
                                NaemQuest = "SkyQuest"
                                LevelQuest = 2
                                NameMon = "Dark Master"
                                CFrameQuest = CFrame.new(-4841.83447, 717.669617, -2623.96436, -0.875942111, 5.59710216e-08, -0.482416272, 3.04023082e-08, 1, 6.08195947e-08, 0.482416272, 3.86078725e-08, -0.875942111)
                                CFrameMon = CFrame.new(-5220.58594, 430.693298, -2278.17456, -0.925375521, 1.12086873e-08, 0.379051805, -1.05115507e-08, 1, -5.52320891e-08, -0.379051805, -5.50948407e-08, -0.925375521)
                                if _G.AUTOFARM and _G.By_Pass and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275, 872.54248, -1667.55688))
                                end
                            elseif MyLevel == 190 or MyLevel <= 209 then -- Dark Master
                                Ms = "Prisoner [Lv. 190]"
                                NaemQuest = "PrisonerQuest"
                                LevelQuest = 1
                                NameMon = "Prisoner"
                                CFrameQuest = CFrame.new(5310.61, 0.350015, 474.947)
                                CFrameMon = CFrame.new(4977.88525390625, 72.67780303955078, 498.108642578125)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 210 or MyLevel <= 249 then -- Dark Master
                                Ms = "Dangerous Prisoner [Lv. 210]"
                                NaemQuest = "PrisonerQuest"
                                LevelQuest = 2
                                NameMon = "Dangerous Prisoner"
                                CFrameQuest = CFrame.new(5310.61, 0.350015, 474.947)
                                CFrameMon = CFrame.new(5656.42333984375, 72.67793273925781, 866.1055908203125)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 250 or MyLevel <= 274 then -- Toga Warrior
                                Ms = "Toga Warrior [Lv. 250]"
                                NaemQuest = "ColosseumQuest"
                                LevelQuest = 1
                                NameMon = "Toga Warrior"
                                CFrameQuest = CFrame.new(-1576.11743, 7.38933945, -2983.30762, 0.576966345, 1.22114863e-09, 0.816767931, -3.58496594e-10, 1, -1.24185606e-09, -0.816767931, 4.2370063e-10, 0.576966345)
                                CFrameMon = CFrame.new(-1779.97583, 44.6077499, -2736.35474, 0.984437346, 4.10396339e-08, 0.175734788, -3.62286876e-08, 1, -3.05844168e-08, -0.175734788, 2.3741821e-08, 0.984437346)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 275 or MyLevel <= 299 then -- Gladiato
                                Ms = "Gladiator [Lv. 275]"
                                NaemQuest = "ColosseumQuest"
                                LevelQuest = 2
                                NameMon = "Gladiato"
                                CFrameQuest = CFrame.new(-1576.11743, 7.38933945, -2983.30762, 0.576966345, 1.22114863e-09, 0.816767931, -3.58496594e-10, 1, -1.24185606e-09, -0.816767931, 4.2370063e-10, 0.576966345)
                                CFrameMon = CFrame.new(-1274.75903, 58.1895943, -3188.16309, 0.464524001, 6.21005611e-08, 0.885560572, -4.80449414e-09, 1, -6.76054768e-08, -0.885560572, 2.71497012e-08, 0.464524001)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 300 or MyLevel <= 329 then -- Military Soldier
                                Ms = "Military Soldier [Lv. 300]"
                                NaemQuest = "MagmaQuest"
                                LevelQuest = 1
                                NameMon = "Military Soldier"
                                CFrameQuest = CFrame.new(-5316.55859, 12.2370615, 8517.2998, 0.588437557, -1.37880001e-08, -0.808542669, -2.10116209e-08, 1, -3.23446478e-08, 0.808542669, 3.60215964e-08, 0.588437557)
                                CFrameMon = CFrame.new(-5363.01123, 41.5056877, 8548.47266, -0.578253984, -3.29503091e-10, 0.815856814, 9.11209668e-08, 1, 6.498761e-08, -0.815856814, 1.11920997e-07, -0.578253984)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 325 or MyLevel <= 374 then -- Military Spy
                                FM = false
                                Ms = "Military Spy [Lv. 325]"
                                NaemQuest = "MagmaQuest"
                                LevelQuest = 2
                                NameMon = "Military Spy"
                                CFrameQuest = CFrame.new(-5316.55859, 12.2370615, 8517.2998, 0.588437557, -1.37880001e-08, -0.808542669, -2.10116209e-08, 1, -3.23446478e-08, 0.808542669, 3.60215964e-08, 0.588437557)
                                CFrameMon = CFrame.new(-5787.99023, 120.864456, 8762.25293, -0.188358366, -1.84706277e-08, 0.982100308, -1.23782129e-07, 1, -4.93306951e-09, -0.982100308, -1.22495649e-07, -0.188358366)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 375 or MyLevel <= 399 then -- Fishman Warrior
                                FM = true
                                Ms = "Fishman Warrior [Lv. 375]"
                                NaemQuest = "FishmanQuest"
                                LevelQuest = 1
                                NameMon = "Fishman Warrior"
                                CFrameQuest = CFrame.new(61122.5625, 18.4716396, 1568.16504, 0.893533468, 3.95251609e-09, 0.448996574, -2.34327455e-08, 1, 3.78297464e-08, -0.448996574, -4.43233645e-08, 0.893533468)
                                CFrameMon = CFrame.new(60946.6094, 48.6735229, 1525.91687, -0.0817126185, 8.90751153e-08, 0.996655822, 2.00889794e-08, 1, -8.77269599e-08, -0.996655822, 1.28533992e-08, -0.0817126185)
                                if _G.AUTOFARM and _G.By_Pass and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
                                end
                            elseif MyLevel == 400 or MyLevel <= 449 then -- Fishman Commando
                                FM = true
                                Ms = "Fishman Commando [Lv. 400]"
                                NaemQuest = "FishmanQuest"
                                LevelQuest = 2
                                NameMon = "Fishman Commando"
                                CFrameQuest = CFrame.new(61122.5625, 18.4716396, 1568.16504, 0.893533468, 3.95251609e-09, 0.448996574, -2.34327455e-08, 1, 3.78297464e-08, -0.448996574, -4.43233645e-08, 0.893533468)
                                CFrameMon = CFrame.new(61885.5039, 18.4828243, 1504.17896, 0.577502489, 0, -0.816389024, -0, 1.00000012, -0, 0.816389024, 0, 0.577502489)
                                if _G.AUTOFARM and _G.By_Pass and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
                                end
                            elseif MyLevel == 450 or MyLevel <= 474 then -- God's Guards
                                FM = false
                                Ms = "God's Guard [Lv. 450]"
                                NaemQuest = "SkyExp1Quest"
                                LevelQuest = 1
                                NameMon = "God's Guards"
                                CFrameQuest = CFrame.new(-4721.71436, 845.277161, -1954.20105, -0.999277651, -5.56969759e-09, 0.0380011722, -4.14751478e-09, 1, 3.75035256e-08, -0.0380011722, 3.73188307e-08, -0.999277651)
                                CFrameMon = CFrame.new(-4716.95703, 853.089722, -1933.92542, -0.93441087, -6.77488776e-09, -0.356197298, 1.12145182e-08, 1, -4.84390199e-08, 0.356197298, -4.92565206e-08, -0.93441087)
                                if _G.AUTOFARM and _G.By_Pass and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275, 872.54248, -1667.55688))
                                end
                            elseif MyLevel == 475 or MyLevel <= 524 then -- Shandas
                                sky = false
                                Ms = "Shanda [Lv. 475]"
                                NaemQuest = "SkyExp1Quest"
                                LevelQuest = 2
                                NameMon = "Shandas"
                                CFrameQuest = CFrame.new(-7863.63672, 5545.49316, -379.826324, 0.362120807, -1.98046344e-08, -0.93213129, 4.05822291e-08, 1, -5.48095125e-09, 0.93213129, -3.58431969e-08, 0.362120807)
                                CFrameMon = CFrame.new(-7685.12354, 5601.05127, -443.171509, 0.150056243, 1.79768236e-08, -0.988677442, 6.67798661e-09, 1, 1.91962481e-08, 0.988677442, -9.48289181e-09, 0.150056243)
                                if _G.AUTOFARM and _G.By_Pass and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
                                end
                            elseif MyLevel == 525 or MyLevel <= 549 then -- Royal Squad
                                sky = true
                                Ms = "Royal Squad [Lv. 525]"
                                NaemQuest = "SkyExp2Quest"
                                LevelQuest = 1
                                NameMon = "Royal Squad"
                                CFrameQuest = CFrame.new(-7902.66895, 5635.96387, -1411.71802, 0.0504222959, 2.5710392e-08, 0.998727977, 1.12541557e-07, 1, -3.14249675e-08, -0.998727977, 1.13982921e-07, 0.0504222959)
                                CFrameMon = CFrame.new(-7685.02051, 5606.87842, -1442.729, 0.561947823, 7.69527464e-09, -0.827172697, -4.24974544e-09, 1, 6.41599973e-09, 0.827172697, -9.01838604e-11, 0.561947823)
                            elseif MyLevel == 550 or MyLevel <= 624 then -- Royal Soldier
                                Dis = 240
                                sky = true
                                Ms = "Royal Soldier [Lv. 550]"
                                NaemQuest = "SkyExp2Quest"
                                LevelQuest = 2
                                NameMon = "Royal Soldier"
                                CFrameQuest = CFrame.new(-7902.66895, 5635.96387, -1411.71802, 0.0504222959, 2.5710392e-08, 0.998727977, 1.12541557e-07, 1, -3.14249675e-08, -0.998727977, 1.13982921e-07, 0.0504222959)
                                CFrameMon = CFrame.new(-7864.44775, 5661.94092, -1708.22351, 0.998389959, 2.28686137e-09, -0.0567218624, 1.99431383e-09, 1, 7.54200258e-08, 0.0567218624, -7.54117195e-08, 0.998389959)
                            elseif MyLevel == 625 or MyLevel <= 649 then -- Galley Pirate
                                Dis = 240
                                sky = false
                                Ms = "Galley Pirate [Lv. 625]"
                                NaemQuest = "FountainQuest"
                                LevelQuest = 1
                                NameMon = "Galley Pirate"
                                CFrameQuest = CFrame.new(5254.60156, 38.5011406, 4049.69678, -0.0504891425, -3.62066501e-08, -0.998724639, -9.87921389e-09, 1, -3.57534553e-08, 0.998724639, 8.06145284e-09, -0.0504891425)
                                CFrameMon = CFrame.new(5595.06982, 41.5013695, 3961.47095, -0.992138803, -2.11610267e-08, -0.125142589, -1.34249509e-08, 1, -6.26613996e-08, 0.125142589, -6.04887518e-08, -0.992138803)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel >= 650 then -- Galley Captain
                                Dis = 240
                                Ms = "Galley Captain [Lv. 650]"
                                NaemQuest = "FountainQuest"
                                LevelQuest = 2
                                NameMon = "Galley Captain"
                                CFrameQuest = CFrame.new(5254.60156, 38.5011406, 4049.69678, -0.0504891425, -3.62066501e-08, -0.998724639, -9.87921389e-09, 1, -3.57534553e-08, 0.998724639, 8.06145284e-09, -0.0504891425)
                                CFrameMon = CFrame.new(5658.5752, 38.5361786, 4928.93506, -0.996873081, 2.12391046e-06, -0.0790185928, 2.16989656e-06, 1, -4.96097414e-07, 0.0790185928, -6.66008248e-07, -0.996873081)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            end
                        elseif NewWorld then
                            local MyLevel = game.Players.LocalPlayer.Data.Level.Value
                            Dis = 240
                            if MyLevel == 700 or MyLevel <= 724 then -- Raider [Lv. 700]
                                Ms = "Raider [Lv. 700]"
                                NaemQuest = "Area1Quest"
                                LevelQuest = 1
                                NameMon = "Raider"
                                CFrameQuest = CFrame.new(-424.080078, 73.0055847, 1836.91589, 0.253544956, -1.42165932e-08, 0.967323601, -6.00147771e-08, 1, 3.04272909e-08, -0.967323601, -6.5768397e-08, 0.253544956)
                                CFrameMon = CFrame.new(-217.138626, 39.2450829, 2393.54468, 0.146848485, 0, -0.989159107, 0, 1, 0, 0.989159107, 0, 0.146848485)
                            elseif MyLevel == 725 or MyLevel <= 774 then -- Mercenary [Lv. 725]
                                Ms = "Mercenary [Lv. 725]"
                                NaemQuest = "Area1Quest"
                                LevelQuest = 2
                                NameMon = "Mercenary"
                                CFrameQuest = CFrame.new(-424.080078, 73.0055847, 1836.91589, 0.253544956, -1.42165932e-08, 0.967323601, -6.00147771e-08, 1, 3.04272909e-08, -0.967323601, -6.5768397e-08, 0.253544956)
                                CFrameMon = CFrame.new(-973.731995, 95.8733215, 1836.46936, 0.999135971, 2.02326991e-08, -0.0415605344, -1.90767793e-08, 1, 2.82094952e-08, 0.0415605344, -2.73922804e-08, 0.999135971)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 775 or MyLevel <= 799 then -- Swan Pirate [Lv. 775]
                                Ms = "Swan Pirate [Lv. 775]"
                                NaemQuest = "Area2Quest"
                                LevelQuest = 1
                                NameMon = "Swan Pirate"
                                CFrameQuest = CFrame.new(632.698608, 73.1055908, 918.666321, -0.0319722369, 8.96074881e-10, -0.999488771, 1.36326533e-10, 1, 8.92172336e-10, 0.999488771, -1.07732087e-10, -0.0319722369)
                                CFrameMon = CFrame.new(970.369446, 142.653198, 1217.3667, 0.162079468, -4.85452638e-08, -0.986777723, 1.03357589e-08, 1, -4.74980872e-08, 0.986777723, -2.50063148e-09, 0.162079468)
                            elseif MyLevel == 800 or MyLevel <= 874 then -- Factory Staff [Lv. 800]
                                Ms = "Factory Staff [Lv. 800]"
                                NaemQuest = "Area2Quest"
                                LevelQuest = 2
                                NameMon = "Factory Staff"
                                CFrameQuest = CFrame.new(632.698608, 73.1055908, 918.666321, -0.0319722369, 8.96074881e-10, -0.999488771, 1.36326533e-10, 1, 8.92172336e-10, 0.999488771, -1.07732087e-10, -0.0319722369)
                                CFrameMon = CFrame.new(296.786499, 72.9948196, -57.1298141, -0.876037002, -5.32364979e-08, 0.482243896, -3.87658332e-08, 1, 3.99718729e-08, -0.482243896, 1.63222538e-08, -0.876037002)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 875 or MyLevel <= 899 then -- Marine Lieutenant [Lv. 875]
                                Ms = "Marine Lieutenant [Lv. 875]"
                                NaemQuest = "MarineQuest3"
                                LevelQuest = 1
                                NameMon = "Marine Lieutenant"
                                CFrameQuest = CFrame.new(-2442.65015, 73.0511475, -3219.11523, -0.873540044, 4.2329841e-08, -0.486752301, 5.64383384e-08, 1, -1.43220786e-08, 0.486752301, -3.99823996e-08, -0.873540044)
                                CFrameMon = CFrame.new(-2913.26367, 73.0011826, -2971.64282, 0.910507619, 0, 0.413492233, 0, 1.00000012, 0, -0.413492233, 0, 0.910507619)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 900 or MyLevel <= 949 then -- Marine Captain [Lv. 900]
                                Ms = "Marine Captain [Lv. 900]"
                                NaemQuest = "MarineQuest3"
                                LevelQuest = 2
                                NameMon = "Marine Captain"
                                CFrameQuest = CFrame.new(-2442.65015, 73.0511475, -3219.11523, -0.873540044, 4.2329841e-08, -0.486752301, 5.64383384e-08, 1, -1.43220786e-08, 0.486752301, -3.99823996e-08, -0.873540044)
                                CFrameMon = CFrame.new(-1868.67688, 73.0011826, -3321.66333, -0.971402287, 1.06502087e-08, 0.237439692, 3.68856199e-08, 1, 1.06050372e-07, -0.237439692, 1.11775684e-07, -0.971402287)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 950 or MyLevel <= 974 then -- Zombie [Lv. 950]
                                Ms = "Zombie [Lv. 950]"
                                NaemQuest = "ZombieQuest"
                                LevelQuest = 1
                                NameMon = "Zombie"
                                CFrameQuest = CFrame.new(-5492.79395, 48.5151672, -793.710571, 0.321800292, -6.24695815e-08, 0.946807742, 4.05616092e-08, 1, 5.21931227e-08, -0.946807742, 2.16082796e-08, 0.321800292)
                                CFrameMon = CFrame.new(-5634.83838, 126.067039, -697.665039, -0.992770672, 6.77618939e-09, 0.120025545, 1.65461245e-08, 1, 8.04023372e-08, -0.120025545, 8.18070234e-08, -0.992770672)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 975 or MyLevel <= 999 then -- Vampire [Lv. 975]
                                Ms = "Vampire [Lv. 975]"
                                NaemQuest = "ZombieQuest"
                                LevelQuest = 2
                                NameMon = "Vampire"
                                CFrameQuest = CFrame.new(-5492.79395, 48.5151672, -793.710571, 0.321800292, -6.24695815e-08, 0.946807742, 4.05616092e-08, 1, 5.21931227e-08, -0.946807742, 2.16082796e-08, 0.321800292)
                                CFrameMon = CFrame.new(-6030.32031, 6.4377408, -1313.5564, -0.856965423, 3.9138893e-08, -0.515373945, -1.12178942e-08, 1, 9.45958547e-08, 0.515373945, 8.68467822e-08, -0.856965423)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 1000 or MyLevel <= 1049 then -- Snow Trooper [Lv. 1000] **
                                Ms = "Snow Trooper [Lv. 1000]"
                                NaemQuest = "SnowMountainQuest"
                                LevelQuest = 1
                                NameMon = "Snow Trooper"
                                CFrameQuest = CFrame.new(604.964966, 401.457062, -5371.69287, 0.353063971, 1.89520435e-08, -0.935599446, -5.81846002e-08, 1, -1.70033754e-09, 0.935599446, 5.50377841e-08, 0.353063971)
                                CFrameMon = CFrame.new(535.893433, 401.457062, -5329.6958, -0.999524176, 0, 0.0308452044, 0, 1, -0, -0.0308452044, 0, -0.999524176)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 1050 or MyLevel <= 1099 then -- Winter Warrior [Lv. 1050]
                                Ms = "Winter Warrior [Lv. 1050]"
                                NaemQuest = "SnowMountainQuest"
                                LevelQuest = 2
                                NameMon = "Winter Warrior"
                                CFrameQuest = CFrame.new(604.964966, 401.457062, -5371.69287, 0.353063971, 1.89520435e-08, -0.935599446, -5.81846002e-08, 1, -1.70033754e-09, 0.935599446, 5.50377841e-08, 0.353063971)
                                CFrameMon = CFrame.new(1223.7417, 454.575226, -5170.02148, 0.473996818, 2.56845354e-08, 0.880526543, -5.62456428e-08, 1, 1.10811016e-09, -0.880526543, -5.00510211e-08, 0.473996818)
                            
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 1100 or MyLevel <= 1124 then -- Lab Subordinate [Lv. 1100]
                                Ms = "Lab Subordinate [Lv. 1100]"
                                NaemQuest = "IceSideQuest"
                                LevelQuest = 1
                                NameMon = "Lab Subordinate"
                                CFrameQuest = CFrame.new(-6060.10693, 15.9868021, -4904.7876, -0.411000341, -5.06538868e-07, 0.91163528, 1.26306062e-07, 1, 6.12581289e-07, -0.91163528, 3.66916197e-07, -0.411000341)
                                CFrameMon = CFrame.new(-5769.2041, 37.9288292, -4468.38721, -0.569419742, -2.49055017e-08, 0.822046936, -6.96206541e-08, 1, -1.79282633e-08, -0.822046936, -6.74401548e-08, -0.569419742)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 1125 or MyLevel <= 1174 then -- Horned Warrior [Lv. 1125]
                                Ms = "Horned Warrior [Lv. 1125]"
                                NaemQuest = "IceSideQuest"
                                LevelQuest = 2
                                NameMon = "Horned Warrior"
                                CFrameQuest = CFrame.new(-6060.10693, 15.9868021, -4904.7876, -0.411000341, -5.06538868e-07, 0.91163528, 1.26306062e-07, 1, 6.12581289e-07, -0.91163528, 3.66916197e-07, -0.411000341)
                                CFrameMon = CFrame.new(-6400.85889, 24.7645149, -5818.63574, -0.964845479, 8.65926566e-08, -0.262817472, 3.98261392e-07, 1, -1.13260398e-06, 0.262817472, -1.19745812e-06, -0.964845479)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 1175 or MyLevel <= 1199 then -- Magma Ninja [Lv. 1175]
                                Ms = "Magma Ninja [Lv. 1175]"
                                NaemQuest = "FireSideQuest"
                                LevelQuest = 1
                                NameMon = "Magma Ninja"
                                CFrameQuest = CFrame.new(-5431.09473, 15.9868021, -5296.53223, 0.831796765, 1.15322464e-07, -0.555080295, -1.10814341e-07, 1, 4.17010995e-08, 0.555080295, 2.68240168e-08, 0.831796765)
                                CFrameMon = CFrame.new(-5496.65576, 58.6890411, -5929.76855, -0.885073781, 0, -0.465450764, 0, 1.00000012, -0, 0.465450764, 0, -0.885073781)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 1200 or MyLevel <= 1249 then -- Lava Pirate [Lv. 1200]
                                Ms = "Lava Pirate [Lv. 1200]"
                                NaemQuest = "FireSideQuest"
                                LevelQuest = 2
                                NameMon = "Lava Pirate"
                                CFrameQuest = CFrame.new(-5431.09473, 15.9868021, -5296.53223, 0.831796765, 1.15322464e-07, -0.555080295, -1.10814341e-07, 1, 4.17010995e-08, 0.555080295, 2.68240168e-08, 0.831796765)
                                CFrameMon = CFrame.new(-5169.71729, 34.1234779, -4669.73633, -0.196780294, 0, 0.98044765, 0, 1.00000012, -0, -0.98044765, 0, -0.196780294)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 1250 or MyLevel <= 1274 then -- Ship Deckhand [Lv. 1250]
                                Ms = "Ship Deckhand [Lv. 1250]"
                                NaemQuest = "ShipQuest1"
                                LevelQuest = 1
                                NameMon = "Ship Deckhand"
                                CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016, -0.244533166, -0, -0.969640911, -0, 1.00000012, -0, 0.96964103, 0, -0.244533136)
                                CFrameMon = CFrame.new(1163.80872, 138.288452, 33058.4258, -0.998580813, 5.49076979e-08, -0.0532564968, 5.57436763e-08, 1, -1.42118655e-08, 0.0532564968, -1.71604082e-08, -0.998580813)
                                if _G.AUTOFARM and _G.By_Pass and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                                end
                            elseif MyLevel == 1275 or MyLevel <= 1299 then -- Ship Engineer [Lv. 1275]
                                Ms = "Ship Engineer [Lv. 1275]"
                                NaemQuest = "ShipQuest1"
                                LevelQuest = 2
                                NameMon = "Ship Engineer"
                                CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016, -0.244533166, -0, -0.969640911, -0, 1.00000012, -0, 0.96964103, 0, -0.244533136)
                                CFrameMon = CFrame.new(916.666504, 44.0920448, 32917.207, -0.99746871, -4.85034697e-08, -0.0711069331, -4.8925461e-08, 1, 4.19294288e-09, 0.0711069331, 7.66126895e-09, -0.99746871)
                                if _G.AUTOFARM and _G.By_Pass and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                                end
                            elseif MyLevel == 1300 or MyLevel <= 1324 then -- Ship Steward [Lv. 1300]
                                Ms = "Ship Steward [Lv. 1300]"
                                NaemQuest = "ShipQuest2"
                                LevelQuest = 1
                                NameMon = "Ship Steward"
                                CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125, -0.869560242, 1.51905191e-08, -0.493826836, 1.44108379e-08, 1, 5.38534195e-09, 0.493826836, -2.43357912e-09, -0.869560242)
                                CFrameMon = CFrame.new(918.743286, 129.591064, 33443.4609, -0.999792814, -1.7070947e-07, -0.020350717, -1.72559169e-07, 1, 8.91351277e-08, 0.020350717, 9.2628369e-08, -0.999792814)
                                if _G.AUTOFARM and _G.By_Pass and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                                end
                            elseif MyLevel == 1325 or MyLevel <= 1349 then -- Ship Officer [Lv. 1325]
                                Ms = "Ship Officer [Lv. 1325]"
                                NaemQuest = "ShipQuest2"
                                LevelQuest = 2
                                NameMon = "Ship Officer"
                                CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125, -0.869560242, 1.51905191e-08, -0.493826836, 1.44108379e-08, 1, 5.38534195e-09, 0.493826836, -2.43357912e-09, -0.869560242)
                                CFrameMon = CFrame.new(786.051941, 181.474106, 33303.2969, 0.999285698, -5.32193063e-08, 0.0377905183, 5.68968588e-08, 1, -9.62386864e-08, -0.0377905183, 9.83201005e-08, 0.999285698)
                                if _G.AUTOFARM and _G.By_Pass and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                                end
                            elseif MyLevel == 1350 or MyLevel <= 1374 then -- Arctic Warrior [Lv. 1350]
                                Ms = "Arctic Warrior [Lv. 1350]"
                                NaemQuest = "FrostQuest"
                                LevelQuest = 1
                                NameMon = "Arctic Warrior"
                                CFrameQuest = CFrame.new(5669.43506, 28.2117786, -6482.60107, 0.888092756, 1.02705066e-07, 0.459664226, -6.20391774e-08, 1, -1.03572376e-07, -0.459664226, 6.34646895e-08, 0.888092756)
                                CFrameMon = CFrame.new(5995.07471, 57.3188477, -6183.47314, 0.702747107, -1.53454167e-07, -0.711440146, -1.08168464e-07, 1, -3.22542007e-07, 0.711440146, 3.03620908e-07, 0.702747107)
								if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
									game.Players.LocalPlayer.Character.Head:Destroy()
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
									wait(1)
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
								end
                            elseif MyLevel == 1375 or MyLevel <= 1424 then -- Snow Lurker [Lv. 1375]
                                Ms = "Snow Lurker [Lv. 1375]"
                                NaemQuest = "FrostQuest"
                                LevelQuest = 2
                                NameMon = "Snow Lurker"
                                CFrameQuest = CFrame.new(5669.43506, 28.2117786, -6482.60107, 0.888092756, 1.02705066e-07, 0.459664226, -6.20391774e-08, 1, -1.03572376e-07, -0.459664226, 6.34646895e-08, 0.888092756)
                                CFrameMon = CFrame.new(5518.00684, 60.5559731, -6828.80518, -0.650781393, -3.64292951e-08, 0.759265184, -4.07668654e-09, 1, 4.44854642e-08, -0.759265184, 2.58550248e-08, -0.650781393)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 1425 or MyLevel <= 1449 then -- Sea Soldier [Lv. 1425]
                                Ms = "Sea Soldier [Lv. 1425]"
                                NaemQuest = "ForgottenQuest"
                                LevelQuest = 1
                                NameMon = "Sea Soldier"
                                CFrameQuest = CFrame.new(-3052.99097, 236.881363, -10148.1943, -0.997911751, 4.42321983e-08, 0.064591676, 4.90968759e-08, 1, 7.37270085e-08, -0.064591676, 7.67442998e-08, -0.997911751)
                                CFrameMon = CFrame.new(-3029.78467, 66.944252, -9777.38184, -0.998552859, 1.09555076e-08, 0.0537791774, 7.79564235e-09, 1, -5.89660658e-08, -0.0537791774, -5.84614881e-08, -0.998552859)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel >= 1450 then -- Water Fighter [Lv. 1450]
                                Ms = "Water Fighter [Lv. 1450]"
                                NaemQuest = "ForgottenQuest"
                                LevelQuest = 2
                                NameMon = "Water Fighter"
                                CFrameQuest = CFrame.new(-3052.99097, 236.881363, -10148.1943, -0.997911751, 4.42321983e-08, 0.064591676, 4.90968759e-08, 1, 7.37270085e-08, -0.064591676, 7.67442998e-08, -0.997911751)
                                CFrameMon = CFrame.new(-3262.00098, 298.699615, -10553.6943, -0.233570755, -4.57538185e-08, 0.972339869, -5.80986068e-08, 1, 3.30992194e-08, -0.972339869, -4.87605725e-08, -0.233570755)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            end
                        else
                            local MyLevel =  game.Players.LocalPlayer.Data.Level.Value
                            Dis = 240
                            if MyLevel == 1500 or MyLevel <= 1524 then
                                Ms = "Pirate Millionaire [Lv. 1500]"
                                NaemQuest = "PiratePortQuest"
                                LevelQuest = 1
                                NameMon = "Pirate Millionaire"
                                CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
                                CFrameMon = CFrame.new(81.164993286133, 43.755737304688, 5724.7021484375)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 1525 or MyLevel <= 1574 then
                                Ms = "Pistol Billionaire [Lv. 1525]"
                                NaemQuest = "PiratePortQuest"
                                LevelQuest = 2
                                NameMon = "Pistol Billionaire"
                                CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
                                CFrameMon = CFrame.new(81.164993286133, 43.755737304688, 5724.7021484375)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 1575 or MyLevel <= 1599 then
                                Ms = "Dragon Crew Warrior [Lv. 1575]"
                                NaemQuest = "AmazonQuest"
                                LevelQuest = 1
                                NameMon = "Dragon Crew Warrior"
                                CFrameQuest = CFrame.new(5832.83594, 51.6806107, -1101.51563, 0.898790359, -0, -0.438378751, 0, 1, -0, 0.438378751, 0, 0.898790359)
                                CFrameMon = CFrame.new(6241.9951171875, 51.522083282471, -1243.9771728516)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 1600 or MyLevel <= 1624 then
                                Ms = "Dragon Crew Archer [Lv. 1600]"
                                NaemQuest = "AmazonQuest"
                                LevelQuest = 2
                                NameMon = "Dragon Crew Archer"
                                CFrameQuest = CFrame.new(5832.83594, 51.6806107, -1101.51563, 0.898790359, -0, -0.438378751, 0, 1, -0, 0.438378751, 0, 0.898790359)
                                CFrameMon = CFrame.new(6488.9155273438, 383.38375854492, -110.66246032715)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 1625 or MyLevel <= 1649 then
                                Ms = "Female Islander [Lv. 1625]"
                                NaemQuest = "AmazonQuest2"
                                LevelQuest = 1
                                NameMon = "Female Islander"
                                CFrameQuest = CFrame.new(5448.86133, 601.516174, 751.130676, 0, 0, 1, 0, 1, -0, -1, 0, 0)
                                CFrameMon = CFrame.new(4770.4990234375, 758.95520019531, 1069.8680419922)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 1650 or MyLevel <= 1699 then
                                Ms = "Giant Islander [Lv. 1650]"
                                NaemQuest = "AmazonQuest2"
                                LevelQuest = 2
                                NameMon = "Giant Islander"
                                CFrameQuest = CFrame.new(5448.86133, 601.516174, 751.130676, 0, 0, 1, 0, 1, -0, -1, 0, 0)
                                CFrameMon = CFrame.new(4530.3540039063, 656.75695800781, -131.60952758789)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 1700 or MyLevel <= 1724 then
                                Ms = "Marine Commodore [Lv. 1700]"
                                NaemQuest = "MarineTreeIsland"
                                LevelQuest = 1
                                NameMon = "Marine Commodore"
                                CFrameQuest = CFrame.new(2180.54126, 27.8156815, -6741.5498, -0.965929747, 0, 0.258804798, 0, 1, 0, -0.258804798, 0, -0.965929747)
                                CFrameMon = CFrame.new(2490.0844726563, 190.4232635498, -7160.0502929688)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 1725 or MyLevel <= 1774 then
                                Ms = "Marine Rear Admiral [Lv. 1725]"
                                NaemQuest = "MarineTreeIsland"
                                LevelQuest = 2
                                NameMon = "Marine Rear Admiral"
                                CFrameQuest = CFrame.new(2180.54126, 27.8156815, -6741.5498, -0.965929747, 0, 0.258804798, 0, 1, 0, -0.258804798, 0, -0.965929747)
                                CFrameMon = CFrame.new(3951.3903808594, 229.11549377441, -6912.81640625)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 1775 or MyLevel <= 1799 then
                                Ms = "Fishman Raider [Lv. 1775]"
                                NaemQuest = "DeepForestIsland3"
                                LevelQuest = 1
                                NameMon = "Fishman Raider"
                                CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
                                CFrameMon = CFrame.new(-10322.400390625, 390.94473266602, -8580.0908203125)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 1800 or MyLevel <= 1824 then
                                Ms = "Fishman Captain [Lv. 1800]"
                                NaemQuest = "DeepForestIsland3"
                                LevelQuest = 2
                                NameMon = "Fishman Captain"
                                CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
                                CFrameMon = CFrame.new(-11194.541992188, 442.02795410156, -8608.806640625)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 1825 or MyLevel <= 1849 then
                                Ms = "Forest Pirate [Lv. 1825]"
                                NaemQuest = "DeepForestIsland"
                                LevelQuest = 1
                                NameMon = "Forest Pirate"
                                CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247)
                                CFrameMon = CFrame.new(-13225.809570313, 428.19387817383, -7753.1245117188)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 1850 or MyLevel <= 1899 then
                                Ms = "Mythological Pirate [Lv. 1850]"
                                NaemQuest = "DeepForestIsland"
                                LevelQuest = 2
                                NameMon = "Mythological Pirate"
                                CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247)
                                CFrameMon = CFrame.new(-13869.172851563, 564.95251464844, -7084.4135742188)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 1900 or MyLevel <= 1924 then
                                Ms = "Jungle Pirate [Lv. 1900]"
                                NaemQuest = "DeepForestIsland2"
                                LevelQuest = 1
                                NameMon = "Jungle Pirate"
                                CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
                                CFrameMon = CFrame.new(-11982.221679688, 376.32522583008, -10451.415039063)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 1925 or MyLevel <= 1974 then
                                Ms = "Musketeer Pirate [Lv. 1925]"
                                NaemQuest = "DeepForestIsland2"
                                LevelQuest = 2
                                NameMon = "Musketeer Pirate"
                                CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
                                CFrameMon = CFrame.new(-13282.3046875, 496.23684692383, -9565.150390625)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 1975 or MyLevel <= 1999 then
                                Ms = "Reborn Skeleton [Lv. 1975]"
                                NaemQuest = "HauntedQuest1"
                                LevelQuest = 1
                                NameMon = "Reborn Skeleton"
                                CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, -0, -1, 0, 0)
                                CFrameMon = CFrame.new(-8761.3154296875, 164.85829162598, 6161.1567382813)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 2000 or MyLevel <= 2024 then
                                Ms = "Living Zombie [Lv. 2000]"
                                NaemQuest = "HauntedQuest1"
                                LevelQuest = 2
                                NameMon = "Living Zombie"
                                CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, -0, -1, 0, 0)
                                CFrameMon = CFrame.new(-10093.930664063, 237.38233947754, 6180.5654296875)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 2025 or MyLevel <= 2049 then
                                Ms = "Demonic Soul [Lv. 2025]"
                                NaemQuest = "HauntedQuest2"
                                LevelQuest = 1
                                NameMon = "Demonic Soul"
                                CFrameQuest = CFrame.new(-9514.78027, 171.162918, 6078.82373, 0.301918149, 7.4535027e-09, 0.953333855, -3.22802141e-09, 1, -6.79604995e-09, -0.953333855, -1.02553133e-09, 0.301918149)
                                CFrameMon = CFrame.new(-9503.9921875, 272.1305847167969, 6250.5703125)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 2050 or MyLevel <= 2074 then
                                Ms = "Posessed Mummy [Lv. 2050]" 
                                NaemQuest = "HauntedQuest2"
                                LevelQuest = 2
                                NameMon = "Posessed Mummy"
                                CFrameQuest = CFrame.new(-9514.78027, 171.162918, 6078.82373, 0.301918149, 7.4535027e-09, 0.953333855, -3.22802141e-09, 1, -6.79604995e-09, -0.953333855, -1.02553133e-09, 0.301918149)
                                CFrameMon = CFrame.new(-9589.93848, 4.85058546, 6190.27197)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 2075 or MyLevel <= 2099 then
                                Ms = "Peanut Scout [Lv. 2075]"
                                NaemQuest = "NutsIslandQuest"
                                LevelQuest = 1
                                NameMon = "Peanut Scout"
                                CFrameQuest = CFrame.new(-2075.9643554688, 38.129207611084, -10172.815429688)
                                CFrameMon = CFrame.new(-2150.587890625, 122.49767303467, -10358.994140625)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 2100 or MyLevel <= 2124 then
                                Ms = "Peanut President [Lv. 2100]"
                                NaemQuest = "NutsIslandQuest"
                                LevelQuest = 2
                                NameMon = "Peanut President"
                                CFrameQuest = CFrame.new(-2075.9643554688, 38.129207611084, -10172.815429688)
                                CFrameMon = CFrame.new(-2150.587890625, 122.49767303467, -10358.994140625)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 2125 or MyLevel <= 2149 then
                                Ms = "Ice Cream Chef [Lv. 2125]"
                                NaemQuest = "IceCreamIslandQuest"
                                LevelQuest = 1
                                NameMon = "Ice Cream Chef"
                                CFrameQuest = CFrame.new(-819.84533691406, 65.845329284668, -10965.487304688)
                                CFrameMon = CFrame.new(-890.55895996094, 186.34135437012, -11127.306640625)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 2150 or MyLevel <= 2199 then
                                Ms = "Ice Cream Commander [Lv. 2150]"
                                NaemQuest = "IceCreamIslandQuest"
                                LevelQuest = 2
                                NameMon = "Ice Cream Commander"
                                CFrameQuest = CFrame.new(-819.84533691406, 65.845329284668, -10965.487304688)
                                CFrameMon = CFrame.new(-890.55895996094, 186.34135437012, -11127.306640625)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 2200 or MyLevel <= 2224 then
                                Ms = "Cookie Crafter [Lv. 2200]"
                                NaemQuest = "CakeQuest1"
                                LevelQuest = 1
                                NameMon = "Cookie Crafter"
                                CFrameQuest = CFrame.new(-2022.3, 36.9276, -12031)
                                CFrameMon = CFrame.new(-2280.569091796875, 89.83930206298828, -12041.4326171875)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 2225 or MyLevel <= 2249 then
                                Ms = "Cake Guard [Lv. 2225]"
                                NaemQuest = "CakeQuest1"
                                LevelQuest = 2
                                NameMon = "Cake Guard"
                                CFrameQuest = CFrame.new(-2022.3, 36.9276, -12031)
                                CFrameMon = CFrame.new(-1621.9512939453125, 195.68287658691406, -12281.0908203125)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 2250 or MyLevel <= 2274 then
                                Ms = "Baking Staff [Lv. 2250]"
                                NaemQuest = "CakeQuest2"
                                LevelQuest = 1
                                NameMon = "Baking Staff"
                                CFrameQuest = CFrame.new(-1928.32, 37.7297, -12840.6)
                                CFrameMon = CFrame.new(-1912.928955078125, 113.134033203125, -12990.53515625)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 2275 or MyLevel <= 2299 then
                                Ms = "Head Baker [Lv. 2275]"
                                NaemQuest = "CakeQuest2"
                                LevelQuest = 2
                                NameMon = "Head Baker"
                                CFrameQuest = CFrame.new(-1927.9107666015625, 37.79813003540039, -12843.78515625)
                                CFrameMon = CFrame.new(-2203.302490234375, 109.90937042236328, -12788.7333984375)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 2300 or MyLevel <= 2324 then
                                Ms = "Cocoa Warrior [Lv. 2300]"
                                NaemQuest = "ChocQuest1"
                                LevelQuest = 1
                                NameMon = "Cocoa Warriors"
                                CFrameQuest = CFrame.new(231.75, 23.9003, -12200.3)
                                CFrameMon = CFrame.new(89.75547790527344, 73.66654968261719, -12315.4609375)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 2325 or MyLevel <= 2349 then
                                Ms = "Chocolate Bar Battler [Lv. 2325]"
                                NaemQuest = "ChocQuest1"
                                LevelQuest = 2
                                NameMon = "Chocolate Bar Battler"
                                CFrameQuest = CFrame.new(231.75, 23.9003, -12200.3)
                                CFrameMon = CFrame.new(614.6710205078125, 81.79888153076172, -12578.4521484375)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel == 2350 or MyLevel <= 2374 then
                                Ms = "Sweet Thief [Lv. 2350]"
                                NaemQuest = "ChocQuest2"
                                LevelQuest = 1
                                NameMon = "Sweet Thiefs"
                                CFrameQuest = CFrame.new(147.222900390625, 24.819623947143555, -12775.2890625)
                                CFrameMon = CFrame.new(-92.28578186035156, 132.29556274414062, -12655.9111328125)
                            if _G.AUTOFARM and _G.By_Pass and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                                game.Players.LocalPlayer.Character.Head:Destroy()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                                wait(1)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                            elseif MyLevel >= 2399 or MyLevel <= 2424 then
                                Ms = "Candy Pirate [Lv. 2400]"
                                NaemQuest = "CandyQuest1"
                                LevelQuest = 1
                                NameMon = "Candy Pirates"
                                CFrameQuest = CFrame.new(-1145.725830078125, 14.107256889343262, -14444.6884765625)
								CFrameMon = CFrame.new(-1419.528076171875, 20.38145637512207, -14322.8681640625)
							elseif MyLevel >= 2425 then
                                Ms = "Candy Rebel [Lv. 2375]"
                                NaemQuest = "ChocQuest2"
                                LevelQuest = 2
                                NameMon = "Candy Rebel"
                                CFrameQuest = CFrame.new(147.222900390625, 24.819623947143555, -12775.2890625)
                                CFrameMon = CFrame.new(66.337265, 27.430994, -12946.5674, -0.825375617, -7.78806708e-08, -0.564584017, -5.46535652e-08, 1, -5.80444244e-08, 0.564584017, -1.70519225e-08, -0.825375617)
                        end
                    end
                end
                
                local fastwait,slowwait = task.wait(),wait()

                spawn(function()
                    while wait() do
                        if sethiddenproperty then
                            sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius", math.huge);
                        end 
                        if setscriptable then
                            setscriptable(game.Players.LocalPlayer, "SimulationRadius", true)
                            game.Players.LocalPlayer.SimulationRadius = math.huge * math.huge, math.huge * math.huge * 1 / 0 * 1 / 0 * 1 / 0 * 1 / 0 * 1 / 0;
                        end
                    end
                end)

                setfflag("HumanoidParallelRemoveNoPhysics", "False");
                setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False");
                setfflag("CrashPadUploadToBacktraceToBacktraceBaseUrl", "");
                setfflag("CrashUploadToBacktracePercentage", "0");
                setfflag("CrashUploadToBacktraceBlackholeToken", "");
                setfflag("CrashUploadToBacktraceWindowsPlayerToken", "");
                
                local r=game:GetService("Players").LocalPlayer

                getgenv().ToTarget=function(p)
                    task.spawn(function()
                        pcall(function()
                            if r:DistanceFromCharacter(p.Position)<=300 then
                                r.Character.HumanoidRootPart.CFrame=p
                            else if not game.Players.LocalPlayer.Character:FindFirstChild("Root")then
                                local K=Instance.new("Part",game.Players.LocalPlayer.Character)
                                K.Size=Vector3.new(1,0.5,1)
                                K.Name="Root"
                                K.Anchored=true
                                K.Transparency=1
                                K.CanCollide=false
                                K.CFrame=game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame*CFrame.new(0,20,0)
                            end
                            
                            local U=(game.Players.LocalPlayer.Character.HumanoidRootPart.Position-p.Position).Magnitude
                            local z=game:service("TweenService")
                            local B=TweenInfo.new((p.Position-game.Players.LocalPlayer.Character.Root.Position).Magnitude/300,Enum.EasingStyle.Linear)
                            local S,g=pcall(function()
                                local q=z:Create(game.Players.LocalPlayer.Character.Root,B,{CFrame=p})
                                q:Play()
                            end)

                            if not S then 
                                return g
                            end
                            
                            game.Players.LocalPlayer.Character.Root.CFrame=game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                            
                            if S and game.Players.LocalPlayer.Character:FindFirstChild("Root")then
                                pcall(function()
                                    if(game.Players.LocalPlayer.Character.HumanoidRootPart.Position-p.Position).Magnitude>=20 then
                                        spawn(function()
                                            pcall(function()if(game.Players.LocalPlayer.Character.Root.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude>150 then game.Players.LocalPlayer.Character.Root.CFrame=game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                            else game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players.LocalPlayer.Character.Root.CFrame
                                            end
                                        end)
                                    end)
                                
                                elseif(game.Players.LocalPlayer.Character.HumanoidRootPart.Position-p.Position).Magnitude>=10 and(game.Players.LocalPlayer.Character.HumanoidRootPart.Position-p.Position).Magnitude<20 then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=p
                                elseif(game.Players.LocalPlayer.Character.HumanoidRootPart.Position-p.Position).Magnitude<10 then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=p
                                end
                            end)
                        end
                    end
                end)
            end)
        end

        spawn(function()
            game:GetService("RunService").Heartbeat:Connect(function()
                if _G.AUTOFARM then
                    setfflag("HumanoidParallelRemoveNoPhysics", "False")
                    setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
                    game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(11)
                end
            end)
        end)

        task.spawn(function()
            _G.Type=math.random(1,5);
            while task.wait(.2) do
                _G.Type=math.random(1,5);
            end;
        end);

        require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework.Particle.SlashHit).playAt = function() return nil end;
        getgenv().A = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib).wrapAttackAnimationAsync 
        getgenv().B = require(game.Players.LocalPlayer.PlayerScripts.CombatFramework.Particle).play
        
        spawn(function()
            while wait() do
                if _G.AUTOFARM then
                    pcall(function()
                        require(game:GetService("ReplicatedStorage").CombatFramework.RigLib).wrapAttackAnimationAsync =function(a1,a2,a3,a4,a5)
                            local GetBladeHits = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib).getBladeHits(a2,a3,a4)
                            if GetBladeHits then
                                require(game:GetService("ReplicatedStorage").CombatFramework.RigLib).play = function() end;
                                a1:Play(0.1, 0.1, 0.1);
                                a5(GetBladeHits);
                                require(game:GetService("ReplicatedStorage").CombatFramework.RigLib).play = getgenv().B
                                a1:Stop();
                            end;
                        end;
                    end);
                end
            end;
        end);

        getgenv().BringMobs = function(F, z)
            coroutine.wrap(function()
                pcall(function()
                    for U, d in pairs(game.Workspace.Enemies:GetChildren()) do
                        if d:FindFirstChild("Humanoid") and d:FindFirstChild("HumanoidRootPart") and (d.Name == z) then
                            if isnetworkowner ~= nil and isnetworkowner(d:FindFirstChild("HumanoidRootPart")) then
                                d:FindFirstChild("HumanoidRootPart").Transparency = 1
                                d:FindFirstChild("Humanoid"):ChangeState(11)
                                d:FindFirstChild("HumanoidRootPart").Size = Vector3.new(60,60,60)
                                d:FindFirstChild("Humanoid").WalkSpeed = 0
                                d:FindFirstChild("Humanoid").JumpPower = 0
                                if not d:FindFirstChild("HumanoidRootPart"):FindFirstChild("BV") then
                                    local m = Instance.new("BodyVelocity")
                                    m.Parent = d:FindFirstChild("HumanoidRootPart")
                                    m.Name = "BV"
                                    m.MaxForce = Vector3.new(100000, 100000, 100000)
                                    m.Velocity = Vector3.new(0, 0, 0)
                                end
                                if d:FindFirstChild("Humanoid"):FindFirstChild("Animator") then
                                    d:FindFirstChild("Humanoid"):FindFirstChild("Animator"):Remove()
                                end
                                d:FindFirstChild("HumanoidRootPart").CFrame = F
                                sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
                            elseif (F.Position - d.HumanoidRootPart.Position).magnitude < 300 then
                                d:FindFirstChild("HumanoidRootPart").Transparency = 1
                                d:FindFirstChild("Humanoid"):ChangeState(11)
                                d:FindFirstChild("HumanoidRootPart").Size = Vector3.new(60,60,60)
                                d:FindFirstChild("Humanoid").WalkSpeed = 0
                                d:FindFirstChild("Humanoid").JumpPower = 0
                                if not d:FindFirstChild("HumanoidRootPart"):FindFirstChild("BV") then
                                    local u = Instance.new("BodyVelocity")
                                    u.Parent = d:FindFirstChild("HumanoidRootPart")
                                    u.Name = "BV"
                                    u.MaxForce = Vector3.new(100000, 100000, 100000)
                                    u.Velocity = Vector3.new(0, 0, 0)
                                end
                                if d:FindFirstChild("Humanoid"):FindFirstChild("Animator") then
                                    d:FindFirstChild("Humanoid"):FindFirstChild("Animator"):Remove()
                                end
                                d:FindFirstChild("HumanoidRootPart").CFrame = F
                                sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
                            end
                        end
                    end
                end)
            end)()
        end

        spawn(function()
            pcall(function()
                while wait() do
                    if _G.AUTOFARM then
                        if game.Players.LocalPlayer.Character.Humanoid.Health <= 0 then
                            game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible = false
                        end
                    end
                end
            end)
        end)

        spawn(function()
            while task.wait() do
                pcall(function()
                    CheckQuest()
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if _G.AUTOFARM then
                            if v.Name == Ms and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                if v.Name == Ms then
                                    if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 400 then
                                    if isnetworkowner(v.HumanoidRootPart) then
                                        v.Head.CanCollide = false
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                        v.HumanoidRootPart.CFrame = PosMon
                                        if v.Humanoid:FindFirstChild("Animator") then
                                        v.Humanoid.Animator:Destroy()
                                        end
                                        v.Humanoid:ChangeState(14)
                                        v.Humanoid.JumpPower = 0
                                        v.Humanoid.WalkSpeed = 0
                                        sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  math.huge)
                                        end
                                    end
                                end
                            elseif v.Name == "Factory Staff [Lv. 800]" then
                                    if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 150 then
                                    if isnetworkowner(v.HumanoidRootPart) then
                                        v.Head.CanCollide = false
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                        v.HumanoidRootPart.CFrame = PosMon
                                        v.Humanoid.Sit = true
                                        v.Humanoid.PlatformStand = true
                                        if v.Humanoid:FindFirstChild("Animator") then
                                        v.Humanoid.Animator:Destroy()
                                        end
                                        v.Humanoid:ChangeState(14)
                                        v.Humanoid.JumpPower = 0
                                        v.Humanoid.WalkSpeed = 0
                                        sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                        end
                                    end
                            elseif v.Name == "Monkey [Lv. 14]" then
                                    if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 100 then
                                    if isnetworkowner(v.HumanoidRootPart) then
                                        v.Head.CanCollide = false
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                        v.HumanoidRootPart.CFrame = PosMon
                                        v.Humanoid.Sit = true
                                        v.Humanoid.PlatformStand = true
                                        if v.Humanoid:FindFirstChild("Animator") then
                                        v.Humanoid.Animator:Destroy()
                                        end
                                        v.Humanoid:ChangeState(14)
                                        v.Humanoid.JumpPower = 0
                                        v.Humanoid.WalkSpeed = 0
                                        sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                    end
                                    elseif v.Name == "Snowman [Lv. 100]" then
                                        if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 100 then
                                        if isnetworkowner(v.HumanoidRootPart) then
                                        v.Head.CanCollide = false
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                        v.HumanoidRootPart.CFrame = PosMon
                                        v.Humanoid.Sit = true
                                        v.Humanoid.PlatformStand = true
                                        if v.Humanoid:FindFirstChild("Animator") then
                                        v.Humanoid.Animator:Destroy()
                                        end
                                        v.Humanoid:ChangeState(14)
                                        v.Humanoid.JumpPower = 0
                                        v.Humanoid.WalkSpeed = 0
                                        sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                        end
                                        end
                                    end
                                end
                            end
                        end
                    end)
                end
            end)

            spawn(function()
                while task.wait() do
                    if _G.AUTOFARM then
                        pcall(function()
                        if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                            MagnetActive = false;
                                CheckQuest();
                                getgenv().ToTargets(CFrameQuest);
                                if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude <= 20 then
                                    CheckQuest();
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameQuest
                                    task.wait(.5);
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NaemQuest, LevelQuest);
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint");
                                end;
                            elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                                pcall(function()
                                    CheckQuest();
                                    if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
                                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                            if v.Name == Ms and v:FindFirstChild("Humanoid") then
                                                if v.Humanoid.Health > 0 then
                                                    repeat task.wait()
                                                        if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
                                                            if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) then
                                                                getgenv().ToTargets(v.HumanoidRootPart.CFrame*CFrame.new(0,40,0))
                                                                Attack()
                                                                if isnetworkowner(v.HumanoidRootPart) then
                                                                v.HumanoidRootPart.CanCollide = false;
                                                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                                                PosMon = v.HumanoidRootPart.CFrame
                                                                v.Humanoid.JumpPower = 0;
                                                                v.Humanoid.WalkSpeed = 0;
                                                                v.HumanoidRootPart.CanCollide = false
                                                                if v.Humanoid:FindFirstChild("Animator") then
                                                                    v.Humanoid.Animator:Destroy();
                                                                end;
                                                                v.Humanoid:ChangeState(14);
                                                                else
                                                                v.HumanoidRootPart.CanCollide = false;
                                                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                                                PosMon = v.HumanoidRootPart.CFrame
                                                                v.Humanoid.JumpPower = 0;
                                                                v.Humanoid.WalkSpeed = 0;
                                                                v.HumanoidRootPart.CanCollide = false;
                                                                if v.Humanoid:FindFirstChild("Animator") then
                                                                    v.Humanoid.Animator:Destroy();
                                                                end;
                                                                v.Humanoid:ChangeState(14);
                                                                end;
                                                            
                                                                MagnetActive = true;
                                                            else
                                                                MagnetActive = false   ; 
                                                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest");
                                                            end
                                                        else
                                                            MagnetActive = false;
                                                            CheckQuest();
                                                            getgenv().ToTargets(CFrameMon);
                                                        end
                                                    until not v.Parent or v.Humanoid.Health <= 0 or _G.AUTOFARM == false or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
                                                end;
                                            end;
                                        end;
                                    else
                                        MagnetActive = false;
                                        CheckQuest();
                                        getgenv().ToTargets(CFrameMon);
                                        if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameMon.Position).Magnitude <= 20 then
                                            PUK()
                                        end
                                    end;
                                end);
                            end;
                        end);
                    end;
                end;
            end);

            spawn(function()
                while task.wait() do
                    pcall(function()
                        for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                            if v:FindFirstChild("Humanoid") then
                                if v.Humanoid.Health <= 0 then
                                    v.Parent = game.Workspace
                                end
                            end
                        end
                    end)
                end
            end)

            spawn(function()
                while task.wait() do
                    pcall(function()
                        setfflag("HumanoidParallelRemoveNoPhysics", "False")
                        setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
                    end)
                end
            end)

            local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
