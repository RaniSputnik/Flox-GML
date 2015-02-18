/**
 * i_flox_service_request(Map request
 *                        Script(Map request, Map response, Number status) onComplete,
 *                        Script(Map request, String error, Number status, Map cachedResponse) onError) Map
 * Performs a flox request and calls back with then the request
 * completes. Only one of onComplete and onError will be called.
 * Request map must include all details of the request including 'method', 'path' and 'auth'
 * Method must be a valid http method, path is relative to the base path of the server
 * and data is an object containing all data required for the request.
 * Request info is a map containing any other data you wish to pass with the request,
 * when the request calls back these properties are accessible through the request object.
 * If you are making a GET request, data will be encoded into the url.
 * Note: Nested data structures in the data object are not currently supported
 * for GET requests. 
 */

var request = argument0;
var onComplete = argument1;
var onError = argument2; 

var method = map_get(request,"method");
var path = map_get(request,"path");
var auth = map_get(request,"auth");
var data = map_default(request,"data");

var cachedResult = noone;
var requestId    = noone;

flox_debug_message("Making Request","Method="+method,"Path="+path);

// If the method is get, encode a url
if method == http_method_get and map_exists(data) {
    path += "?" + i_flox_encode_map_for_uri(data);
    flox_debug_message("Encoded data for url",path);
}
// Get the cached result from last time (if there is one)
if method == http_method_get and i_flox_cache_contains(path) {
    cachedResult = i_flox_cache_get(path);
    flox_debug_message("Cache contains previous response",cachedResponse);
}
// Fail if a fatal error occurred previously
if self._fatalErrorOccurred {
    /*cachedResult = noone;
    // TODO if the requestInfo is parsed, then we must not change it
    requestId = i_flox_response_create_error("A fatal error occurred, no new requests can be performed",http_status_forbidden);
    i_flox_response(requestId);
    flox_debug_message("WARNING! Request will fail, a fatal error has already occurred and Flox has been shut down");*/
}
// Fail if we are currently authenticating a player
else if not map_exists(auth) {
    /*cachedResult = noone;
    // TODO if the requestInfo is passed, then we must not change it
    requestId = i_flox_response_create_error("Cannot make request while login is in progress",http_status_forbidden);
    i_flox_response(requestId);
    flox_debug_message("WARNING! Request will fail, attempting request while login in process");*/
}
// Otherwise actually perform the request
else {
    // Headers for the request
    // Auth header
    var floxSDK = map_create("request-headers-flox-sdk");
    map_set(floxSDK,"type","gml");
    map_set(floxSDK,"version",flox_sdk_version);
    // Player Header
    var floxPlayer = map_create("request-headers-flox-player");
    map_copy(floxPlayer,auth);
    // Flox header
    var floxHeader = map_create("request-headers-flox");
    map_set_map(floxHeader,"sdk",floxSDK);
    map_set_map(floxHeader,"player",floxPlayer);
    map_set(floxHeader,"gameKey",self.gameKey);
    map_set(floxHeader,"bodyCompression","none"); // TODO add compression
    var ctime = i_flox_get_current_time_utc();
    map_set(floxHeader,"dispatchTime",flox_date_encode(ctime));
    var headers = map_create("request-headers");
    //map_set(headers,"Content-Type","application/json");
    map_set(headers,"X-Flox",json_encode(floxHeader));
    
    // Get the meta-data associated with the cached result
    if map_exists(cachedResult) {
        var eTag = i_flox_cache_metadata_get(path,"eTag",flox_null);
        map_set(headers,"If-None-Match",eTag);
        flox_debug_message("Cache eTag retrieved",eTag);
    }
    
    // Perform the request
    var protocol = "http://";
    if self.secure then protocol = "https://";
    var basePath = self._serviceBasePath;
    // Fail if we have indicated we want all requests to fail
    if self.forceServiceFailure {
        flox_debug_message("WARNING! Request will fail, 'forceServiceFailure' is enabled");
        basePath = 'invalid.flox.cc/api';
    }
    var fullURL = protocol + basePath + "games/" + string(self.gameID) + "/" + path;
    var body = '';
    if map_exists(data) and method != http_method_get {
        body = json_encode(data);
    }
    flox_debug_message("Headers",json_encode(headers));
    flox_debug_message("Body",body);
    flox_debug_message("Full URL",fullURL);
    requestId = http_request(fullURL,method,headers,body);
    
    // Clean up the maps, nested maps not destroyed in HTML5
    map_destroy(floxSDK);
    map_destroy(floxPlayer);
    map_destroy(floxHeader);
    map_destroy(headers);
}

// Add the extra bits and pieces to the map
// Do not use ds_map_add_map because otherwise the cached result will be removed
if map_exists(cachedResult) then map_set(request,"cachedResult",cachedResult);
if onComplete != noone then map_set(request,"onComplete",onComplete);
if onError != noone then map_set(request,"onError",onError);
map_set_map(self._serviceRequests,requestId,request);

return request;