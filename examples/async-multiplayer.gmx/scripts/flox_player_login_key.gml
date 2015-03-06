/**
 * flox_player_login_key(String key,
 *                       Script(Player player) onComplete,
 *                       Script(String error, Real httpStatus) onError)
 * Attempts to log a player in using a key. The key should
 * NOT be user defined, this can be used to login a player
 * previously authenticated with a third-party eg. Facebook.
 */
 
var key = string(argument0);
var onComplete = argument1;
var onError = argument2;
var context = id;

with flox_assert_initialized() {
    i_flox_player_login(fx_key,key,fx_null,onComplete,onError,context);
}

