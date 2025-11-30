return function(player, args)
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")

    local ownerName = "asc5ndant"
    local targetName = args[1] or ownerName
    local speed = tonumber(args[2]) or 5
    local distance = tonumber(args[3]) or 10

    local targetPlayer
    for _, p in next, Players:GetPlayers() do
        if p.Name:lower():sub(1,#targetName) == targetName:lower() or
           p.DisplayName:lower():sub(1,#targetName) == targetName:lower() then
            targetPlayer = p
            break
        end
    end

    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") or not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return
    end

    local conn
    conn = RunService.Heartbeat:Connect(function(deltaTime)
        if not char or not targetPlayer.Character then
            conn:Disconnect()
            return
        end

        local targetPivot = targetPlayer.Character:GetPivot()
        local offset = Vector3.new(0, distance, 0)
        local desiredCFrame = CFrame.lookAt(targetPivot.Position + offset, targetPivot.Position)
        char:SetPivot(desiredCFrame)
    end)
end
