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
    -- Centre the face on the visible hole in the 64px tracking-ring texture.
    do
        local button = icons:GetMinimapButton(name)
        if button and button.border and button.icon then
            local x, y = button.border:GetWidth() * 20 / 64, -button.border:GetHeight() * 19 / 64
            -- Fill the tracking ring's opening; keep its border and hit area standard.
            local faceSize = button.border:GetWidth() * 26 / 64
            button.icon:SetSize(faceSize, faceSize)
            if not button.foreverFaceMask then
                local mask = button:CreateMaskTexture(nil, "ARTWORK")
                mask:SetTexture("Interface\\CharacterFrame\\TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
                mask:SetAllPoints(button.icon)
                button.icon:AddMaskTexture(mask)
                button.foreverFaceMask = mask
            end
            button.icon:ClearAllPoints()
            button.icon:SetPoint("CENTER", button.border, "TOPLEFT", x, y)
            if button.background then
                button.background:ClearAllPoints()
                button.background:SetPoint("CENTER", button.border, "TOPLEFT", x, y)
            end
        end
    end
end)
