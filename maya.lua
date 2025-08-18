-- ITEM PERSISTENCE SYSTEM FOR GAME OWNERS ONLY
-- Exploiting your own game for security testing 🔥

local HttpService = game:GetService("HttpService")
local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create GUI (building on previous system)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PersistenceTestGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 500, 0, 700)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -350)
mainFrame.BackgroundColor3 = Color3.new(0.08, 0.08, 0.12)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Gradient
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0.12, 0.12, 0.18)),
    ColorSequenceKeypoint.new(1, Color3.new(0.06, 0.06, 0.1))
}
gradient.Rotation = 45
gradient.Parent = mainFrame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 50)
titleBar.BackgroundColor3 = Color3.new(0.15, 0.15, 0.2)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -50, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🔄 PERSISTENCE EXPLOIT TESTER"
titleLabel.TextColor3 = Color3.new(0.9, 0.9, 1)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = titleBar

-- Content Frame
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -70)
contentFrame.Position = UDim2.new(0, 10, 0, 60)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Status Panel
local statusPanel = Instance.new("Frame")
statusPanel.Size = UDim2.new(1, 0, 0, 100)
statusPanel.BackgroundColor3 = Color3.new(0.1, 0.1, 0.15)
statusPanel.BorderSizePixel = 0
statusPanel.Parent = contentFrame

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 8)
statusCorner.Parent = statusPanel

local warningLabel = Instance.new("TextLabel")
warningLabel.Size = UDim2.new(1, -20, 0, 30)
warningLabel.Position = UDim2.new(0, 10, 0, 5)
warningLabel.BackgroundTransparency = 1
warningLabel.Text = "⚠️ GAME OWNER EXPLOIT TESTING MODE"
warningLabel.TextColor3 = Color3.new(1, 0.6, 0.2)
warningLabel.TextScaled = true
warningLabel.Font = Enum.Font.GothamBold
warningLabel.Parent = statusPanel

local methodLabel = Instance.new("TextLabel")
methodLabel.Size = UDim2.new(1, -20, 0, 20)
methodLabel.Position = UDim2.new(0, 10, 0, 35)
methodLabel.BackgroundTransparency = 1
methodLabel.Text = "📡 METHOD: CLIENT STORAGE + SERVER BYPASS"
methodLabel.TextColor3 = Color3.new(0.7, 0.7, 0.9)
methodLabel.TextScaled = true
methodLabel.Font = Enum.Font.Gotham
methodLabel.Parent = statusPanel

local statusText = Instance.new("TextLabel")
statusText.Name = "StatusText"
statusText.Size = UDim2.new(1, -20, 0, 20)
statusText.Position = UDim2.new(0, 10, 0, 60)
statusText.BackgroundTransparency = 1
statusText.Text = "🔴 PERSISTENCE INACTIVE"
statusText.TextColor3 = Color3.new(0.8, 0.2, 0.2)
statusText.TextScaled = true
statusText.Font = Enum.Font.Gotham
statusText.Parent = statusPanel

local savedItemsLabel = Instance.new("TextLabel")
savedItemsLabel.Name = "SavedItemsLabel"
savedItemsLabel.Size = UDim2.new(1, -20, 0, 20)
savedItemsLabel.Position = UDim2.new(0, 10, 0, 80)
savedItemsLabel.BackgroundTransparency = 1
savedItemsLabel.Text = "💾 SAVED ITEMS: 0"
savedItemsLabel.TextColor3 = Color3.new(0.6, 0.8, 1)
savedItemsLabel.TextScaled = true
savedItemsLabel.Font = Enum.Font.Gotham
savedItemsLabel.Parent = statusPanel

-- Control Buttons Frame
local controlFrame = Instance.new("Frame")
controlFrame.Size = UDim2.new(1, 0, 0, 120)
controlFrame.Position = UDim2.new(0, 0, 0, 110)
controlFrame.BackgroundTransparency = 1
controlFrame.Parent = contentFrame

-- Button 1: Save Current Backpack
local saveButton = Instance.new("TextButton")
saveButton.Size = UDim2.new(1, 0, 0, 35)
saveButton.Position = UDim2.new(0, 0, 0, 0)
saveButton.BackgroundColor3 = Color3.new(0.2, 0.5, 0.8)
saveButton.Text = "💾 SAVE BACKPACK STATE"
saveButton.TextColor3 = Color3.new(1, 1, 1)
saveButton.TextScaled = true
saveButton.Font = Enum.Font.GothamBold
saveButton.BorderSizePixel = 0
saveButton.Parent = controlFrame

local saveCorner = Instance.new("UICorner")
saveCorner.CornerRadius = UDim.new(0, 8)
saveCorner.Parent = saveButton

