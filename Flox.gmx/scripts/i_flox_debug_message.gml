/// i_flox_debug_message(logLevel,message...)
//
//  Prints a messages to the console if the current log level
//  is equal or more verbose than the log level specified
//  Returns the message that was printed

// Only print the message if verbose is true
var fx = flox_get();
var logLevel = argument[0];
if logLevel > fx.logLevel then return "";
// Join all the arguments
var str = "";
for (var i = 1; i < argument_count; i++) {
    str += " "+string(argument[i]);
}
show_debug_message("Flox:"+str);
return str;
