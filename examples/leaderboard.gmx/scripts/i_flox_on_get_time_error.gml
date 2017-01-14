/// i_flox_on_get_time_error(request,error,httpStatus,cachedResponse)
///
/// @param {map} request
/// @param {string} error
/// @param {real} httpStatus
/// @param {map} cachedResponse
/// Called when the current time was failed to be retrieved from the server

var request    = argument0;
var error       = argument1;
var httpStatus = argument2;

// Callback
var onError = map_get(request,"timeOnError");
var context = map_get(request,"timeContext");
i_flox_callback(context,onError,error,httpStatus);

