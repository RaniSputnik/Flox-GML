/**
 * flox_on_player_login_complete(Map request, Map result, Number status)
 * Called when the player login request is completed
 */

var request = argument0;
var result  = argument1;
var status  = argument2;

// The server does not add the id and type to the entity map
// The result may not exist if this function has been called manually
// see the i_flox_login function for more details
var entity = map_get(result,"entity");
var playerType = map_get(result,"type");
var playerId   = map_get(result,"id");
var player = i_flox_entity_from_map(playerType,playerId,entity);
// Change the current player to the new player
var prevPlayer = flox_player_get();
map_set_map(self._persistentData,"currentPlayer",player);
// Free the memory used by the previous player
if flox_entity_exists(prevPlayer) {
    flox_entity_free(prevPlayer); // does not hit server
}
// Add the authentication details to the persistent data
var playerId = map_get(player,"id");
var authType = map_get(request,"loginAuthType");
var authId   = map_get(request,"loginAuthId");
var token    = map_get(request,"loginAuthToken");
var auth = i_flox_authentication_create(playerId,authType,authId,token);
map_set_map(self._persistentData,"authentication",auth);
// Invalidate the persistent data so that it saves at the next opportunity
i_flox_persistent_invalidate();
// Destroy the previous authentication
if (map_has(request,"loginPreviousAuth")) {
    var prevAuth = map_get(request,"loginPreviousAuth");
    if map_exists(prevAuth) then map_destroy(prevAuth);
}
// Clear the service cache
i_flox_cache_clear();

// Callback
var callback = map_default(request,"loginOnComplete",noone);
var context = map_default(request,"loginContext",noone);
i_flox_callback(context,callback,player);

