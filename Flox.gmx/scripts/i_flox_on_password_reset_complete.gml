/**
 * i_flox_on_password_reset_complete(Map request, Map response, Real httpStatus)
 * Called when a password reset request completes successfully.
 */
 
// Callback
var callback = map_default(request,"emailResetOnComplete",noone);
var context = map_default(request,"emailResetContext",noone);
i_flox_callback(context,callback);
