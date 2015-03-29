/**
 * i_flox_on_password_reset_error(Map request, String error, Real httpStatus, Map cachedResponse)
 * Called when a password reset request fails to complete.
 */

var request = argument0;
var error = argument1;
var httpStatus = argument2;

// Callback
var callback = map_default(request,"emailResetOnError",noone);
var context = map_default(request,"emailResetContext",noone);
i_flox_callback(context,callback,error,httpStatus);
