/**
 * i_flox_player_login_auth_data(Map authData,
 *                     Script(Map request, Map result, Number status) onComplete,
 *                     Script(Map request, String error, Number status) onError)
 * Logs in a flox player with the given auth data.
 */

var authData = argument0;
var onComplete = argument1;
var onError = argument2;
var context = id;

if not i_flox_assert(map_exists(authData),
    "Can not log in, auth data provided is invalid") then return false;

with i_flox_assert_initialized() {
    i_flox_debug_message(fx_log_silly,"Logging in with auth data = "+json_encode(authData));
    var previousAuth = i_flox_authentication_get();
    var authType = map_get(authData,"authType");

    // If we are logging in as a guest we don't need an internet connection
    // we can login with credentials that are all supplied by the client
    if authType == fx_guest {
        var player = i_flox_player_create(fx_guest);
        i_flox_on_authenticated(player,authData,previousAuth,onComplete,context);
    }      
    // Otherwise we need to hit the server 
    else {
        var current = flox_player_get();
        var currentAuthType = map_get(current,"authType");
        var currentId = map_get(current,"id");
        // If the current player is a guest, then we should login with their
        // Player id, and associate any data gathered on the guest player with
        // the 'real' player 
        if currentAuthType == fx_guest
            then map_set(authData,"id",currentId);
        
        // Construct the request JSON
        var authDataStr = '{"authType":"'+map_get(authData,"authType")+'"';
        if map_has(authData,"id") then authDataStr += ',"id":"'+map_get(authData,"id")+'"';
        if map_has(authData,"authId") then authDataStr += ',"authId":"'+map_get(authData,"authId")+'"';
        if map_has(authData,"authToken") then authDataStr += ',"authToken":"'+map_get(authData,"authToken")+'"';
        if map_has(authData,"loginOnly") {
            var loginOnly = map_get(authData,"loginOnly");
            var loginOnlyStr = "false";
            if loginOnly then loginOnlyStr = "true";
            authDataStr += ',"loginOnly":'+loginOnlyStr;
        }
        authDataStr += '}';
        
        // Perform the request
        var req = i_flox_request(http_method_post,"authenticate",authDataStr,
                        i_flox_on_player_login_complete,i_flox_on_player_login_error);
        var authDataCopy = map_deep_copy(authData);
        map_set(req,"loginPreviousAuth",previousAuth);
        map_set(req,"loginAuthData",authDataCopy);
        map_set(req,"loginOnComplete",onComplete);
        map_set(req,"loginOnError",onError);
        map_set(req,"loginContext",context);
        // Prevent any new requests while login is in process
        map_delete(self._persistentData,"authentication"); 
    }
}
