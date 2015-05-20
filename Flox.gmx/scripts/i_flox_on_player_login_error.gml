/**
 * i_flox_on_player_login_error(Map request, String error, Real httpStatus, Map cache)
 * Called when the authenticate request fails.
 */
 
var request = argument0;
var message = argument1;
var status = argument2;
var cacheResult = argument3;
var authDataCopy = map_get(request,"loginAuthData");

// Revert back to the previous authentication
var previousAuth = map_get(request,"loginPreviousAuth");
map_set_map(self._persistentData,"authentication",previousAuth);
// Get details of the request
var onError = map_get(request,"loginOnError");
var context  = map_get(request,"loginContext");
var attemptedAuthType = map_get(authDataCopy,"authType");
// If we are logging in with email, callback with whether or not a confimation
// email has been sent
if attemptedAuthType == fx_email {
    var confirmationSent = (status == http_status_forbidden);
    i_flox_callback(context,onError,message,status,confirmationSent)
}
else if attemptedAuthType == fx_email_password {
    var confirmationSent = (status == http_status_unauthorized);
    i_flox_callback(context,onError,message,status,confirmationSent)
}
// Otherwise we can simply callback
else i_flox_callback(context,onError,message,status);
map_destroy(authDataCopy);
