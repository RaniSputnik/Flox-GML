/**
 * flox_log_warning(String message)
 * Writes a new warning message into the session log
 */
 
var message = string(argument0);

// Ensure flox is initialized
with flox_assert_initialized() {
    // Print a message on the console
    flox_log(fx_log_warn,"[Warning] "+message);
    // Create the map to store the data for the log entry
    var entry = map_create("[Log] Warning : "+message);
    map_set(entry,"message",message);
    // Add it to the current session log
    i_flox_session_add_log_entry("warning",entry);
    // DO NOT FREE THE MAP MEMORY
    // i_flox_session_add_log_entry does not copy the map
}
