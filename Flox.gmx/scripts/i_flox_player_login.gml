/**
 * i_flox_player_login(String authType, String authId, String token, 
 *                     Script(Map request, Map result, Number status) scrComplete,
 *                     Script(Map request, String error, Number status) scrFailure)
 * Logs in a flox player with the given auth type.
 * Uses callbacks to capture the result (onComplete and onError).
 */

var authType = argument0;
var authId = argument1;
var token = argument2;
var onComplete = argument3;
var onError = argument4;

var authData = map_create("player-auth-data");
map_set(authData,"authType",authType);
if authId != fx_null then map_set(authData,"authId",authId);
if token != fx_null then map_set(authData,"authToken",token);
i_flox_player_login_auth_data(authData,onComplete,onError);
map_destroy(authData);
