-- PERSISTENCE EXPLOIT TESTER - FIXED VERSION
-- No more nil value errors 💯

-- Wait for everything to load properly
wait(2)

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
if not player then
    warn("Player not found!")
    return
end

-- Wait for PlayerGui
local playerGui = player:WaitForChild("PlayerGui", 10)
if not playerGui then
    warn("PlayerGui not found!")
    return
end

-- Destroy any existing GUI to prevent conflicts
local existingGui = playerGui:FindFirstChild("PersistenceTestGUI")
if existingGui then
    existingGui:Destroy()
    wait(0.5)
end

-- Create GUI with error handling
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PersistenceTestGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Try to parent to PlayerGui safely
local success = pcall(function()
    screenGui.Parent = playerGui
end)

if not success then
    warn("Failed to create GUI!")
    return
end

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 500)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Rounded corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleBar

-- Title Text
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -40, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "PERSISTENCE TESTER"
titleLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = titleBar

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextScaled = true
closeButton.Font = Enum.Font.GothamBold
closeButton.BorderSizePixel = 0
closeButton.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 5)
closeCorner.Parent = closeButton

-- Content Frame
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -60)
contentFrame.Position = UDim2.new(0, 10, 0, 50)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Status Display
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 30)
statusLabel.Position = UDim2.new(0, 0, 0, 0)
statusLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
statusLabel.Text = "STATUS: READY"
statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.Gotham
statusLabel.BorderSizePixel = 0
statusLabel.Parent = contentFrame

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 5)
statusCorner.Parent = statusLabel

-- Item Count Display
local itemCountLabel = Instance.new("TextLabel")
itemCountLabel.Size = UDim2.new(1, 0, 0, 30)
itemCountLabel.Position = UDim2.new(0, 0, 0, 40)
itemCountLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
itemCountLabel.Text = "SAVED ITEMS: 0"
itemCountLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
itemCountLabel.TextScaled = true
itemCountLabel.Font = Enum.Font.Gotham
itemCountLabel.BorderSizePixel = 0
itemCountLabel.Parent = contentFrame

local itemCorner = Instance.new("UICorner")
itemCorner.CornerRadius = UDim.new(0, 5)
itemCorner.Parent = itemCountLabel

-- Buttons
local buttonY = 80
local buttonHeight = 40
local buttonSpacing = 50

-- Exploit Button
local exploitButton = Instance.new("TextButton")
exploitButton.Size = UDim2.new(1, 0, 0, buttonHeight)
exploitButton.Position = UDim2.new(0, 0, 0, buttonY)
exploitButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
exploitButton.Text = "RUN ITEM EXPLOIT"
exploitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
exploitButton.TextScaled = true
exploitButton.Font = Enum.Font.GothamBold
exploitButton.BorderSizePixel = 0
exploitButton.Parent = contentFrame

local exploitCorner = Instance.new("UICorner")
exploitCorner.CornerRadius = UDim.new(0, 8)
exploitCorner.Parent = exploitButton

-- Save Button
local saveButton = Instance.new("TextButton")
saveButton.Size = UDim2.new(1, 0, 0, buttonHeight)
saveButton.Position = UDim2.new(0, 0, 0, buttonY + buttonSpacing)
saveButton.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
saveButton.Text = "SAVE BACKPACK"
saveButton.TextColor3 = Color3.fromRGB(255, 255, 255)
saveButton.TextScaled = true
saveButton.Font = Enum.Font.GothamBold
saveButton.BorderSizePixel = 0
saveButton.Parent = contentFrame

local saveCorner = Instance.new("UICorner")
saveCorner.CornerRadius = UDim.new(0, 8)
saveCorner.Parent = saveButton

-- Load Button
local loadButton = Instance.new("TextButton")
loadButton.Size = UDim2.new(1, 0, 0, buttonHeight)
loadButton.Position = UDim2.new(0, 0, 0, buttonY + buttonSpacing * 2)
loadButton.BackgroundColor3 = Color3.fromRGB(100, 255, 150)
loadButton.Text = "RESTORE ITEMS"
loadButton.TextColor3 = Color3.fromRGB(255, 255, 255)
loadButton.TextScaled = true
loadButton.Font = Enum.Font.GothamBold
loadButton.BorderSizePixel = 0
loadButton.Parent = contentFrame

local loadCorner = Instance.new("UICorner")
loadCorner.CornerRadius = UDim.new(0, 8)
loadCorner.Parent = loadButton

-- Clear Button
local clearButton = Instance.new("TextButton")
clearButton.Size = UDim2.new(1, 0, 0, buttonHeight)
clearButton.Position = UDim2.new(0, 0, 0, buttonY + buttonSpacing * 3)
clearButton.BackgroundColor3 = Color3.fromRGB(150, 100, 255)
clearButton.Text = "CLEAR BACKPACK"
clearButton.TextColor3 = Color3.fromRGB(255, 255, 255)
clearButton.TextScaled = true
clearButton.Font = Enum.Font.GothamBold
clearButton.BorderSizePixel = 0
clearButton.Parent = contentFrame

local clearCorner = Instance.new("UICorner")
clearCorner.CornerRadius = UDim.new(0, 8)
clearCorner.Parent = clearButton

