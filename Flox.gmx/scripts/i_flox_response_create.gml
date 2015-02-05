// i_flox_fake_response(headers,body,httpStatus)

var headers = argument0;
var body = argument1;
var httpStatus = argument2;
var responseId = flox_create_uid();

// Here we create a fake 'async_load' map
var ev = map_create("fake-response");
map_set(ev,"id",responseId); // The id of the request
map_set(ev,"http_status",http_status_ok); // We reached the 'server' OK
map_set(ev,"status",0); // GameMaker's status, indicating whether or not there was an error
// Now we emulate an actual response from the Flox server
var result = map_create("fake-result");
map_set(result,"status",httpStatus);
if map_exists(headers) map_set_map(result,"headers",headers);
else map_set(result,"headers",flox_null);
if map_exists(body) map_set_map(result,"body",body);
else map_set(result,"body",flox_null);
// Encode and add to the async_load map
var json = json_encode(result);
map_set(ev,"result",json);
// Don't delete the headers/body objects
map_delete(result,"headers");
map_delete(result,"body");
// Clean up the result map
map_destroy(result);

return ev;
