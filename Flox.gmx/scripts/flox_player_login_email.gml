/// flox_player_login_email(email,onComplete,onError)
// 
//  Attempts to log a player in using their email only.
//  If a player tries to login with the same email on another
//  device. They will be sent a confirmation email to allow
//  them to control which devices they are playing on.

with i_flox_assert_initialized() { 
    var installationID = map_get(self._persistentData,"installationID");
}
i_flox_player_login(fx_email,argument0,installationID,argument1,argument2);
