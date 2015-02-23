/**
 * flox_player_logout()
 * Logs out the current player and logs in a new guest player
 */

with flox_assert_initialized() {
    i_flox_player_login(fx_guest,fx_null,fx_null,noone,noone,noone);
}
