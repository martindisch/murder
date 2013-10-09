
local menu
function GM:DisplayEndRoundBoard(data)
	if IsValid(menu) then
		menu:Remove()
	end

	menu = vgui.Create("DFrame")
	menu:SetSize(ScrW() * 0.8, ScrH() * 0.8)
	menu:Center()
	menu:SetTitle("")
	menu:MakePopup()

	function menu:Paint()
		surface.SetDrawColor(Color(40,40,40,255))
		surface.DrawRect(0, 0, menu:GetWide(), menu:GetTall())
	end

	local winnerPnl = vgui.Create("DPanel", menu)
	winnerPnl:DockPadding(24,24,24,24)
	winnerPnl:Dock(TOP)
	function winnerPnl:PerformLayout()
		self:SizeToChildren(false, true)
	end
	function winnerPnl:Paint(w, h) 
		surface.SetDrawColor(Color(50,50,50,255))
		surface.DrawRect(2, 2, w - 4, h - 4)
	end

	local winner = vgui.Create("DLabel", winnerPnl)
	winner:Dock(TOP)
	winner:SetFont("MersRadial")
	winner:SetAutoStretchVertical(true)

	if data.reason == 3 then
		winner:SetText("Bystanders win! The murderer rage quit")
		winner:SetTextColor(Color(255, 255, 255))
	elseif data.reason == 2 then
		winner:SetText("Bystanders win!")
		winner:SetTextColor(Color(50, 255, 0))
	elseif data.reason == 1 then
		winner:SetText("The murderer wins!")
		winner:SetTextColor(Color(255, 50, 0))
	end

	local murderer = vgui.Create("DLabel", winnerPnl)
	murderer:Dock(TOP)
	murderer:SetFont("MersRadialSmall")
	murderer:SetAutoStretchVertical(true)
	murderer:SetText("The murderer was " .. data.murdererName)
	local col = data.murdererColor
	murderer:SetTextColor(Color(col.x * 255, col.y * 255, col.z * 255))

	local lootPnl = vgui.Create("DPanel", menu)
	lootPnl:Dock(FILL)
	lootPnl:DockPadding(24,24,24,24)
	function lootPnl:Paint(w, h) 
		surface.SetDrawColor(Color(50,50,50,255))
		surface.DrawRect(2, 2, w - 4, h - 4)
	end

	local desc = vgui.Create("DLabel", lootPnl)
	desc:Dock(TOP)
	desc:SetFont("MersRadial")
	desc:SetAutoStretchVertical(true)
	desc:SetText("Loot Collected")
	
	local lootList = vgui.Create("DPanelList", lootPnl)
	lootList:Dock(FILL)

	table.sort(data.collectedLoot, function (a, b)
		return a.count > b.count
	end)

	for k, v in pairs(data.collectedLoot) do
		if !v.playerName then continue end
		local pnl = vgui.Create("DPanel")
		pnl:SetTall(draw.GetFontHeight("MersRadialSmall"))
		function pnl:Paint(w, h)
		end
		function pnl:PerformLayout()
			if self.NamePnl then
				self.NamePnl:SetWidth(self:GetWide() * 0.8)
			end
			self:SizeToChildren(false, true)
		end

		local name = vgui.Create("DLabel", pnl)
		pnl.NamePnl = name
		name:Dock(LEFT)
		name:SetAutoStretchVertical(true)
		name:SetText(v.playerName)
		name:SetFont("MersRadialSmall")
		local col = v.playerColor
		name:SetTextColor(Color(col.x * 255, col.y * 255, col.z * 255))

		local count = vgui.Create("DLabel", pnl)
		pnl.CountPnl = count
		count:Dock(FILL)
		count:SetAutoStretchVertical(true)
		count:SetText(tostring(v.count))
		count:SetFont("MersRadialSmall")
		local col = v.playerColor
		count:SetTextColor(Color(col.x * 255, col.y * 255, col.z * 255))

		lootList:AddItem(pnl)
	end

end