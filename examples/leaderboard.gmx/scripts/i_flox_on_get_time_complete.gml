/// i_flox_on_get_time_complete(request,body,httpStatus)
///
/// @param {map} request
/// @param {map} body
/// @param {real} httpStatus
/// Called when the current time is successfully retrieved from the server

var request    = argument0;
var body       = argument1;
var httpStatus = argument2;

// Parse the entity from the result
var time = flox_date_decode(map_get(body,"time"));

// Callback
var onComplete = map_get(request,"timeOnComplete");
var context = map_get(request,"timeContext");
i_flox_callback(context,onComplete,time);

