/// flox_log_error(errorType,message)
//
//  Adds an error to the session log
//  ErrorType is used to group errors together in the control panel
//  so try and use only a few error types.

var errorType = string(argument0);
var message = string(argument1);

// Ensure flox is initialized
with i_flox_assert_initialized() {
    // Print a message on the console
    i_flox_debug_message(fx_log_error,"[Error] "+errorType+" : "+message);
    // Create the map to store the data for the log entry
    var entry = map_create("[Log] "+errorType+" : "+message);
    map_set(entry,"name",errorType);
    map_set(entry,"message",message);
    // map_set(entry,"stacktrace",stacktrace) // not available in GameMaker
    // Add it to the current session log
    i_flox_session_add_log_entry("error",entry);
    // DO NOT FREE THE MAP MEMORY
    // i_flox_session_add_log_entry does not copy the map
    
    // Increment the number of errors for this session
    var session = map_get(self._persistentData,"session");
    var numErrors = map_get(session,"numErrors");
    map_set(session,"numErrors",numErrors+1);
    // Invalidate the persistent data so that it gets saved at the next opportunity
    i_flox_persistent_invalidate();
}
