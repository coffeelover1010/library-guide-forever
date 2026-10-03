# Changelog

## 0.1.4

- Add 18 missing books for a 40-book catalogue, shown through All by default.
- Label added entries Not recommended with reasons; label faction-restricted donations Horde only or Alliance only.
- Keep ownership and donation states separate from recommendations. Unverified hand-ins do not inflate progress.
- Promote seven existing extra quest counters to full book entries without double-counting.
- Disable map targets for unsettled locations instead of inventing coordinates.

## 0.1.3

- Toggle the minimap icon with `/library minimap`.
- Add `/library minimap show` and `/library minimap hide`, with `on` and `off` aliases.
- Accept command names regardless of capitalization or surrounding spaces.
- Add the hide command to the minimap tooltip. The journal remains available through `/library`.

Lua syntax and offline command checks passed. In-game rendering and persistence still need verification.

## 0.1.2 — Initial public beta

- Book journal with an Alliance route toward the Philanthropist's Ring.
- Automatic checks for owned books and completed donation quests.
- Separate bank, previously seen, and manual donation states.
- Search, filters, field notes, map navigation, and librarian locations.
- Standard LibDBIcon minimap launcher with saved position.
- Clickable links and tooltips for all four necklace and ring rewards.
- Per-character progress and reversible manual marks.

The supplied in-game screenshot shows the journal, owned-book states,
completed donations, and reward links. Full interaction coverage is still
pending. Locations are community reports and bank counts can be cached.
