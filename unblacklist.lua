local Players = game:GetService("Players")

local TARGET_USERNAME = ""

local LP = Players.LocalPlayer
if not LP then return end

if string.lower(LP.Name) ~= string.lower(TARGET_USERNAME) then
	pcall(function()
		game.StarterGui:SetCore("SendNotification", {
			Title = "Nemesis",
			Text = "This unblacklist is not for your account",
			Duration = 5,
		})
	end)
	return
end

if typeof(getgenv) == "function" then
	pcall(function()
		getgenv().NemesisUnblacklisted = true
		getgenv().NemesisUnblacklistUserId = LP.UserId
	end)
end
_G.NemesisUnblacklisted = true
_G.NemesisUnblacklistUserId = LP.UserId

pcall(function()
	game.StarterGui:SetCore("SendNotification", {
		Title = "Nemesis",
		Text = "your unblacklisted dont do nothing stupid again jackass",
		Duration = 8,
	})
end)
