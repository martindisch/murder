local function RoleDialog()
	local menu = vgui.Create("DFrame")
	menu:SetSize(400, 110)
	menu:SetPos(ScrW() / 2 - 200, ScrH() / 2 - 50)
	menu:SetTitle("Select Role")
	menu:MakePopup()
	
	local text = vgui.Create("DLabel", menu)
	text:SetText("What would you rather be?")
	text:SizeToContents()
	text:SetPos(1, 30)
	text:CenterHorizontal()
	
	local bM = vgui.Create("DButton", menu)
	bM:SetText("Murderer")
	bM.DoClick = function()
		RunConsoleCommand("RoleSelect", "Murderer")
	end
	bM:SetSize( 100, 40 )
	bM:SetPos(10, menu:GetTall() - 10 - bM:GetTall())
	
	local bC = vgui.Create("DButton", menu)
	bC:SetText("Gunman")
	bC.DoClick = function()
		RunConsoleCommand("RoleSelect", "Gunman")
	end
	bC:SetSize( 100, 40 )
	bC:SetPos(1, menu:GetTall() - 10 - bC:GetTall())
	bC:CenterHorizontal()
	
	local bA = vgui.Create("DButton", menu)
	bA:SetText("Both")
	bA.DoClick = function()
		RunConsoleCommand("RoleSelect", "Both")
	end
	bA:SetSize( 100, 40 )
	bA:SetPos(menu:GetWide() - 10 - bA:GetWide(), menu:GetTall() - 10 - bA:GetTall())
end
usermessage.Hook("RoleDialog", RoleDialog)