// scrTestEntityLoadError(error,httpStatus,cache)

var error = argument0;
var httpStatus = argument1;
var cache = argument2;
show_message_async("Failed to load entity: "+error+", httpStatus: "+string(httpStatus));
global.entity = cache;