/**
 * i_flox_on_leaderboard_load_error(request,error,httpStatus,cachedBody)
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
var context = map_get(request,"lbContext");
var onError = map_get(request,"lbOnError");
with context {
    if script_exists(onError)
        script_execute(onError,error,httpStatus,scoresCopy);
}
