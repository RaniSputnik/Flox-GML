/// flox_player_reset_email_password(email,onComplete,onError)
//
//  Causes the server to send a password-reset e-mail to the given
//  e-mail address. If that address is unknown to the server, it 
//  will yield an error with http_status_not_found.

var email = string(argument0);
var onComplete = argument1;
var onError = argument2;
var context = id;
 
with i_flox_assert_initialized() {
    // We make the request, sending the email in the request data
    var data = map_create("password-reset-data");
    map_set(data,"email",email);
    var req = i_flox_request(http_method_post,"resetPassword",data,
        i_flox_on_password_reset_complete,i_flox_on_password_reset_error);
    map_destroy(data);
    // Set the callbacks into the request
    map_set(req,"emailResetOnComplete",onComplete);
    map_set(req,"emailResetOnError",onError);
    map_set(req,"emailResetContext",context);
       
    return true;
}
return false;
