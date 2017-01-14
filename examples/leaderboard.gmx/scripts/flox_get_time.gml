/// flox_get_time(onComplete,onError)
///
/// Fetches the current time from the server.

var onComplete = argument0;
var onError    = argument1;
var context    = id;

with i_flox_assert_initialized() {
    var req = i_flox_request(http_method_get,"time",noone,
        i_flox_on_get_time_complete,i_flox_on_get_time_error);
    map_set(req,"timeOnComplete",onComplete);
    map_set(req,"timeOnError",onError);
    map_set(req,"timeContext",context);

    return true;
}
return false;

