/// flox_log_event(eventType,properties)
//
//  Adds an event to the session log, events can have
//  properties bundled with them using the eventData parameter.
 
var eventType = string(argument0);
var props = argument1;
var hasProps = map_exists(props);

// Ensure flox is initialized
with i_flox_assert_initialized() {
    // Print a message on the console
    if hasProps then i_flox_debug_message(fx_log_verbose,"[Event] "+eventType+" : "+json_encode(props));
    else i_flox_debug_message(fx_log_verbose,"[Event] "+eventType);
    // Create the map to store the data for the log entry
    var entry = map_create("[Log] "+eventType);
    map_set(entry,"name",eventType);
    // If the event has properties, then add them into the log entry
    if hasProps {
        var propsCopy = map_deep_copy(props);
        map_meta_set_name(propsCopy, "[Log] "+eventType+" properties");
        map_set_map(entry,"properties",propsCopy);
    }
    // Add it to the current session log
    i_flox_session_add_log_entry("event",entry);
    // DO NOT FREE THE MAP MEMORY
    // i_flox_session_add_log_entry does not copy the map
}
