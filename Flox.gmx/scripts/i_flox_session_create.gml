/**
 * i_flox_session_create(Map lastSession = noone) Map
 * Creates a new Flox session, optionally with a previous session provided
 */

var session = map_create("[Flox] Session");
var lastSession = noone;
if argument_count > 0 then lastSession = argument[0];

var curTimeUTC = i_flox_get_current_time_utc();
// If there was a session previous to this one, try to find the original start time
var firstStartTime;
if map_exists(lastSession)
    then firstStartTime = map_get(lastSession,"firstStartTime");
else firstStartTime = curTimeUTC;
// Set all the required properties
map_set(session,"firstStartTime",firstStartTime);
map_set(session,"startTime",curTimeUTC);
map_set(session,"duration",0);
map_set_list(session,"log",list_create("[Session] log"));
map_set(session,"numErrors",0);

return session;
