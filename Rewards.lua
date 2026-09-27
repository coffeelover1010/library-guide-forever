local _, A = ...
-- IDs verified in the installed Forever item catalogue.
local rewards = {
 {277203, "Scholarly Pendant"},
 {277204, "Erudite's Amulet"},
 {281635, "Philanthropist's Ring"},
 {281634, "Field Researcher's Loop"},
}
local buttons = {}
local function itemLink(id)
 local get = C_Item and C_Item.GetItemInfo or GetItemInfo
 if get then local _, link = get(id); return link end
end
local function request(id)
 if C_Item and C_Item.RequestLoadItemDataByID then C_Item.RequestLoadItemDataByID(id) end
end
local function tooltip(self)
 GameTooltip:SetOwner(self, "ANCHOR_TOP")
 if self.link then
  GameTooltip:SetHyperlink(self.link)
 else
  GameTooltip:SetText(self.reward[2], 0.3, 0.65, 1)
  GameTooltip:AddLine("Loading item details...", 1, 1, 1)
  request(self.reward[1])
 end
 GameTooltip:Show()
end
local function refresh(self)
 self.link = itemLink(self.reward[1])
 self.label:SetText(self.link or ("|cff4da6ff[" .. self.reward[2] .. "]|r"))
end
function A.CreateRewardLinks(parent)
 local positions = {16, 236, 470, 690}
 for i, reward in ipairs(rewards) do
  local b = CreateFrame("Button", nil, parent)
  b.reward = reward; buttons[reward[1]] = b
  b:SetSize(210, 24); b:SetPoint("TOPLEFT", positions[i], -28)
  b.label = b:CreateFontString(nil, "OVERLAY")
  b.label:SetFont("Fonts\\FRIZQT__.TTF", 11, "")
  b.label:SetPoint("LEFT"); b.label:SetWidth(210); b.label:SetJustifyH("LEFT")
  b:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
  b:SetScript("OnEnter", function(self) refresh(self); tooltip(self) end)
  b:SetScript("OnLeave", function() GameTooltip:Hide() end)
  b:SetScript("OnHide", function(self) if GameTooltip:IsOwned(self) then GameTooltip:Hide() end end)
  b:SetScript("OnClick", function(self)
   refresh(self)
   if not self.link then
    request(self.reward[1]); A.Print("Loading " .. self.reward[2] .. ". Please click again in a moment."); return
   end
   if HandleModifiedItemClick and HandleModifiedItemClick(self.link) then return end
   if SetItemRef then SetItemRef(self.link:match("|H(.-)|h"), self.link, "LeftButton", self) end
  end)
  refresh(b)
  if not b.link then request(reward[1]) end
 end
end
local events = CreateFrame("Frame")
events:RegisterEvent("GET_ITEM_INFO_RECEIVED")
events:SetScript("OnEvent", function(_, _, id, success)
 local b = buttons[id]
 if b and success then
  refresh(b)
  if GameTooltip:IsOwned(b) then tooltip(b) end
 end
end)