-- Variables
local savedItems = {}
local isProcessing = false

-- Utility Functions
local function updateStatus(message, color)
    statusLabel.Text = "STATUS: " .. message
    statusLabel.TextColor3 = color or Color3.fromRGB(255, 255, 255)
end

local function updateItemCount(count)
    itemCountLabel.Text = "SAVED ITEMS: " .. tostring(count)
end

-- Original Exploit Function (your code)
local function runItemExploit()
    if isProcessing then return end
    isProcessing = true
    
    updateStatus("RUNNING EXPLOIT...", Color3.fromRGB(255, 150, 100))
    
    local backpack = player.Backpack
    if not backpack then
        updateStatus("ERROR: NO BACKPACK", Color3.fromRGB(255, 100, 100))
        isProcessing = false
        return
    end
    
    local itemsAdded = 0
    
    -- Your original exploit code
    for _, item in ipairs(game:GetDescendants()) do
        if item:IsA("Tool") then
            local success = pcall(function()
                local clonedItem = item:Clone()
                clonedItem.Parent = backpack
                
                local stackValue = clonedItem:FindFirstChild("Stack") or Instance.new("IntValue", clonedItem)
                stackValue.Name = "Stack"
                stackValue.Value = 999999
                
                itemsAdded = itemsAdded + 1
            end)
            
            if success then
                wait(0.01) -- Prevent lag
            end
        end
    end
    
    updateStatus("EXPLOIT COMPLETE - " .. itemsAdded .. " ITEMS", Color3.fromRGB(100, 255, 100))
    isProcessing = false
end

-- Save Backpack Function
local function saveBackpack()
    if isProcessing then return end
    isProcessing = true
    
    updateStatus("SAVING BACKPACK...", Color3.fromRGB(255, 200, 100))
    
    local backpack = player.Backpack
    if not backpack then
        updateStatus("ERROR: NO BACKPACK", Color3.fromRGB(255, 100, 100))
        isProcessing = false
        return
    end
    
    savedItems = {}
    
    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then
            local toolData = {
                name = tool.Name,
                stack = tool:FindFirstChild("Stack") and tool.Stack.Value or 1
            }
            table.insert(savedItems, toolData)
        end
    end
    
    updateItemCount(#savedItems)
    updateStatus("SAVED " .. #savedItems .. " ITEMS", Color3.fromRGB(100, 255, 100))
    isProcessing = false
end

-- Load Items Function
local function loadItems()
    if isProcessing then return end
    if #savedItems == 0 then
        updateStatus("NO SAVED ITEMS", Color3.fromRGB(255, 150, 100))
        return
    end
    
    isProcessing = true
    updateStatus("RESTORING ITEMS...", Color3.fromRGB(255, 200, 100))
    
    local backpack = player.Backpack
    if not backpack then
        updateStatus("ERROR: NO BACKPACK", Color3.fromRGB(255, 100, 100))
        isProcessing = false
        return
    end
    
    local restoredCount = 0
    
    for _, toolData in pairs(savedItems) do
        -- Find tool in game and clone it
        for _, item in pairs(game:GetDescendants()) do
            if item:IsA("Tool") and item.Name == toolData.name then
                local success = pcall(function()
                    local clonedTool = item:Clone()
                    
                    local stackValue = clonedTool:FindFirstChild("Stack") or Instance.new("IntValue")
                    stackValue.Name = "Stack"
                    stackValue.Value = toolData.stack
                    stackValue.Parent = clonedTool
                    
                    clonedTool.Parent = backpack
                    restoredCount = restoredCount + 1
                end)
                
                if success then break end
            end
        end
        wait(0.01)
    end
    
    updateStatus("RESTORED " .. restoredCount .. " ITEMS", Color3.fromRGB(100, 255, 100))
    isProcessing = false
end

-- Clear Backpack Function
local function clearBackpack()
    if isProcessing then return end
    isProcessing = true
    
    updateStatus("CLEARING BACKPACK...", Color3.fromRGB(255, 200, 100))
    
    local backpack = player.Backpack
    if backpack then
        for _, tool in pairs(backpack:GetChildren()) do
            if tool:IsA("Tool") then
                tool:Destroy()
            end
        end
    end
    
    updateStatus("BACKPACK CLEARED", Color3.fromRGB(100, 255, 100))
    isProcessing = false
end

-- Event Connections
exploitButton.MouseButton1Click:Connect(runItemExploit)
saveButton.MouseButton1Click:Connect(saveBackpack)
loadButton.MouseButton1Click:Connect(loadItems)
clearButton.MouseButton1Click:Connect(clearBackpack)

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Dragging System
local dragging = false
local dragStart = nil
local startPos = nil

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Auto-restore on character spawn
player.CharacterAdded:Connect(function()
    wait(3) -- Wait for backpack to load
    if #savedItems > 0 then
        updateStatus("AUTO-RESTORING...", Color3.fromRGB(100, 200, 255))
        wait(1)
        loadItems()
    end
end)

updateStatus("READY TO TEST", Color3.fromRGB(100, 255, 100))
print("Persistence Tester loaded successfully!")gradient.Parent = mainFrame

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
