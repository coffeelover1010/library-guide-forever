"""Offline Lua 5.1 behavior checks. This does not emulate the WoW client UI."""
from pathlib import Path
from lupa.lua51 import LuaRuntime

root = Path(__file__).resolve().parents[1]
lua = LuaRuntime(unpack_returned_tuples=True)
lua.execute('''
A = {}; frames = {}; bag = {}; bank = {}; completed = {}; faction = "Alliance"
SlashCmdList = {}
function CreateFrame()
 local f={}
 function f:RegisterEvent(e) end
 function f:SetScript(e,fn) self[e]=fn end
 frames[#frames+1]=f; return f
end
function UnitFactionGroup() return faction end
C_Item={GetItemCount=function(id, includeBank) return (bag[id] or 0)+(includeBank and (bank[id] or 0) or 0) end}
C_QuestLog={IsQuestFlaggedCompleted=function(id) return completed[id] or false end}
function fire(e,arg) frames[1].OnEvent(frames[1],e,arg) end
''')
for filename in ('Books.lua', 'Tracking.lua', 'Window.lua'):
    source = (root / filename).read_text(encoding='utf-8')
    lua.execute('assert(loadstring(...))', source)
    if filename != 'Window.lua':
        lua.execute(source, 'LibraryGuideForever', lua.globals().A)
lua.execute('''
fire("ADDON_LOADED","LibraryGuideForever")
assert(#A.books==40)
local ids,qs={},{}
for _,b in ipairs(A.books) do
 assert(not ids[b[1]] and (not b[2] or not qs[b[2]]),"duplicate book or quest")
 ids[b[1]]=true; if b[2] then qs[b[2]]=true end
 assert(type(A.BookLocation(b))=="string")
end
assert(A.progress.donated==0 and A.progress.owned==0)
local eligible=0; for _,b in ipairs(A.books) do if A.OnRoute(b) then eligible=eligible+1 end end
assert(eligible==20,"Alliance route should have 20 books")
bag[203755]=1; fire("BAG_UPDATE_DELAYED")
assert(A.state[203755].status=="bags" and A.progress.owned==1)
bag[203755]=0; bank[203755]=1; fire("BANKFRAME_OPENED")
assert(A.state[203755].status=="bank" and A.progress.owned==1 and A.progress.donated==0)
bank[203755]=0; fire("BAG_UPDATE_DELAYED")
assert(A.state[203755].status=="seen" and A.progress.donated==0)
completed[79092]=true; fire("QUEST_LOG_UPDATE")
assert(A.state[203755].status=="donated" and A.progress.donated==1)
bag[203755]=1; A.Scan()
assert(A.progress.donated==1 and A.progress.owned==0,"owned donated book must not double count")
bag[208860]=2; A.Scan()
assert(A.progress.owned==1,"Rumi copies count once")
local b=A.byItem[203754]; A.ToggleManual(b)
assert(A.state[203754].status=="manual" and A.progress.manual==1 and A.progress.donated==1)
A.ToggleManual(b); assert(A.state[203754].status=="missing" and A.progress.manual==0)
fire("QUEST_TURNED_IN",79091)
assert(A.state[203754].status=="donated" and A.progress.donated==2)
A.ToggleManual(b); assert(A.progress.manual==0,"cannot override confirmed donation")
completed[81947]=true; A.Scan(); assert(A.progress.other==0 and A.progress.donated==3)
assert(A.state[220345].status=="donated","expanded quest must count exactly once")
assert(A.Recommendation(A.byItem[220345])=="NOT RECOMMENDED")
assert(A.Recommendation(A.byItem[207972])=="HORDE ONLY")
assert(A.Recommendation(A.byItem[210177])=="NOT RECOMMENDED","unknown must not mean impossible")
bag[210177]=1; A.Scan()
assert(A.state[210177].status=="bags" and A.progress.owned==1,"unverified hand-ins must not inflate owned goal progress")
assert(not A.Completed(false))
faction="Horde"
assert(A.Recommendation(A.byItem[203754])=="ALLIANCE ONLY")
assert(A.Recommendation(A.byItem[207972])=="")
faction="Alliance"
bag[207972]=1; A.Scan(); assert(A.progress.owned==1,"Horde-only book excluded from Alliance owned progress")
completed[79536]=true; A.Scan(); assert(A.progress.reward)
completed={}; fire("PLAYER_ENTERING_WORLD")
assert(A.state[203754].status=="donated","observed turn-in survives flag cache gaps")
C_Item.GetItemCount=function() error("unavailable") end; A.Scan()
assert(A.state[209845].status=="unknown","failed reads must not imply missing")
LibraryGuideForeverDB={}; fire("ADDON_LOADED","LibraryGuideForever")
assert(A.progress.donated==0,"fresh character must not inherit donations")
''')
print('PASS: Lua 5.1 syntax for all 3 files; ownership, bank, history, deduplication, manual marks, faction, reward, and character isolation checks.')
