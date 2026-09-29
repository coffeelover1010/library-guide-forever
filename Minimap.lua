local name, A = ...
local icons

function A.SetMinimapShown(shown)
 if not icons then return end
 A.db.minimap.hide = not shown
 icons[shown and "Show" or "Hide"](icons, name)
end

function A.ShowMinimap()
 A.SetMinimapShown(true)
end

local events = CreateFrame("Frame")
events:RegisterEvent("PLAYER_LOGIN")
events:SetScript("OnEvent", function(self)
 self:UnregisterEvent("PLAYER_LOGIN")
 A.db.minimap = A.db.minimap or {minimapPos = 220, hide = false}
 icons = LibStub("LibDBIcon-1.0")
 local launcher = LibStub("LibDataBroker-1.1"):NewDataObject(name, {
  type = "launcher",
  text = "Library Guide Forever",
  icon = "Interface\\Icons\\INV_Misc_Book_09",
  OnClick = function(_, button)
   if button == "LeftButton" then A.Toggle() end
  end,
  OnTooltipShow = function(tooltip)
   tooltip:AddLine("Library Guide Forever", 0.88, 0.73, 0.44)
   tooltip:AddLine("Left-click to open or close your book journal.", 1, 1, 1)
   tooltip:AddLine("Drag to move around the minimap.", 1, 1, 1)
   tooltip:AddLine("/library minimap hide to hide this icon.", 1, 1, 1)
   if A.progress then
    tooltip:AddLine(A.progress.donated .. " / 20 confirmed donations", 0.43, 0.86, 0.62)
   end
  end,
 })
 icons:Register(name, launcher, A.db.minimap)
end)
