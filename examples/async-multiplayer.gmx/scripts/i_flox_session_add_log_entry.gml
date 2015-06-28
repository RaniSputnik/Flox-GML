/**
 * i_flox_session_add_log_entry(String type, Map data)
 * Adds an entry to the log for the current session
 */
 
var type = string(argument0);
var data = argument1;

// Get the current session
var session = map_get(self._persistentData,"session");
if not i_flox_assert(session,"Can not add log, no current session") then exit;
// Add additional information to the log data
map_set(data,"type",type);
map_set(data,"time",flox_date_encode(i_flox_get_current_time_utc()));
// Add the log data to the session log
var log = map_get(session,"log");
list_add_map(log,data);
// Now the persistent data has changed, write it to disk
i_flox_persistent_invalidate();
