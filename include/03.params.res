{DEFINE Menu.SideBar.Width} 42

// Size of casual/comp/mvm playlist entries.
{DEFINE PlaylistEntry.Width} 80
{DEFINE PlaylistEntry.Height} 32
// How many playlist entries there are.
{DEFINE PlaylistEntry.Count} 3
// How much `ExpandableList` extends off-screen.
{DEFINE ExpandableList.Overflow} 10000
// How much of `ExpandableList` is visible (when it is open).
{DEFINE ExpandableList.Width} "$(PlaylistEntry.Width * PlaylistEntry.Count + Menu.SideBar.Width)"
