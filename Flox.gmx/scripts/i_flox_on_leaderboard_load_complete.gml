/**
 * i_flox_on_leaderboard_load_complete(Map request, Map response, Real httpStatus)
 * Called when a leaderboard is loaded successfully
 */
 
var request = argument0;
var response = argument1; 
var httpStatus = argument2;

// If the leaderboard is empty flox gives us a no-content
// response. GameMaker will then create a map like this
// {"default":""}, in this case we want the scores array to
// be set to noone
var scores = map_default(response,"default","");
if is_string(scores) then scores = noone;

// Copy the response and add the correct meta data to the list/maps
var scoresCopy = i_flox_leaderboard_scores(scores);
// Callback
var context = map_get(request,"lbContext");
var onComplete = map_get(request,"lbOnComplete");
i_flox_callback(context,onComplete,scoresCopy);
