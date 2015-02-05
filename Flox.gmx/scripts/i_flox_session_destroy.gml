/**
 * i_flox_session_destroy(Map session)
 * Destroys the given session (avoiding the nested map destroy bug in JS targets)
 */
 
var session = argument0;
// Remove all entries from the session log
var sessionLog = map_get(session,"log");
repeat ds_list_size(sessionLog) {
show_debug_message("Removing map from session log");
    var entry = ds_list_find_value(sessionLog,0);
    if map_has(entry,"properties") {
        map_destroy(map_get(entry,"properties"));
        map_delete(entry,"properties");
    }
    map_destroy(entry);
    ds_list_delete(sessionLog,0);
}
// Remove the session log
list_destroy(sessionLog);
// Finally remove the session
map_destroy(session);
