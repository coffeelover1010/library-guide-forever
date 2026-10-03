local _, A = ...
-- Item IDs cross-checked against the installed ItemDB Forever enUS catalogue.
-- Quest IDs: Wowhead Forever librarian quest lists, checked 2026-09-27.
-- Coordinates: user's supplied route; two alternatives from ForeverChanges.
-- Locations are community reports, not locally verified client observations.
A.books = {
 {203755,79092,"Archmage Theocritus' Research Journal","Elwynn Forest",1429,65.4,70.1,"Tower of Azora. Look inside the tower."},
 {203754,79091,"Archmage Antonidas: The Unabridged Autobiography","Ironforge",1455,75.7,10.5,"Hall of Explorers. Current donation quest is Alliance-only.",faction="Alliance"},
 {209845,78142,"Bewitchments and Glamours","Westfall",1436,45.4,70.4,"Moonbrook. Look for a Spellbook. Hostile enemies nearby."},
 {208860,79093,"Rumi of Gnomeregan: The Collected Works","Westfall",1436,52.7,53.8,"Sentinel Hill. Also at Thelsamar, Loch Modan 35.6, 48.9. Both locations give the SAME book; it counts once. Current donation quest is Alliance-only.",faction="Alliance",alt={1432,35.6,48.9,"Loch Modan"}},
 {209849,78147,"Crimes Against Anatomy","Duskwood",1431,16.6,28.5,"Look for a Spellbook. Expect enemies in this area."},
 {209850,78148,"Runes of the Sorcerer-Kings","Loch Modan",1432,77.4,14.0,"Mo'grosh Stronghold. Look for Scrolls; ogres nearby."},
 {209848,78146,"Goaz Scrolls","Wetlands",1437,33.6,47.9,"Whelgar's Excavation Site. Look for Scrolls."},
 {209843,78124,"Nar'thalas Almanac, Vol. 74","Darkshore",1439,59.6,22.2,"Ruins of Mathystra. Look for Scrolls."},
 {209847,78145,"Arcanic Systems Manual","The Barrens",1413,56.3,8.8,"The Sludge Fen. Look for a Manual."},
 {208800,79097,"Baxtan: On Destructive Magics","The Barrens",1413,62.7,36.3,"Ratchet. Look for a Goblin Tome."},
 {209846,78143,"Secrets of the Dreamers","The Barrens",1413,46.0,36.5,"The map target is the CAVE ENTRANCE. Inside, look for Scrolls at 52.8, 54.7 on the cave map near the Wailing Caverns instance route. Do not use those interior coordinates on the Barrens map."},
 {209851,78149,"Fury of the Land","Stonetalon Mountains",1442,74.4,85.7,"Grimtotem Post. Look for Scrolls."},
 {209844,78127,"The Dalaran Digest, Vol. 23","Silverpine Forest",1421,63.5,63.1,"Ambermill. Travel through Horde territory with care."},
 {208185,79095,"The Apothecary's Metaphysical Primer","Tirisfal Glades",1420,59.4,52.3,"Brill. Current Forever database lists the donation quest as Horde-only. Excluded from the Alliance route.",faction="Horde"},
 {207972,79094,"The Lessons of Ta'zo","Orgrimmar",1454,38.7,78.4,"Enemy capital for Alliance. Current Forever database lists the donation quest as Horde-only. Excluded from the Alliance route.",faction="Horde"},
 {213165,79535,"Basilisks: Should Petrification be Feared?","Stranglethorn Vale",1434,41.4,50.9,"Crystalvein Mine area. High-level zone; plan your approach."},
 {215815,79948,"Defensive Magics 101","Alterac Mountains",1416,48.4,57.6,"Gallows' Corner. Look for a Manual. High-level enemies."},
 {215816,79949,"A Web of Lies: Debunking Myths and Legends","Arathi Highlands",1417,73.6,65.2,"Witherbark Village. Look for Scrolls. High-level enemies."},
 {215683,79947,"Geomancy: The Stone-Cold Truth","Thousand Needles",1441,34.4,40.1,"Darkcloud Pinnacle. Look for Scrolls. High-level enemies."},
 {215822,79952,"RwlRwlRwlRwl!","Dustwallow Marsh",1445,57.2,20.8,"Witch Hill. Look for a Waterlogged Book. High-level enemies."},
 {215817,79950,"Demons and You","Desolace",1443,55.1,26.2,"Alternative to a Horde-only donation. Thunder Axe Fortress. High-level enemies; this is not a guaranteed safe pickup.",alternative=true},
 {215820,79951,"Mummies: A Guide to the Unsavory Undead","Badlands",1418,56.7,39.9,"Alternative to a Horde-only donation. Look for Scrolls. High-level enemies; this is not a guaranteed safe pickup.",alternative=true},
 -- Extended catalogue checked 2026-09-29. false means no verified Forever
 -- donation quest: never substitute a Season of Discovery quest ID.
 {210177,false,"Ataeric: On Arcane Curiosities","Silverpine Forest",nil,nil,nil,"The old Sepulcher location is disputed. No reliable Forever pickup or donation quest confirmed.",caution="Location and hand-in unconfirmed"},
 {215824,false,"A Luddite's Guide to Caring for Your Demonic Pet","Swamp of Sorrows",1435,61.3,22.3,"Reported at Fallow Sanctuary. Dangerous at low level; Forever donation quest unconfirmed.",caution="Dangerous; hand-in unconfirmed"},
 {220345,81947,"Sanguine Sorcery","Swamp of Sorrows",1435,70.0,51.0,"Reported atop the Temple of Atal'Hakkar. Dangerous travel for the level-20 reward route.",caution="High-level area"},
 {220346,81949,"Legends of the Tidesages","Tanaris",1446,72.7,47.8,"Reported at Lost Rigger Cove. Dangerous travel for the level-20 reward route.",caution="High-level area"},
 {220347,false,"The Liminal and the Arcane","Feralas",nil,nil,nil,"Jademir Lake reports are unsettled. No reliable Forever pickup or donation quest confirmed.",caution="Location and hand-in unconfirmed"},
 {220348,81952,"Everyday Etiquette","Azshara",1447,20.7,62.0,"Reported at Haldarr Encampment. Dangerous travel for the level-20 reward route.",caution="High-level area"},
 {220349,81953,"Stonewrought Design","Blackrock Mountain",nil,nil,nil,"Reported near Franclorn Forgewright's altar. Map coordinates are disputed; no waypoint provided.",caution="Dangerous; location unconfirmed"},
 {220350,81954,"Venomous Journeys","The Hinterlands",1425,36.0,72.8,"Reported at Shadra'Alor. Dangerous travel for the level-20 reward route.",caution="High-level area"},
 {220352,81955,"A Mind of Metal","Searing Gorge",1427,37.8,49.4,"Reported in the Cauldron. Dangerous travel for the level-20 reward route.",caution="High-level area"},
 {220353,81956,"Conjurer's Codex","Blasted Lands",1419,55.4,32.2,"Reported in the Blasted Lands. Dangerous travel for the level-20 reward route.",caution="High-level area"},
 {228132,false,"Undead Potatoes","Western Plaguelands",1422,38.3,54.6,"Reported at Felstone Field. Dangerous at low level; Forever donation quest unconfirmed.",caution="Dangerous; hand-in unconfirmed"},
 {228133,false,"Magma or Lava?","Blackrock Mountain",nil,nil,nil,"Reported on the approach to Blackrock Depths. Coordinates are unsettled; Forever donation quest unconfirmed.",caution="Location and hand-in unconfirmed"},
 {228134,false,"Northern Kalimdor - A Comprehensive Guide","Felwood",1448,65.2,3.3,"Reported in Timbermaw Hold. Dangerous at low level; Forever donation quest unconfirmed.",caution="Dangerous; hand-in unconfirmed"},
 {228135,false,"A Study of the Light","Eastern Plaguelands",1423,71.8,48.2,"Reported at Light's Hope Chapel. Dangerous at low level; Forever donation quest unconfirmed.",caution="Dangerous; hand-in unconfirmed"},
 {228136,false,"Ka-Boom!","Winterspring",1452,60.7,37.7,"Reported in Everlook. Dangerous at low level; Forever donation quest unconfirmed.",caution="Dangerous; hand-in unconfirmed"},
 {228138,false,"The Knight and the Lady","Eastern Plaguelands",nil,nil,nil,"No reliable Forever pickup or donation quest confirmed. Do not plan a collection trip around this entry.",caution="Location and hand-in unconfirmed"},
 {228140,false,"Scourge: Undead Menace or Misunderstood?","Eastern Plaguelands",1423,31.3,21.0,"Reported outside Stratholme. Dangerous at low level; Forever donation quest unconfirmed.",caution="Dangerous; hand-in unconfirmed"},
 {228141,false,"Necromancy 101","Western Plaguelands",1422,69.4,72.8,"Reported at Caer Darrow, outside Scholomance. Dangerous at low level; Forever donation quest unconfirmed.",caution="Dangerous; hand-in unconfirmed"},
}
-- Previously counted outside-route quests now have full records above.
A.extraQuests = {}
A.rewardQuest = 79536
A.byItem, A.byQuest = {}, {}
for i, b in ipairs(A.books) do
 b.index=i; A.byItem[b[1]]=b; if b[2] then A.byQuest[b[2]]=b end
end
