/**
 * i_flox_leaderboard_scores(List scores) List
 * Copys the raw data list and returns a list of scores that includes
 * all debugging info
 */

var list = argument0;
var newList = list_deep_copy(list);
list_meta_set_name(newList,'[Flox] Leaderboard');
for (var i = 0, n = list_size(newList); i < n; i++) {
    var scoreData = ds_list_find_value(newList,i);
    map_meta_set_name(scoreData,'[Flox] Score');
}
return newList;
