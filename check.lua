local AFK_THRESHOLD = 60
local afkTimer = 0
local MaruExecuted = true

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

spawn(function()
    while task.wait(1) do
        local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp and not MaruExecuted then
            if hrp.Velocity.Magnitude < 0.1 then
                afkTimer = afkTimer + 1
                AFKText.Text = "AFK: " .. afkTimer .. "/" .. AFK_THRESHOLD
                AFKText.TextColor3 = Color3.fromRGB(255, 255, 0)
                if afkTimer >= AFK_THRESHOLD then
                    MaruExecuted = true
                    AFKText.Text = "Loading Maru Hub..."
                    AFKText.TextColor3 = Color3.fromRGB(0, 255, 0)
                    getgenv().Key = "MARU-GFZ0-NFADQ-5PIX-2QLEE-YNWN"
                    getgenv().id = "868050969336877066"
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/MaruBitkub/main/Mobile.lua"))()
                    task.wait(2)
                    ScreenGui:Destroy()
                end
            else
                afkTimer = 0
                AFKText.Text = "AFK: 0/" .. AFK_THRESHOLD
                AFKText.TextColor3 = Color3.fromRGB(255, 255, 255)
            end
        end
    end
end)
