/**
 * i_flox_leaderboard_scores(List scores) List
 * Copys the raw data list and returns a list of scores that includes
 * all debugging info. If an invalid list, a new empty list will be
 * returned (to handle no-content responses from Flox).
 */

var list = argument0;
var leaderboardListName = '[Flox] Leaderboard';

// Either create the list or copy the one provided
var newList = noone;
if list_exists(list) {
    newList = list_deep_copy(list);
    list_meta_set_name(newList,leaderboardListName);
}
else newList = list_create(leaderboardListName);

// Give all the maps in the list a name in the metadata
for (var i = 0, n = list_size(newList); i < n; i++) {
    var scoreData = ds_list_find_value(newList,i);
    map_meta_set_name(scoreData,'[Flox] Score');
}

return newList;
