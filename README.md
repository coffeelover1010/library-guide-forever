# Library Guide Forever

A character-specific library journal for the Philanthropist's Ring, built for the Forever beta (Interface 16001).

![Library Guide Forever in game](https://raw.githubusercontent.com/coffeelover1010/library-guide-forever/main/docs/journal.png)

Open with `/library` or `/bookguide`. Drag the window to move it. Escape closes it. `/library resetpos` recentres it.

The standard LibDBIcon minimap button uses a book icon. Left-click to open or close the journal; drag to reposition it. Position and visibility are saved per character. `/library minimap` toggles the button; `/library minimap hide` hides it and `/library minimap show` restores it. `/library` opens the journal even when its icon is hidden. LibDataBroker displays can also show the launcher.

The rewards strip shows both necklace choices at 10 books and both ring choices at 20. Hover for the game's item tooltip, click to inspect, or Shift-click to insert the item link into an open chat box. Field Researcher's Loop is labelled Rogue-only. Uncached items request their data from the game; chat linking waits for a real client item link.

## Automatic progress

- Checks each book's item ID in your inventory and the character's completed donation quest flag at login, on bag changes, on quest changes, and when opening the journal.
- Marks **In bags**, **In bank**, or **Turned in**. Past donations are detected using completed quest flags. It does not infer donation from an item disappearing.
- Bank counts come from the client's inventory cache. Open your bank to refresh them. It does not inspect other characters, mail, or account storage.
- Remembers observed ownership as **Seen before** if the book disappears without a confirmed donation. Those books remain in **To find**.
- Manual donation marks are reversible and shown separately. They never inflate the confirmed progress bar.
- Progress is saved per character. Copies of Rumi count once.
- Tracks all 40 known book items. Seven previously hidden donation quests now have full entries and still count only once. The completed ring reward quest is checked independently. Books without a verified Forever quest track ownership and manual marks, but do not inflate confirmed donations or the owned-to-goal count.

## Guide

40 unique books. **All** opens by default so the entire catalogue is visible. **Route** retains the original suggested route (20 candidates for Alliance). The 18 added entries are marked **Not recommended**, with reasons such as high-level travel, disputed locations, or unconfirmed hand-ins. These are recommendations for the level-20 reward route, not claims that a book cannot be collected. Ownership and donation states remain visible separately. Filters and search narrow the list. Select a book for its notes; **Show on map** opens the zone and uses a native waypoint when supported, or TomTom if installed. Unsettled locations have no map button or invented coordinates. Rumi also has a Thelsamar button. Wailing Caverns navigation targets the outdoor cave entrance; the interior coordinates are in the notes.

**Horde only** appears for Alliance characters on Ta'zo and the Apothecary's Primer. **Alliance only** appears for Horde characters on Antonidas and Rumi. These labels describe the donation quest's faction restriction in the current Forever database. Ataeric and the Swamp of Sorrows alternative are included with warnings about uncertain locations or hand-ins.

The expanded catalogue was checked on 29 September 2026 against the installed ItemDB Forever item names, the two Wowhead Forever librarian quest lists below, and community location reports at https://wowforevertools.com/books and https://foreverchanges.pro/library-books. Eleven entries have no verified Forever donation quest; no Season of Discovery quest IDs are substituted. Community locations are not locally verified in-game.

## Data and limits

Book names/item IDs were checked against the locally installed ItemDB Forever catalogue. Quest IDs and faction restrictions were checked from Wowhead's Forever database on 27 September 2026:

- https://www.wowhead.com/forever/npc=211033/garion-wendell
- https://www.wowhead.com/forever/npc=211022/owen-thadd
- https://www.wowhead.com/forever/item=207972/the-lessons-of-tazo
- https://www.wowhead.com/forever/item=208185/the-apothecarys-metaphysical-primer

Route coordinates are from the user-supplied guide. Alternatives and community location context: https://foreverchanges.pro/library-books (checked 27 September 2026). These are community reports, not developer-verified visits. Desolace and Badlands avoid enemy-capital donations but still have dangerous enemies. 10 donations for a necklace and 20 total for the ring are reported beta thresholds. Quest 79536 currently requires level 20.

Uses built-in game textures and fonts; no generated imagery or bundled artwork. Standard minimap libraries are bundled, with upstream notices in `Libs/NOTICE.txt`; no separate library installation is needed. No automatic quest acceptance, turn-in, or reward selection.

## Install and client check

Copy this folder into `_classic_beta_/Interface/AddOns/LibraryGuideForever`. Fully restart WoW if this new addon is not listed. Enable it and run `/library`.

Check one owned book, one previously donated book, and a missing book. Open the bank, then check banked-book status. Try a map target and a librarian target. Donate a book and check that it moves to Turned in; reload and check persistence. Offline checks cannot establish in-game rendering or Forever server behavior.
