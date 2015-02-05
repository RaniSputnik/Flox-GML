/**
 * i_flox_response_create_error(String error, Number httpStatus) DSMap
 * Creates a fake Flox response in the same format as a Flox error
 */
 
var error = argument0;
var httpStatus = argument1;
 
var headers = noone;
var body = map_create("fake-body");
map_set(body,"message",error);
var response = i_flox_response_create(headers,body,httpStatus);
map_destroy(body);
return response;