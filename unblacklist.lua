local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local TARGET_USERNAME = ""

local LP = Players.LocalPlayer
if not LP then return end

if string.lower(LP.Name) ~= string.lower(TARGET_USERNAME) then
	return
end

local function ensureFolders()
	if typeof(makefolder) ~= "function" then return end
	pcall(makefolder, "Nemesis")
	pcall(makefolder, "Nemesis/Settings")
end

ensureFolders()

local path = "Nemesis/Settings/Unblacklist.json"
local data = {
	username = LP.Name,
	userId = LP.UserId,
	users = {
		[string.lower(LP.Name)] = true,
		[tostring(LP.UserId)] = true,
	},
	at = os.time(),
}

pcall(function()
	if typeof(writefile) == "function" then
		writefile(path, HttpService:JSONEncode(data))
	end
end)

if typeof(getgenv) == "function" then
	pcall(function()
		getgenv().NemesisUnblacklisted = true
		getgenv().NemesisUnblacklistUserId = LP.UserId
		getgenv().NemesisBlacklisted = false
	end)
end
_G.NemesisUnblacklisted = true
_G.NemesisUnblacklistUserId = LP.UserId
_G.NemesisBlacklisted = false

local guiParent = (typeof(gethui) == "function" and gethui()) or LP:WaitForChild("PlayerGui")
pcall(function()
	local old = guiParent:FindFirstChild("NemesisUnblacklistMsg")
	if old then old:Destroy() end
end)

local gui = Instance.new("ScreenGui")
gui.Name = "NemesisUnblacklistMsg"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = guiParent

local label = Instance.new("TextLabel")
label.BackgroundTransparency = 1
label.AnchorPoint = Vector2.new(0.5, 0.5)
label.Position = UDim2.new(0.5, 0, 0.5, 0)
label.Size = UDim2.new(0.9, 0, 0, 80)
label.Font = Enum.Font.GothamBold
label.Text = "your unblacklisted dont do nothing stupid again jackass"
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.TextSize = 28
label.TextWrapped = true
label.TextTransparency = 1
label.ZIndex = 100
label.Parent = gui

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(0, 0, 0)
stroke.Thickness = 1.5
stroke.Transparency = 1
stroke.Parent = label

TweenService:Create(label, TweenInfo.new(0.35), {TextTransparency = 0}):Play()
TweenService:Create(stroke, TweenInfo.new(0.35), {Transparency = 0.2}):Play()

task.delay(5, function()
	pcall(function()
		TweenService:Create(label, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
		TweenService:Create(stroke, TweenInfo.new(0.4), {Transparency = 1}):Play()
	end)
	task.delay(0.45, function()
		pcall(function()
			if gui then gui:Destroy() end
		end)
	end)
end)
