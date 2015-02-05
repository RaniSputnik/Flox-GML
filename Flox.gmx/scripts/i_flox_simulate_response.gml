// i_flox_simulate_response(error,httpStatus)

// TODO phoney response


/*var responseId = _fakeResponseId++;

var ev = map_create("fake-response");
map_set(ev,"id",responseId); // The id of the request
map_set(ev,"http_status",http_status_ok); // We reached the 'server' OK
map_set(ev,"status",0);

var result = map_create("fake-result");
map_set(result,"status",argument1);
map_set(result,"headers",noone);

var body = map_create("fake-body");
map_set(body,"message",argument0);
map_set_map(result,"body",body);

var json = json_encode(result);
map_set(ev,"result",json);
map_destroy(result);

i_flox_response(ev);

return responseId++;*/
