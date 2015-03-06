/**
 * flox_debug_message(Any arguments...) String
 * Prints a debug message to the console
 * Returns the message that was printed
 */

// Only print the message if verbose is true
var fx = flox_get();
if not fx.verbose then exit;
// Join all the arguments
var str = "";
for (var i = 0; i < argument_count; i++) {
    str += " "+string(argument[i]);
}
show_debug_message("Flox:"+str);
return str;

