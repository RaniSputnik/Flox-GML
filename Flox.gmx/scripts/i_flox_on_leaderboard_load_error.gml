/**
 * i_flox_on_leaderboard_load_error(Map request, String error, Real httpStatus, Map cachedBody)
 * Called when the leaderboard fails to load
 */
 
var request    = argument0;
var error      = argument1;
var httpStatus = argument2;
var cachedBody = argument3;

var scoresCopy = noone;
if map_exists(cachedBody) {
    var scores = map_get(cachedBody,"default");
    scoresCopy = i_flox_leaderboard_scores(scores);
}
// Callback
var context = map_get(request,"lbContext");
var onError = map_get(request,"lbOnError");
i_flox_callback(context,onError,error,httpStatus,scoresCopy);
