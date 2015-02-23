/**
 * i_flox_player_create(String authType) Player
 * Creates a new player
 */

var authType = argument0;

var player = flox_entity_create(fx_type_player);
flox_entity_set(player,flox_auth_type,authType);
// The players owner is always themselves
map_set(player,flox_owner_id,map_get(player,fx_id));
// The players access is always read only
map_set(player,flox_public_access,flox_read_only);
// We use map set to avoid the checks flox_entity_set has
// for preventing player modification

return player;
