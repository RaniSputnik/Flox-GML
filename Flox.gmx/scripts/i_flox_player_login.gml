/**
 * i_flox_player_login(String authType, String authId, String authToken, 
 *                     Script(Map request, Map result, Number status) scrComplete,
 *                     Script(Map request, String error, Number status) scrFailure,
 *                     Object context)
 * Logs in a flox player with the given auth type.
 * Uses callbacks to capture the result (scrComplete and scrFailure).
 */

var authType     = argument0;
var authId       = argument1;
var authToken    = argument2;
var onComplete   = argument3;
var onError      = argument4;
var context      = argument5;
var previousAuth = i_flox_authentication_get();

// If we are logging in as a guest we don't need an internet connection
// we can login with credentials that are all supplied by the client
if authType == fx_guest {
    // If we are logging in as a guest, create a player then callback
    var player = i_flox_player_create(fx_guest);
    // We create a phoney request that carries all the details of the login
    // to the i_flox_on_player_login_complete function
    var req = map_create("login-fake-request");
    map_set(req,"loginAuthType",authType);
    map_set(req,"loginAuthId",authId);
    map_set(req,"loginAuthToken",authToken);
    if map_exists(previousAuth)
        then map_set(req,"loginPreviousAuth",previousAuth);
    var result = map_create("login-fake-result");
    map_set(result,"id",map_get(player,fx_id));
    map_set(result,"type",map_get(player,fx_type));
    map_set_map(result,"entity",player);
    // Notify that the login is complete (it can not fail, and the status is over 9000)
    i_flox_on_player_login_complete(req,result,90001);
    // Destroy the phoney maps that we created
    map_destroy(player);
    map_destroy(req);
    map_destroy(result);
}
else {
    // If we are logging in as anything else then we need to make a request to flox
    var player = flox_player_get();
    var authData = map_create("login-auth-data");
    map_set(authData,"authType",authType);
    map_set(authData,"authId",authId);
    if authToken != fx_null
        then map_set(authData,"authToken",authToken);
    // If the current player is a guest, then we should login with their
    // Player id, and associate any data gathered on the guest player with
    // the 'real' player 
    if map_get(player,"authType") == fx_guest
        then map_set(authData,"id",map_get(player,"id"));
    
    // Perform the request
    var req = i_flox_request(http_method_post,"authenticate",authData,
                        i_flox_on_player_login_complete,i_flox_on_player_login_error);
    map_set(req,"loginAuthType",authType);
    map_set(req,"loginAuthId",authId);
    map_set(req,"loginAuthToken",authToken);
    if map_exists(previousAuth)
        then map_set(req,"loginPreviousAuth",previousAuth);
    map_set(req,"loginOnComplete",onComplete);
    map_set(req,"loginOnError",onError);
    map_set(req,"loginContext",context);
    map_destroy(authData);
    
    // Prevent any new requests while login is in process
    // TODO test what happens if persistent data is saved
    // without authentication
    map_delete(self._persistentData,"authentication"); 
}
