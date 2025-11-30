return function(player, args)
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local ownerName = "asc5ndant"

    if not player:FindFirstChild("HoverState") then
        local folder = Instance.new("Folder")
        folder.Name = "HoverState"
        folder.Parent = player
    end
    local hoverState = player.HoverState

    local command = args[1] and args[1]:lower() or "hover"
    if command == "unhover" then
        if hoverState.Connection then
            hoverState.Connection:Disconnect()
            hoverState.Connection = nil
        end
        return
    end

    local targetName = args[2] or ownerName
    local speed = tonumber(args[3]) or 5
    local distance = tonumber(args[4]) or 10

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

    if hoverState.Connection then
        hoverState.Connection:Disconnect()
        hoverState.Connection = nil
    end

    hoverState.Connection = RunService.Heartbeat:Connect(function()
        if not char or not targetPlayer.Character then
            hoverState.Connection:Disconnect()
            hoverState.Connection = nil
            return
        end
        local targetPivot = targetPlayer.Character:GetPivot()
        local offset = Vector3.new(0, distance, 0)
        local desiredCFrame = CFrame.lookAt(targetPivot.Position + offset, targetPivot.Position)
        char:SetPivot(desiredCFrame)
    end)
end
