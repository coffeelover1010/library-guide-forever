# Library Guide Forever

A character-specific library journal for the Philanthropist's Ring, built for the Forever beta (Interface 16001).

![Library Guide Forever in game](https://raw.githubusercontent.com/coffeelover1010/library-guide-forever/main/docs/journal.png)

Open with `/library` or `/bookguide`. Drag the window to move it. Escape closes it. `/library resetpos` recentres it.

The standard LibDBIcon minimap button uses a book icon. Left-click to open or close the journal; drag to reposition it. Position and visibility are saved per character. `/library minimap` restores a hidden button. LibDataBroker displays can also show the launcher.

The rewards strip shows both necklace choices at 10 books and both ring choices at 20. Hover for the game's item tooltip, click to inspect, or Shift-click to insert the item link into an open chat box. Field Researcher's Loop is labelled Rogue-only. Uncached items request their data from the game; chat linking waits for a real client item link.

## Automatic progress

- Checks each book's item ID in your inventory and the character's completed donation quest flag at login, on bag changes, on quest changes, and when opening the journal.
- Marks **In bags**, **In bank**, or **Turned in**. Past donations are detected using completed quest flags. It does not infer donation from an item disappearing.
- Bank counts come from the client's inventory cache. Open your bank to refresh them. It does not inspect other characters, mail, or account storage.
- Remembers observed ownership as **Seen before** if the book disappears without a confirmed donation. Those books remain in **To find**.
- Manual donation marks are reversible and shown separately. They never inflate the confirmed progress bar.
- Progress is saved per character. Copies of Rumi count once.
- Also counts seven additional donation quests listed by the Alliance librarian outside this route. This is not a complete catalogue of every possible book. The completed ring reward quest is checked independently.

## Guide

22 unique books: the supplied 20-book list plus Desolace and Badlands alternatives. **Route** excludes the two Horde-only donation quests for Alliance, leaving 20 candidates. **All** shows everything. Filters and search narrow the list. Select a book for its notes; **Show on map** opens the zone and uses a native waypoint when supported, or TomTom if installed. Unsupported maps retain the written coordinates. Rumi also has a Thelsamar button. Wailing Caverns navigation targets the outdoor cave entrance; the interior coordinates are in the notes.

The current Forever database lists Ta'zo (79094) and the Apothecary's Primer (79095) as Horde-only. Their items still appear in the journal. The original list's Swamp of Sorrows alternative is omitted because its current donation quest was not established. Ataeric is omitted because its beta location is disputed.

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
