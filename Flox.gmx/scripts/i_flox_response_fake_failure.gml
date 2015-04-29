/**
 * i_flox_response_fake_failure(Map request, String error, Real httpStatus)
 * Creates a fake response that can be processed like an ordinary response
 * The response will be queued and processed next frame to maintain more
 * consistency with the aynchronousity of requests.
 */
 
var request = argument0;
var error = argument1;
var httpStatus = argument2;

// Get the next fake response id
// fake responses are negative numbers to avoid conflicts with
// valid responses from the server
var requestId = self._nextFakeResponseId--;

var responseHeaders = map_create('fake-response-headers');
// TODO fill in any headers we require
var responseBody = map_create('fake-response-body');
map_set(responseBody,"message",error);
var responseBodyJSON = json_encode(responseBody);
map_destroy(responseBody);

var response = map_create('fake-response');
map_set(response,"id",requestId);
map_set(response,"status",0);
map_set(response,"http_status",httpStatus);
map_set_map(response,"response_headers",responseHeaders);
map_set(response,"result",responseBodyJSON);

// Add the request to the list of in-flight requests
map_set_map(self._serviceRequests,requestId,request);
// Register the response to be processed
ds_list_add(self._fakeResponses,response);

return request;
