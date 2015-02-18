/**
 * i_flox_on_leaderboard_load_complete(Map request, Map response, Real httpStatus)
 * Called when a leaderboard is loaded successfully
 */
 
var request = argument0;
var response = argument1; 
var httpStatus = argument2;

var scores = map_get(response,"default");
var scoresCopy = i_flox_leaderboard_scores(scores);
var context = map_get(request,"lbContext");
var onComplete = map_get(request,"lbOnComplete");

with context {
    if script_exists(onComplete)
        script_execute(onComplete,scoresCopy);
}
