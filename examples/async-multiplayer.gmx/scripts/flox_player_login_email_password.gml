/// flox_player_login_email_password(email,password,loginOnly,onComplete,onError)
//
//  Log in a player with his e-mail address and a password.
//  Depending on the 'loginOnly' parameter, this method can also be used to sign up
//  a previously unknown player. Once an e-mail address is confirmed, a login will only
//  work with the correct password.
//
//  If the e-mail + password combination is correct, the player will be logged in —
//  regardless of the 'loginOnly' setting.
//  If 'loginOnly = true' and the mail address is unknown or the password is wrong,
//  the method will yield an error with http_status_forbidden.
//  If 'loginOnly = false' and the mail address is used for the first time, the player
//  receives a confirmation mail and the method yields an error with
//  http_status_unauthorized.
//  If 'loginOnly = false' and the mail address was not yet confirmed, or if the
//  mail adress was already registered with a different password, the method will
//  yield an error with http_status_forbidden.
//
//  If the player forgets the password, you can let them acquire a new one with the
//  'resetEmailPassword' function.

 
var email = string(argument0);
var password = string(argument1);
var loginOnly = argument2; 
var onComplete = argument3;
var onError = argument4;

var authData = map_create("player-login-auth-data");
map_set(authData,"authType",fx_email_password);
map_set(authData,"authId", email);
map_set(authData,"authToken", password);
map_set(authData,"loginOnly", !!loginOnly);
i_flox_player_login_auth_data(authData,onComplete,onError);
map_destroy(authData);
