/**
 * i_flox_on_authenticated(Player player, Map authData, Map previousAuth
 *                         Script(Player player) onComplete,
 *                         Object context)
 * Called when the current player is successfully authenticated.
 */
 
var player = argument0;
var authData = argument1;
var prevAuth = argument2;
var onComplete = argument3;
var context = argument4;

// Clear the cache
i_flox_cache_clear();

// Change the current player to the new player
var prevPlayer = flox_player_get();
map_set_map(self._persistentData,"currentPlayer",player);
// Free the memory used by the previous player
if flox_entity_exists(prevPlayer) {
    flox_entity_free(prevPlayer); // does not hit server
}

// Add the authentication details to the persistent data
var playerId = map_get(player,"id");
var authType = map_get(authData,"authType");
var authId   = map_default(authData,"authId",fx_null);
var token    = map_default(authData,"authToken",fx_null);
var auth = i_flox_authentication_create(playerId,authType,authId,token);
map_set_map(self._persistentData,"authentication",auth);
// Destroy the previous authentication
if map_exists(prevAuth) then map_destroy(prevAuth);


// Invalidate the persistent data so that it saves at the next opportunity
i_flox_persistent_invalidate();
// Callback
i_flox_callback(context,onComplete,player);
