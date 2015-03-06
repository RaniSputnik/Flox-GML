// scrCreateMatch(vsPlayerId)

var vsPlayerId = argument0;
var me = flox_player_get();
var myId = flox_entity_get(me,fx_id);
// Create the match
var match = flox_entity_create("Match");
// Allow this match to be edited by other players
flox_entity_set(match,"publicAccess",fx_read_write);
// Set the opponent's id and who's turn it is
flox_entity_set(match,"opponentId",vsPlayerId);
flox_entity_set(match,"waitingForPlayer",myId);
// Keep a record of the turns
// remember to use set_list/set_map when save data structures
flox_entity_set_list(match,"ownerTurns",ds_list_create());
flox_entity_set_list(match,"opponentTurns",ds_list_create());
// Save the match to the server
flox_entity_save_queued(match);
// Return the match we just created
return match;
