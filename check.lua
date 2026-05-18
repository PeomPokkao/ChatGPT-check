-- [[ Manus Hub: Blox Fruits Full Auto Fruit Hunter ]] --
-- Script สำหรับการหาผลปีศาจ, บินไปเก็บ, เก็บเข้าคลัง, และเปลี่ยนเซิร์ฟเวอร์อัตโนมัติ

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local PlaceId = game.PlaceId

local FRUIT_CHECK_INTERVAL = 5 -- ตรวจสอบผลไม้ทุก 5 วินาที
local HOP_DELAY = 5 -- หน่วงเวลาก่อน Hop Server หลังจากเก็บผลไม้หรือหาไม่เจอ
local TWEEN_SPEED = 1.5 -- ความเร็วในการบินไปหาผลไม้ (วินาที)

local isRunning = false
local currentStatus = "N/A"

-- สร้าง UI สำหรับ Status
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FruitSniper_UI"
ScreenGui.Parent = Player.PlayerGui

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(0, 200, 0, 30)
StatusLabel.Position = UDim2.new(0, 10, 0, 10) -- มุมซ้ายบน
StatusLabel.BackgroundTransparency = 0.5
StatusLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
StatusLabel.TextScaled = true
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.Font = Enum.Font.SourceSansBold
StatusLabel.TextStrokeTransparency = 0
StatusLabel.Text = "Status: " .. currentStatus
StatusLabel.ZIndex = 10
StatusLabel.Parent = ScreenGui

-- สร้างปุ่ม Start/Stop
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 100, 0, 30)
ToggleButton.Position = UDim2.new(0, 10, 0, 50) -- ใต้ Status Label
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleButton.Text = "Start Sniper"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextScaled = true
ToggleButton.Parent = ScreenGui

-- ฟังก์ชันอัปเดต Status UI
local function UpdateStatus(status)
    currentStatus = status
    StatusLabel.Text = "Status: " .. currentStatus
end

-- ฟังก์ชันสำหรับแจ้งเตือน (ถ้า Rayfield UI มีอยู่)
local function Notify(title, content, duration)
    if Rayfield and Rayfield.Notify then
        Rayfield:Notify({
            Title = title,
            Content = content,
            Duration = duration or 5
        })
    else
        warn("Rayfield UI not found. Notifying via print.")
        print(title .. ": " .. content)
    end
end

