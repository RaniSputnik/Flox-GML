/**
 * flox_on_player_login_complete(Map request, Map result, Number status)
 * Called when the player login request is completed
 */

var request = argument0;
var result  = argument1;
var status  = argument2;
var authDataCopy = map_get(request,"loginAuthData");
var prevAuth = map_get(request,"loginPreviousAuth");
var onComplete = map_get(request,"loginOnComplete");
var context = map_get(request,"loginContext");

if map_has(result,"authToken") {
    var resultAuthToken = map_get(result,"authToken");
    map_set(authDataCopy,"authToken",resultAuthToken);
}

// The server does not add the id and type to the entity map
// The result may not exist if this function has been called manually
// see the i_flox_login function for more details
var entity = map_get(result,"entity");
var playerType = map_get(result,"type");
var playerId   = map_get(result,"id");
var player = i_flox_entity_from_map(playerType,playerId,entity);

i_flox_on_authenticated(player,authDataCopy,prevAuth,onComplete,context);
map_destroy(authDataCopy);
