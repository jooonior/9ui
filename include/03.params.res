{DEFINE MenuBar.size} 42

// Size of casual/comp/mvm playlist entries.
{DEFINE PlaylistEntry.width} 88
{DEFINE PlaylistEntry.height} 32
// How many playlist entries there are.
{DEFINE PlaylistEntry.count} 3

// How much `ExpandableList` extends off-screen.
{DEFINE ExpandableList.overflow} 10000
// How much of `ExpandableList` is visible (when it is open).
{DEFINE ExpandableList.width} "$(PlaylistEntry.width * PlaylistEntry.count + 12)"