-- Button 2: Load Saved Items
local loadButton = Instance.new("TextButton")
loadButton.Size = UDim2.new(1, 0, 0, 35)
loadButton.Position = UDim2.new(0, 0, 0, 40)
loadButton.BackgroundColor3 = Color3.new(0.5, 0.2, 0.8)
loadButton.Text = "📥 RESTORE SAVED ITEMS"
loadButton.TextColor3 = Color3.new(1, 1, 1)
loadButton.TextScaled = true
loadButton.Font = Enum.Font.GothamBold
loadButton.BorderSizePixel = 0
loadButton.Parent = controlFrame

local loadCorner = Instance.new("UICorner")
loadCorner.CornerRadius = UDim.new(0, 8)
loadCorner.Parent = loadButton

-- Button 3: Auto-Persist Toggle
local autoButton = Instance.new("TextButton")
autoButton.Name = "AutoButton"
autoButton.Size = UDim2.new(1, 0, 0, 35)
autoButton.Position = UDim2.new(0, 0, 0, 80)
autoButton.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
autoButton.Text = "🔄 ENABLE AUTO-PERSISTENCE"
autoButton.TextColor3 = Color3.new(1, 1, 1)
autoButton.TextScaled = true
autoButton.Font = Enum.Font.GothamBold
autoButton.BorderSizePixel = 0
autoButton.Parent = controlFrame

local autoCorner = Instance.new("UICorner")
autoCorner.CornerRadius = UDim.new(0, 8)
autoCorner.Parent = autoButton

-- Log Frame
local logFrame = Instance.new("ScrollingFrame")
logFrame.Size = UDim2.new(1, 0, 1, -240)
logFrame.Position = UDim2.new(0, 0, 0, 240)
logFrame.BackgroundColor3 = Color3.new(0.05, 0.05, 0.08)
logFrame.BorderSizePixel = 0
logFrame.ScrollBarThickness = 6
logFrame.ScrollBarImageColor3 = Color3.new(0.4, 0.4, 0.6)
logFrame.Parent = contentFrame

local logCorner = Instance.new("UICorner")
logCorner.CornerRadius = UDim.new(0, 8)
logCorner.Parent = logFrame

local logList = Instance.new("UIListLayout")
logList.SortOrder = Enum.SortOrder.LayoutOrder
logList.Padding = UDim.new(0, 2)
logList.Parent = logFrame

-- Variables
local savedItems = {}
local autoPersist = false
local logEntries = {}

-- Storage Keys (for client-side persistence)
local STORAGE_KEY = "ExploitTestBackpack_" .. player.UserId

