/**
 * flox_player_login_email(String email, Script(Player player) onComplete,
 *                         Script(String error, Real httpStatus, Boolean confirmationSent) onError)
 * Attempts to log a player in using their email only.
 * If a player tries to login with the same email on another
 * device. They will be sent a confirmation email to allow
 * them to control which devices they are playing on.
 */
 
var email = string(argument0);
var onComplete = argument1;
var onError = argument2;
var context = id;

with flox_assert_initialized() {
    var installationID = map_get(self._persistentData,"installationID");
    i_flox_player_login(fx_email,email,installationID,onComplete,onError,context);
}
