/**
 * flox_player_logout()
 * Logs out the current player and logs in a new guest player
 */

with flox_assert_initialized() {
    i_flox_player_login(flox_guest,flox_null,flox_null,noone,noone,noone);
}
