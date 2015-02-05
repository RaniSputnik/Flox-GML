/**
 * i_flox_leaderboard_scores_free(List scores) 
 * Destroys the list and the nested maps it contains
 */

var list = argument0;
while list_size(list) > 0 {
    map_destroy(ds_list_find_value(list,0));
}
list_destroy(list);
