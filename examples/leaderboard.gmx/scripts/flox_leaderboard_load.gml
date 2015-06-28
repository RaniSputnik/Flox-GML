/// flox_leaderboard_load(leaderboardID,timeScope|playerIds,onComplete,onError)
//
//  Loads all scores on a leaderboard in the given constraints.
//  You may either specify a timescope (flox_today, flox_this_week, flox_all_time)
//  Or you can specify a list of player ids that will be selected from the leaderboard
//  The scores list is a list of maps, similar to a json object. 
//  The maps contain five properties, "playerId", "playerName", "value", "date" and "country"
//  Returns a request id that can be used with flox_completed and flox_failed to determine
//  when the request complets.
 
var leaderboardID = string(argument0);
var scope = argument1;
var onComplete = argument2;
var onError = argument3;
var context = id;

// Make sure that flox is initialized
with i_flox_assert_initialized() {
    var path = "leaderboards"+"/"+string(leaderboardID);
    var data = map_create("load-scores-data");
    // If scope is a string, we presume it is one of the timescope values
    if is_string(scope) map_set(data,"t",scope);
    // Otherwise we check for a list of player ids
    // We make a copy of the list as it is not a list handled by flox
    // And this list will be destroyed
    else if list_exists(scope) {
        var listCopy = list_create("load-scores-playerIds-copy");
        ds_list_copy(listCopy,scope);
        map_set_list(data,"p",scope);
    }
    else {
        flox_die("Invalid scope argument, must be timescope or list of player id's");
        return false;
    }
    // Perform the request
    var req = i_flox_request(http_method_get,path,data,i_flox_on_leaderboard_load_complete,i_flox_on_leaderboard_load_error);
    map_set(req,"lbContext",context);
    map_set(req,"lbOnComplete",onComplete);
    map_set(req,"lbOnError",onError);
    // Remove the data
    map_destroy(data);
}
