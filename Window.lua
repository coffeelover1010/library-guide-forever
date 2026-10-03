local _, A = ...
local gold={0.88,0.73,0.44}
local statusText={missing="TO FIND",bags="IN BAGS",bank="IN BANK*",donated="TURNED IN",manual="MARKED BY YOU",seen="SEEN BEFORE",unknown="SCAN UNAVAILABLE"}
local colors={missing={0.65,0.69,0.76},bags={0.42,0.83,0.96},bank={0.62,0.65,0.96},donated={0.43,0.86,0.62},manual={0.95,0.72,0.35},seen={0.85,0.65,0.42},unknown={0.95,0.5,0.4}}
local filters={"Route","To find","Carried","Donated","All"}
local filter="All"
local selected=A.books[1]
local rows={}
local function panel(parent,w,h,x,y,r,g,b)
 local f=CreateFrame("Frame",nil,parent,"BackdropTemplate")
 f:SetSize(w,h); f:SetPoint("TOPLEFT",x,y)
 f:SetBackdrop({bgFile="Interface\\Buttons\\WHITE8X8",edgeFile="Interface\\Buttons\\WHITE8X8",edgeSize=1})
 f:SetBackdropColor(r,g,b,1); f:SetBackdropBorderColor(0.34,0.29,0.21,1)
 return f
end
local function text(parent,size,x,y,width,color)
 local t=parent:CreateFontString(nil,"OVERLAY")
 t:SetFont("Fonts\\FRIZQT__.TTF",size,"")
 t:SetPoint("TOPLEFT",x,y); if width then t:SetWidth(width) end
 t:SetJustifyH("LEFT"); t:SetJustifyV("TOP")
 color=color or {0.91,0.9,0.86}; t:SetTextColor(unpack(color))
 return t
end
local function button(parent,label,w,x,y,fn)
 local b=CreateFrame("Button",nil,parent,"UIPanelButtonTemplate")
 b:SetSize(w,26); b:SetPoint("TOPLEFT",x,y); b:SetText(label); b:SetScript("OnClick",fn)
 return b
end
local function detail()
 local f=A.window; if not f then return end
 local b=selected; local s=A.state[b[1]] or {status="unknown"}
 f.bookTitle:SetText(b[3]); f.bookZone:SetText(A.BookLocation(b))
 local recommendation,reason=A.Recommendation(b)
 f.bookRecommendation:SetText(recommendation)
 f.bookStatus:SetText(statusText[s.status]); f.bookStatus:SetTextColor(unpack(colors[s.status]))
 local explanation="Not in your bags and no completed donation was detected."
 if s.status=="donated" then explanation="Your character's completed quest flag or observed turn-in confirms this donation."
 elseif s.status=="bags" then explanation="You already have this book in your bags. Bring it to the librarian."
 elseif s.status=="bank" then explanation="The inventory API reports this book outside your bags. Visit your bank to refresh its cached count, then withdraw it."
 elseif s.status=="manual" then explanation="You marked this donation yourself. It is kept separate from game-confirmed progress."
 elseif s.status=="seen" then explanation="Seen in your inventory before, but not owned now. This does NOT confirm a donation; check with the librarian."
 elseif s.status=="unknown" then explanation="The inventory check is unavailable. Do not assume this book is missing." end
 f.bookNotes:SetText(b[8].."\n\n"..explanation)
 f.bookEvidence:SetText("Item "..b[1].."  /  "..(b[2] and ("Quest "..b[2]) or "Hand-in unconfirmed").."\nCommunity reports • catalogue checked 29 Sep 2026")
 f.mapButton:SetEnabled(b[5]~=nil and b[6]~=nil and b[7]~=nil)
 f.manual:SetText(s.status=="manual" and "Undo my mark" or "Mark donated manually")
 f.manual:SetEnabled(s.status~="donated")
 f.alternate:SetShown(b.alt~=nil)
 f.detailHint:SetText(reason~="" and reason or "Mark only if you remember handing this book in. Manual marks can be undone.")
end
local function match(b)
 local s=A.state[b[1]] or {status="unknown"}
 local q=A.window.search:GetText():lower()
 if q~="" and not (b[3].." "..b[4]):lower():find(q,1,true) then return false end
 if filter=="All" then return true end
 if filter=="Route" then return A.OnRoute(b) end
 if filter=="To find" then return s.status=="missing" or s.status=="seen" or s.status=="unknown" end
 if filter=="Carried" then return s.status=="bags" or s.status=="bank" end
 if filter=="Donated" then return s.status=="donated" or s.status=="manual" end
 return true
