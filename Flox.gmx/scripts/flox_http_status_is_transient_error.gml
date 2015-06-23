/// flox_http_status_is_transient_error(status)
//
//  Whether or not the given httpStatus indicates an error might go away 
//  if the request is tried again (i.e. the server was not reachable or 
//  there was a network error).

return argument0 == http_status_unknown
    or argument0 == http_status_service_unavailable
    or argument0 == http_status_request_timeout;
