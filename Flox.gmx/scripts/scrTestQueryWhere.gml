
var player = flox_player_get();
var playerId = flox_entity_get(player,fx_id);
flox_query_begin(fx_type_player);
flox_query_where("ownerId == ?",playerId);
flox_query_find(scrOnQueryComplete,scrOnQueryError);
