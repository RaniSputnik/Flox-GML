/// flox_log_info(message)
// 
//  Writes a new message into the session log
 
var message = string(argument0);

// Ensure flox is initialized
with i_flox_assert_initialized() {
    // Print a message on the console
    i_flox_debug_message(fx_log_verbose,"[Info] "+message);
    // Create the map to store the data for the log entry
    var entry = map_create("[Log] Info:"+message);
    map_set(entry,"message",message);
    // Add it to the current session log
    i_flox_session_add_log_entry("info",entry);
    // DO NOT FREE THE MAP MEMORY
    // i_flox_session_add_log_entry does not copy the map
}
