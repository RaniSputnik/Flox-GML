/// flox_die(message)
//
//  Registers that an error has occurred and prints/displays it to the developer
//  After an error has occurred flox will not persist the session to disk or make
//  any more requests as data could end up in an invalid state.

var message = argument0;

// TODO add 'prevent error messages' var to flox

if os_type == os_windows or os_type == os_win8native or os_type == os_macosx {
    show_error(message,false);
}
else i_flox_debug_message(fx_log_error,"Error!",message);

// Prevent flox from persisting data (since an error has occurred
// flox may save the cache in an invalid state and we don't want that!)
var fx = flox_get();
fx._fatalErrorOccurred = true;

return false;
