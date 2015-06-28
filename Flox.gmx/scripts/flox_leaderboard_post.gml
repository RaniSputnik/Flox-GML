/// flox_leaderboard_post(leaderboardID,score,playerName)
//
// Posts a score to the given leaderboard.
 
var leaderboardID = string(argument0);
var value = argument1;
var playerName = string(argument2);
 
with i_flox_assert_initialized() {
    // Find the REST endpoint
    var path = "leaderboards"+"/"+string(leaderboardID);
    // Create the request data
    // We use string and round to ensure the result ends up
    // a whole number (json_encode will result in x.00000 otherwise)
    var data = map_create("post-score-data");
    map_set(data,"playerName",playerName);
    map_set(data,"value", string(round(value)));
    // Send the request
    i_flox_request_queued(http_method_post, path, data);
    // Free the map
    map_destroy(data);
}
