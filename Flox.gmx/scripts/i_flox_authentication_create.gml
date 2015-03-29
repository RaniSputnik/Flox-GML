/**
 * i_flox_authentication_create(String playerId, String authType, String authId, String token) DSMap
 * Creates a new flox authentication object
 */

var playerId = argument0;
var authType = argument1;
var authId   = argument2;
var token    = argument3;
    
var auth = map_create("[Authentication] player="+playerId+", type="+authType);
map_set(auth,"id",playerId);
map_set(auth,"authType",authType);
if authId != fx_null then map_set(auth,"authId",authId);
if token != fx_null then map_set(auth,"authToken",token);
return auth;