-- ฟังก์ชันบิน (Tween) ไปยังตำแหน่ง
local function TweenTo(position)
    local tweenInfo = TweenInfo.new(TWEEN_SPEED, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local properties = {CFrame = CFrame.new(position)}
    local tween = TweenService:Create(HumanoidRootPart, tweenInfo, properties)
    tween:Play()
    tween.Completed:Wait()
end

-- ฟังก์ชัน Server Hop
local function ServerHop()
    UpdateStatus("Hopping Server...")
    Notify("Fruit Sniper", "กำลังเปลี่ยนเซิร์ฟเวอร์...", 3)
    
    local function GetNextServer()
        local Success, Result = pcall(function()
            return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"))
        end)
        
        if Success and Result and Result.data then
            for _, server in pairs(Result.data) do
                if server.id ~= game.JobId and server.playing < server.maxPlayers then
                    return server.id
                end
            end
        end
        return nil
    end

    local NewServerId = GetNextServer()
    if NewServerId then
        TeleportService:TeleportToPlaceInstance(PlaceId, NewServerId, Player)
    else
        -- ถ้าหาเซิร์ฟเวอร์เจาะจงไม่ได้ ให้ใช้การ Teleport แบบปกติ
        TeleportService:Teleport(PlaceId, Player)
    end
end

-- ฟังก์ชันหลักของ Fruit Sniper
local function FruitSniperLoop()
    while isRunning do
        UpdateStatus("Searching for fruit...")
        local foundFruit = nil
        
        -- ตรวจหาผลไม้ใน Workspace
        for _, v in pairs(game.Workspace:GetChildren()) do
            -- ตรวจสอบ DroppedFruits (ผลไม้ที่ตกจากต้น) หรือผลไม้ที่ดรอปจากบอส/ผู้เล่น
            if v.Name == "DroppedFruits" and v:FindFirstChildOfClass("Model") then
                foundFruit = v:FindFirstChildOfClass("Model")
                break
            elseif v:IsA("Model") and v:FindFirstChild("Handle") and v.Name:find("Fruit") then -- กรณีผลไม้ที่ดรอปเป็น Model โดยตรง
                foundFruit = v
                break
            end
        end

        if foundFruit and foundFruit:FindFirstChild("Part") then
            UpdateStatus("Found Fruit: " .. foundFruit.Name .. "! Moving...")
            Notify("Fruit Sniper", "พบผลไม้: " .. foundFruit.Name .. "! กำลังบินไปเก็บ...", 5)
            TweenTo(foundFruit.Part.Position)
            
            task.wait(2) -- ให้เวลาในการเก็บผลไม้
            
            -- ตรวจสอบว่าผลไม้ถูกเก็บไปแล้วหรือไม่
            if not foundFruit.Parent then 
                UpdateStatus("Fruit collected! Storing...")
                Notify("Fruit Sniper", "เก็บผลไม้เรียบร้อย! กำลังเก็บเข้าคลัง...", 3)

                local fruitInInventory = nil
                -- ค้นหาผลไม้ใน Backpack ของผู้เล่น
                for _, item in pairs(Player.Backpack:GetChildren()) do
                    if item:IsA("Tool") and item.Name:find("Fruit") then 
                        fruitInInventory = item
                        break
                    end
                end
                
                if fruitInInventory then
                    -- พยายามเก็บผลไม้เข้าคลัง
                    local StoreRemote = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
                    if StoreRemote then
                        StoreRemote = StoreRemote:FindFirstChild("Storage")
                        if StoreRemote then
                            StoreRemote = StoreRemote:FindFirstChild("StoreFruit") -- ชื่อ RemoteEvent ที่พบบ่อย
                            if StoreRemote then
                                StoreRemote:FireServer(fruitInInventory) -- ส่งคำสั่งเก็บผลไม้
                                task.wait(1) -- หน่วงเวลาให้เซิร์ฟเวอร์ประมวลผล
                                if not fruitInInventory.Parent then -- ตรวจสอบว่าผลไม้หายไปจาก Inventory แล้ว (เก็บสำเร็จ)
                                    UpdateStatus("Fruit stored! Hopping...")
                                    Notify("Fruit Sniper", "เก็บผลไม้เข้าคลังเรียบร้อย! กำลังเปลี่ยนเซิร์ฟเวอร์...", 3)
                                    task.wait(HOP_DELAY)
                                    ServerHop()
                                else
                                    UpdateStatus("Failed to store fruit. Hopping...")
                                    Notify("Fruit Sniper", "ไม่สามารถเก็บผลไม้เข้าคลังได้! กำลังเปลี่ยนเซิร์ฟเวอร์...", 3)
                                    task.wait(HOP_DELAY)
                                    ServerHop()
                                end
                            else
                                UpdateStatus("StoreFruit Remote not found. Hopping...")
                                Notify("Fruit Sniper", "ไม่พบ RemoteEvent สำหรับเก็บผลไม้! กำลังเปลี่ยนเซิร์ฟเวอร์...", 3)
                                task.wait(HOP_DELAY)
                                ServerHop()
                            end
                        else
                            UpdateStatus("Storage Remotes not found. Hopping...")
                            Notify("Fruit Sniper", "ไม่พบโฟลเดอร์ Storage Remotes! กำลังเปลี่ยนเซิร์ฟเวอร์...", 3)
                            task.wait(HOP_DELAY)
                            ServerHop()
                        end
                    else
                        UpdateStatus("Remotes folder not found. Hopping...")
                        Notify("Fruit Sniper", "ไม่พบโฟลเดอร์ Remotes! กำลังเปลี่ยนเซิร์ฟเวอร์...", 3)
                        task.wait(HOP_DELAY)
                        ServerHop()
                    end
                else
                    UpdateStatus("Fruit not in inventory after pickup. Hopping...")
                    Notify("Fruit Sniper", "ผลไม้ไม่พบใน Inventory หลังเก็บ! กำลังเปลี่ยนเซิร์ฟเวอร์...", 3)
                    task.wait(HOP_DELAY)
                    ServerHop()
                end
            else
                -- กรณีที่บินไปแล้วแต่ผลไม้ยังอยู่ (อาจมีคนแย่ง หรือมีปัญหา)
                UpdateStatus("Failed to collect fruit. Hopping...")
                Notify("Fruit Sniper", "ไม่สามารถเก็บผลไม้ได้ กำลังเปลี่ยนเซิร์ฟเวอร์...", 3)
                task.wait(HOP_DELAY)
                ServerHop()
            end
        else
            UpdateStatus("No fruit found. Hopping...")
            Notify("Fruit Sniper", "ไม่พบผลไม้ กำลังเปลี่ยนเซิร์ฟเวอร์...", 3)
            task.wait(HOP_DELAY)
            ServerHop()
        end
        task.wait(FRUIT_CHECK_INTERVAL) -- หน่วงเวลาก่อนตรวจสอบอีกครั้ง (ถ้ายังไม่ Hop)
    end
    UpdateStatus("Stopped")
end

-- เชื่อมต่อปุ่ม Start/Stop
ToggleButton.MouseButton1Click:Connect(function()
    isRunning = not isRunning
    if isRunning then
        ToggleButton.Text = "Stop Sniper"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- สีแดงเมื่อทำงาน
        spawn(FruitSniperLoop)
        Notify("Fruit Sniper", "เริ่มทำงานแล้ว!", 3)
    else
        ToggleButton.Text = "Start Sniper"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- สีเทาเมื่อหยุด
        Notify("Fruit Sniper", "หยุดทำงานแล้ว!", 3)
    end
end)

Notify("Fruit Sniper", "Script โหลดแล้ว! กดปุ่ม 'Start Sniper' เพื่อเริ่มหาผลไม้", 5)
