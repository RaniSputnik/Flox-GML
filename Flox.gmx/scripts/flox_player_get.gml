/**
 * flox_player_get() Player 
 * Gets the current Flox player
 */

with flox_assert_initialized() {
    return map_get(self._persistentData,"currentPlayer");
}
