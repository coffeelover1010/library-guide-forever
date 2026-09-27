local name, A = ...
local db
A.state = {}
local function safe(fn, ...)
 if type(fn) ~= "function" then return nil end
 local ok, value = pcall(fn, ...)
 if ok then return value end
end
function A.Completed(id)
 return safe(C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted or IsQuestFlaggedCompleted, id) == true
end
function A.Eligible(b)
 return not b.faction or b.faction == UnitFactionGroup("player")
end
function A.Scan()
 if not db then return end
 local count = C_Item and C_Item.GetItemCount or GetItemCount
 local donated, owned, manual, other = 0, 0, 0, 0
 for _, b in ipairs(A.books) do
  local id = b[1]
  local record = db.books[id] or {}; db.books[id] = record
  local bags = safe(count, id, false)
  local total = safe(count, id, true)
  if type(bags) ~= "number" then bags = nil end
  if type(total) ~= "number" then total = nil end
  local done = A.Completed(b[2]) or record.confirmed == true
  if done then record.confirmed = true end
  if bags and bags > 0 then record.seen = true end
  if total and bags and total > bags then record.seen = true end
  local status = "missing"
  if done then status="donated"; donated=donated+1
  elseif record.manual then status="manual"; manual=manual+1
  elseif bags and bags > 0 then status="bags"; if A.Eligible(b) then owned=owned+1 end
  elseif total and bags and total > bags then status="bank"; if A.Eligible(b) then owned=owned+1 end
  elseif bags == nil then status="unknown"
  elseif record.seen then status="seen" end
  A.state[id]={status=status,bags=bags,total=total,record=record}
 end
 for _, id in ipairs(A.extraQuests) do
  if A.Completed(id) then other=other+1 end
 end
 A.progress={donated=donated+other,owned=owned,manual=manual,other=other,reward=A.Completed(A.rewardQuest)}
 if A.Refresh then A.Refresh() end
end
function A.ToggleManual(b)
 local r=db.books[b[1]]
 if not r or r.confirmed then return end
 r.manual=not r.manual
 A.Scan()
end
function A.Print(s) print("|cffdfbd76Library Guide:|r "..s) end
function A.Navigate(mapID, x, y, title, expectedZone)
 if InCombatLockdown() then A.Print("Open the map after combat."); return end
 local info = C_Map and safe(C_Map.GetMapInfo,mapID)
 if not info or (GetLocale()=="enUS" or GetLocale()=="enGB") and expectedZone and info.name~=expectedZone then
  A.Print("Map could not be matched on this client: "..(expectedZone or title).." "..x..", "..y); return
 end
 local pinned=false
 if C_Map.CanSetUserWaypointOnMap and safe(C_Map.CanSetUserWaypointOnMap,mapID) and UiMapPoint then
  local p=UiMapPoint.CreateFromCoordinates(mapID,x/100,y/100)
  pinned=safe(C_Map.SetUserWaypoint,p)==true
 end
 if TomTom and TomTom.AddWaypoint then
  if A.tomtom and TomTom.RemoveWaypoint then safe(TomTom.RemoveWaypoint,TomTom,A.tomtom) end
  A.tomtom=safe(TomTom.AddWaypoint,TomTom,mapID,x/100,y/100,{title=title,persistent=false,minimap=true,world=true})
  pinned=pinned or A.tomtom~=nil
 end
 if OpenWorldMap then OpenWorldMap(mapID)
 elseif WorldMapFrame then WorldMapFrame:Show(); WorldMapFrame:SetMapID(mapID) end
 A.Print(title..": "..(expectedZone or "").." "..x..", "..y..(pinned and " (waypoint set)" or " (coordinates; this client has no supported waypoint)"))
end
function A.ToBook(b, alternate)
 if alternate and b.alt then local p=b.alt; A.Navigate(p[1],p[2],p[3],b[3],p[4])
 else A.Navigate(b[5],b[6],b[7],b[3],b[4]) end
end
function A.Librarian()
 if UnitFactionGroup("player")=="Horde" then A.Navigate(1458,73.4,33.0,"Owen Thadd","Undercity")
 else A.Navigate(1453,37.6,80.8,"Garion Wendell","Stormwind City") end
end
local events=CreateFrame("Frame")
events:RegisterEvent("ADDON_LOADED")
events:SetScript("OnEvent",function(_, event, arg)
 if event=="ADDON_LOADED" then
  if arg~=name then return end
  LibraryGuideForeverDB=LibraryGuideForeverDB or {}
  db=LibraryGuideForeverDB; db.books=db.books or {}; A.db=db
  for _, e in ipairs({"PLAYER_LOGIN","PLAYER_ENTERING_WORLD","BAG_UPDATE_DELAYED","BANKFRAME_OPENED","BANKFRAME_CLOSED","PLAYERBANKSLOTS_CHANGED","QUEST_LOG_UPDATE","QUEST_TURNED_IN"}) do events:RegisterEvent(e) end
  A.Scan()
 elseif event=="QUEST_TURNED_IN" then
  local b=A.byQuest[arg]
  if b then db.books[b[1]]=db.books[b[1]] or {}; db.books[b[1]].confirmed=true end
  A.Scan()
 else A.Scan() end
end)
SLASH_LIBRARYGUIDEFOREVER1="/library"
SLASH_LIBRARYGUIDEFOREVER2="/bookguide"
SlashCmdList.LIBRARYGUIDEFOREVER=function(msg)
 if msg=="scan" then A.Scan(); A.Print("Inventory and completed quests checked. Open your bank once to refresh bank counts.")
 elseif msg=="minimap" then A.ShowMinimap()
 elseif msg=="resetpos" then if A.window then A.window:ClearAllPoints(); A.window:SetPoint("CENTER") end; db.position=nil
 else A.Toggle() end
end