end
function A.Refresh()
 local f=A.window; if not f or not f:IsShown() then return end
 local p=A.progress or {donated=0,owned=0,manual=0,other=0}
 f.total:SetText(p.reward and "RING QUEST COMPLETE" or (p.donated.." / 20  confirmed donations"))
 f.progress:SetValue(math.min(p.donated,20))
 f.counts:SetText(p.owned.." owned, not donated  •  "..p.manual.." manual marks  •  "..math.max(0,20-p.donated).." donations to goal")
 f.rewardHint:SetText(p.reward and "Greater Friend of the Library is already completed." or "10 = necklace  •  20 total = ring  •  Ring quest requires level 20")
 local visible={}
 for _,b in ipairs(A.books) do if match(b) then visible[#visible+1]=b end end
 local present=false; for _,b in ipairs(visible) do if b==selected then present=true end end
 if not present and #visible>0 then selected=visible[1] end
 for i,r in ipairs(rows) do
  local b=visible[i]
  if b then
   r.book=b; r:Show()
   local s=A.state[b[1]] or {status="unknown"}
   r.title:SetText(b[3]); r.zone:SetText(A.BookLocation(b))
   local recommendation=A.Recommendation(b); r.recommendation:SetText(recommendation)
   r.status:SetText(statusText[s.status]); r.status:SetTextColor(unpack(colors[s.status]))
   r.number:SetText(string.format("%02d",b.index))
   r.bg:SetColorTexture(b==selected and 0.21 or 0.085,b==selected and 0.18 or 0.10,b==selected and 0.12 or 0.13,1)
  else r:Hide() end
 end
 f.child:SetHeight(math.max(1,#visible*69))
 f.empty:SetShown(#visible==0)
 f.listCount:SetText(#visible.." books  •  "..filter..(p.other>0 and ("  •  +"..p.other.." donations outside route") or ""))
 for _,b in ipairs(f.filterButtons) do b:GetFontString():SetTextColor(unpack(b.label==filter and gold or {0.8,0.8,0.8})) end
 detail()
end
local function create()
 local f=panel(UIParent,960,750,0,0,0.045,0.055,0.08)
 A.window=f; _G.LibraryGuideForeverWindow=f
 f:ClearAllPoints(); f:SetPoint("CENTER"); f:SetFrameStrata("DIALOG")
 f:SetClampedToScreen(true); f:SetMovable(true); f:EnableMouse(true); f:RegisterForDrag("LeftButton")
 f:SetScript("OnDragStart",f.StartMoving)
 f:SetScript("OnDragStop",function(self)
  self:StopMovingOrSizing(); local point,_,relative,x,y=self:GetPoint()
  A.db.position={point,relative,x,y}
 end)
 local scale=math.min(1,(UIParent:GetWidth()-40)/960,(UIParent:GetHeight()-40)/750)
 f:SetScale(math.max(0.5,scale))
 if A.db.position then local p=A.db.position; f:ClearAllPoints(); f:SetPoint(p[1],UIParent,p[2],p[3],p[4]) end
 tinsert(UISpecialFrames,"LibraryGuideForeverWindow")
 local icon=f:CreateTexture(nil,"ARTWORK"); icon:SetSize(42,42); icon:SetPoint("TOPLEFT",22,-20); icon:SetTexture("Interface\\Icons\\INV_Misc_Book_09")
 text(f,23,78,-20,700,gold):SetText("THE LIBRARY JOURNAL")
 text(f,12,79,-50,730):SetText("FOREVER  /  Your path to the Philanthropist's Ring")
 local close=CreateFrame("Button",nil,f,"UIPanelCloseButton"); close:SetPoint("TOPRIGHT",-6,-6)
 local hero=panel(f,916,96,22,-78,0.085,0.095,0.12)
 f.total=text(hero,18,16,-12,650,gold)
 f.counts=text(hero,12,16,-38,850)
 f.progress=CreateFrame("StatusBar",nil,hero); f.progress:SetPoint("TOPLEFT",16,-61); f.progress:SetSize(880,8)
 f.progress:SetStatusBarTexture("Interface\\Buttons\\WHITE8X8"); f.progress:SetStatusBarColor(unpack(gold)); f.progress:SetMinMaxValues(0,20)
 local bg=f.progress:CreateTexture(nil,"BACKGROUND"); bg:SetAllPoints(); bg:SetColorTexture(0.15,0.16,0.19,1)
 f.rewardHint=text(hero,10,16,-76,850,{0.68,0.72,0.79})
 f.search=CreateFrame("EditBox",nil,f,"InputBoxTemplate"); f.search:SetSize(300,24); f.search:SetPoint("TOPLEFT",30,-190); f.search:SetAutoFocus(false)
 f.search:SetScript("OnEscapePressed",function(self) self:ClearFocus() end)
 f.search:SetScript("OnTextChanged",function() if f.scroll then f.scroll:SetVerticalScroll(0) end; A.Refresh() end)
 text(f,11,345,-195,160,{0.62,0.67,0.74}):SetText("Search book or zone")
 f.filterButtons={}
 for i,label in ipairs(filters) do
  local b=button(f,label,91,22+(i-1)*98,-222,function() filter=label; f.scroll:SetVerticalScroll(0); A.Refresh() end)
  b.label=label; f.filterButtons[#f.filterButtons+1]=b
 end
 f.listCount=text(f,10,26,-256,480,{0.62,0.67,0.74})
 f.scroll=CreateFrame("ScrollFrame",nil,f,"UIPanelScrollFrameTemplate"); f.scroll:SetPoint("TOPLEFT",22,-279); f.scroll:SetSize(467,290)
 f.child=CreateFrame("Frame",nil,f.scroll); f.child:SetSize(467,1); f.scroll:SetScrollChild(f.child)
 for i=1,#A.books do
  local r=CreateFrame("Button",nil,f.child); rows[i]=r; r:SetSize(467,67); r:SetPoint("TOPLEFT",0,-(i-1)*69)
  r.bg=r:CreateTexture(nil,"BACKGROUND"); r.bg:SetAllPoints()
  r.number=text(r,13,10,-17,27,gold)
  r.title=text(r,12,43,-7,412); r.title:SetHeight(15); r.title:SetWordWrap(false)
  r.recommendation=text(r,9,43,-26,412,{0.95,0.65,0.35})
  r.zone=text(r,10,43,-47,272,{0.65,0.7,0.78}); r.zone:SetHeight(14); r.zone:SetWordWrap(false)
  r.status=text(r,9,313,-48,145); r.status:SetJustifyH("RIGHT")
  r:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight","ADD")
  r:SetScript("OnClick",function(self) selected=self.book; A.Refresh() end)
  r:SetScript("OnEnter",function(self)
   GameTooltip:SetOwner(self,"ANCHOR_RIGHT"); GameTooltip:SetText(self.book[3],1,0.85,0.5)
   GameTooltip:AddLine(A.BookLocation(self.book),1,1,1)
   local recommendation,reason=A.Recommendation(self.book)
   if recommendation~="" then GameTooltip:AddLine(recommendation..": "..reason,1,0.65,0.35,true) end
   GameTooltip:AddLine(self.book[8],0.8,0.8,0.8,true); GameTooltip:Show()
  end)
  r:SetScript("OnLeave",function() GameTooltip:Hide() end)
 end
 f.empty=text(f,14,45,-325,410,gold); f.empty:SetText("No books match this view.")
 local d=panel(f,406,383,532,-190,0.105,0.095,0.08)
 text(d,10,18,-14,365,gold):SetText("FIELD NOTES")
 f.bookTitle=text(d,19,18,-37,365,gold); f.bookTitle:SetHeight(70)
 f.bookZone=text(d,12,18,-115,365)
 f.bookStatus=text(d,12,18,-142,365)
 f.bookRecommendation=text(d,11,18,-164,365,{0.95,0.65,0.35})
 f.bookNotes=text(d,12,18,-185,365); f.bookNotes:SetHeight(128); f.bookNotes:SetSpacing(3)
 f.bookEvidence=text(d,10,18,-320,365,{0.62,0.59,0.52})
 f.mapButton=button(d,"Show on map",148,18,-350,function() A.ToBook(selected) end)
 f.alternate=button(d,"Thelsamar location",195,180,-350,function() A.ToBook(selected,true) end)
 f.manual=button(f,"Mark donated manually",205,532,-583,function() A.ToggleManual(selected) end)
 button(f,"Librarian",96,742,-583,A.Librarian)
 button(f,"Rescan",95,843,-583,A.Scan)
 f.detailHint=text(f,10,535,-617,398,{0.66,0.66,0.65})
 text(f,10,24,-588,475,{0.64,0.68,0.75}):SetText("* Bank counts can be cached. Open your bank to refresh.\nManual marks are separate from confirmed donations.\n/library  •  /bookguide  •  Escape to close")
 local rewards=panel(f,916,78,22,-654,0.085,0.095,0.12)
 text(rewards,11,16,-10,430,gold):SetText("10 BOOKS  /  Choose one necklace")
 text(rewards,11,470,-10,430,gold):SetText("20 BOOKS  /  Choose one ring — Loop is Rogue-only")
 text(rewards,10,16,-59,880,{0.68,0.72,0.79}):SetText("Hover for stats  •  Click to inspect  •  Shift-click to link in chat")
 A.CreateRewardLinks(rewards)
 f:SetScript("OnShow",function() A.Scan() end)
 A.Refresh()
end
function A.Toggle()
 if not A.window then create()
 elseif A.window:IsShown() then A.window:Hide()
 else A.window:Show() end
end