-- Functions
local function addLogEntry(message, color)
    color = color or Color3.new(0.9, 0.9, 0.9)
    
    local logEntry = Instance.new("TextLabel")
    logEntry.Size = UDim2.new(1, -10, 0, 20)
    logEntry.BackgroundTransparency = 1
    logEntry.Text = os.date("[%H:%M:%S] ") .. message
    logEntry.TextColor3 = color
    logEntry.TextScaled = true
    logEntry.Font = Enum.Font.Code
    logEntry.TextXAlignment = Enum.TextXAlignment.Left
    logEntry.Parent = logFrame
    
    table.insert(logEntries, logEntry)
    logFrame.CanvasSize = UDim2.new(0, 0, 0, #logEntries * 22)
    logFrame.CanvasPosition = Vector2.new(0, logFrame.CanvasSize.Y.Offset)
end

-- METHOD 1: Client-Side Storage (works but resets on new client)
local function saveToClientStorage()
    local backpack = player.Backpack
    if not backpack then return false end
    
    savedItems = {}
    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then
            local toolData = {
                name = tool.Name,
                className = tool.ClassName,
                -- Try to preserve stack values
                stack = tool:FindFirstChild("Stack") and tool.Stack.Value or 1,
                -- Store other important properties
                toolId = tool:GetAttribute("ToolId") or tool.Name,
            }
            table.insert(savedItems, toolData)
        end
    end
    
    -- Use writefile if available (Synapse X style)
    local success = pcall(function()
        if writefile and readfile then
            writefile(STORAGE_KEY .. ".json", HttpService:JSONEncode(savedItems))
            return true
        end
    end)
    
    return success, #savedItems
end

-- METHOD 2: Try to access ReplicatedStorage (if you own the game)
local function tryReplicatedStoragePersist()
    local success = pcall(function()
        -- Create a hidden folder in ReplicatedStorage
        local persistFolder = ReplicatedStorage:FindFirstChild("_PersistData") or Instance.new("Folder")
        persistFolder.Name = "_PersistData"
        persistFolder.Parent = ReplicatedStorage
        
        -- Store player's item data
        local playerData = persistFolder:FindFirstChild(tostring(player.UserId)) or Instance.new("StringValue")
        playerData.Name = tostring(player.UserId)
        playerData.Value = HttpService:JSONEncode(savedItems)
        playerData.Parent = persistFolder
        
        addLogEntry("🔥 SUCCESS: Data stored in ReplicatedStorage!", Color3.new(0.2, 1, 0.2))
        return true
    end)
    
    if not success then
        addLogEntry("⚠️ ReplicatedStorage method failed (expected on client)", Color3.new(1, 0.6, 0.2))
    end
    
    return success
end

local function restoreItems()
    local backpack = player.Backpack
    if not backpack then return end
    
    -- Method 1: Try client storage
    local clientSuccess = pcall(function()
        if readfile then
            local data = readfile(STORAGE_KEY .. ".json")
            savedItems = HttpService:JSONDecode(data)
            return true
        end
    end)
    
    -- Method 2: Try ReplicatedStorage
    local repSuccess = pcall(function()
        local persistFolder = ReplicatedStorage:FindFirstChild("_PersistData")
        if persistFolder then
            local playerData = persistFolder:FindFirstChild(tostring(player.UserId))
            if playerData then
                savedItems = HttpService:JSONDecode(playerData.Value)
                return true
            end
        end
    end)
    
    if not clientSuccess and not repSuccess then
        addLogEntry("❌ No saved data found", Color3.new(1, 0.2, 0.2))
        return
    end
    
    -- Restore items to backpack
    local restoredCount = 0
    for _, toolData in pairs(savedItems) do
        -- Try to find the tool in the game
        for _, item in pairs(game:GetDescendants()) do
            if item:IsA("Tool") and item.Name == toolData.name then
                local clonedTool = item:Clone()
                
                -- Restore stack value
                local stackValue = clonedTool:FindFirstChild("Stack") or Instance.new("IntValue")
                stackValue.Name = "Stack"
                stackValue.Value = toolData.stack or 10
                stackValue.Parent = clonedTool
                
                clonedTool.Parent = backpack
                restoredCount = restoredCount + 1
                
                addLogEntry("✅ Restored: " .. toolData.name .. " (Stack: " .. (toolData.stack or 10) .. ")", Color3.new(0.2, 0.8, 0.2))
                break
            end
        end
    end
    
    addLogEntry("🎉 Restored " .. restoredCount .. " items successfully!", Color3.new(0.2, 1, 0.2))
    savedItemsLabel.Text = "💾 SAVED ITEMS: " .. #savedItems
end

-- Event Handlers
saveButton.MouseButton1Click:Connect(function()
    addLogEntry("💾 Saving current backpack state...", Color3.new(0.2, 0.8, 1))
    
    local success, itemCount = saveToClientStorage()
    
    if success then
        addLogEntry("✅ Saved " .. itemCount .. " items to client storage", Color3.new(0.2, 0.8, 0.2))
        savedItemsLabel.Text = "💾 SAVED ITEMS: " .. itemCount
        
        -- Also try ReplicatedStorage method
        tryReplicatedStoragePersist()
    else
        addLogEntry("⚠️ Client storage unavailable, using memory only", Color3.new(1, 0.6, 0.2))
    end
end)

loadButton.MouseButton1Click:Connect(function()
    addLogEntry("📥 Attempting to restore saved items...", Color3.new(0.2, 0.8, 1))
    restoreItems()
end)

autoButton.MouseButton1Click:Connect(function()
    autoPersist = not autoPersist
    
    if autoPersist then
        autoButton.Text = "🔄 DISABLE AUTO-PERSISTENCE"
        autoButton.BackgroundColor3 = Color3.new(0.6, 0.2, 0.2)
        statusText.Text = "🟢 AUTO-PERSISTENCE ACTIVE"
        statusText.TextColor3 = Color3.new(0.2, 0.8, 0.2)
        
        addLogEntry("🔄 Auto-persistence ENABLED", Color3.new(0.2, 1, 0.2))
        
        -- Auto-save every 30 seconds
        spawn(function()
            while autoPersist do
                wait(30)
                if autoPersist then
                    saveToClientStorage()
                    addLogEntry("🔄 Auto-saved backpack", Color3.new(0.6, 0.8, 1))
                end
            end
        end)
    else
        autoButton.Text = "🔄 ENABLE AUTO-PERSISTENCE"
        autoButton.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
        statusText.Text = "🔴 PERSISTENCE INACTIVE"
        statusText.TextColor3 = Color3.new(0.8, 0.2, 0.2)
        
        addLogEntry("🔄 Auto-persistence DISABLED", Color3.new(0.8, 0.2, 0.2))
    end
end)

-- Auto-restore on spawn (if auto-persist is enabled)
player.CharacterAdded:Connect(function()
    if autoPersist then
        wait(2) -- Let backpack load
        addLogEntry("🔄 Auto-restoring items on respawn...", Color3.new(0.2, 0.8, 1))
        restoreItems()
    end
end)

-- Initial setup
addLogEntry("🛡️ Persistence Exploit Tester initialized", Color3.new(0.2, 0.8, 1))
addLogEntry("⚠️ WARNING: Game owner testing mode only!", Color3.new(1, 0.6, 0.2))
addLogEntry("💡 TIP: Save items, rejoin server, then restore", Color3.new(0.6, 0.8, 1))
