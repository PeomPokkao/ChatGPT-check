-- [[ Manus Hub: AFK Timer & Maru Hub Loader ]] --
-- UI จะอยู่ที่มุมขวาบน แสดงการนับเวลา 1/60 จนถึง 60/60 เมื่ออยู่นิ่ง

local AFK_THRESHOLD = 60
local afkTimer = 0
local lastPos = Vector3.new(0,0,0)
local MaruExecuted = true

-- สร้าง UI มินิมอล
local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
local AFKText = Instance.new("TextLabel", ScreenGui)
AFKText.Size = UDim2.new(0, 150, 0, 30)
AFKText.Position = UDim2.new(1, -160, 0, 10)
AFKText.BackgroundTransparency = 1
AFKText.TextColor3 = Color3.fromRGB(255, 255, 255)
AFKText.TextStrokeTransparency = 0
AFKText.Font = Enum.Font.SourceSansBold
AFKText.TextScaled = true
AFKText.Text = "AFK: 0/" .. AFK_THRESHOLD

-- ระบบตรวจจับ AFK และรันสคริปต์
spawn(function()
    while task.wait(1) do
        local char = game.Players.LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        
        if hrp and not MaruExecuted then
            local currentPos = hrp.Position
            
            -- ตรวจสอบว่าขยับตัวหรือไม่ (ถ้านิ่งเกิน 0.5 Studs ถือว่า AFK)
            if (currentPos - lastPos).Magnitude < 0.5 then
                afkTimer = afkTimer + 1
                AFKText.Text = "AFK: " .. afkTimer .. "/" .. AFK_THRESHOLD
                AFKText.TextColor3 = Color3.fromRGB(255, 255, 0) -- เปลี่ยนเป็นสีเหลืองเมื่อนิ่ง
                
                -- เมื่อครบ 60 วินาที
                if afkTimer >= AFK_THRESHOLD then
                    MaruExecuted = true
                    AFKText.Text = "Loading Maru Hub..."
                    AFKText.TextColor3 = Color3.fromRGB(0, 255, 0) -- สีเขียวเมื่อรัน
                    
                    -- รัน Maru Hub ตาม Key ที่คุณให้มา
                    getgenv().Key = "MARU-GFZ0-NFADQ-5PIX-2QLEE-YNWN"
                    getgenv().id = "868050969336877066"
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/MaruBitkub/main/Mobile.lua"))()
                    
                    task.wait(2)
                    ScreenGui:Destroy() -- ลบ UI ทิ้งหลังรันเสร็จ
                end
            else
                -- ถ้าขยับตัว ให้รีเซ็ตเวลาเป็น 0
                afkTimer = 0
                AFKText.Text = "AFK: 0/" .. AFK_THRESHOLD
                AFKText.TextColor3 = Color3.fromRGB(255, 255, 255) -- สีขาวเมื่อขยับ
            end
            lastPos = currentPos
        end
    end
end)
