// scrOnLoginKeyError(String message, Real httpStatus, Boolean confirmationSent)

var message = argument0;
var httpStatus = argument1;
var confirmationSent = argument2;
show_message_async("Player login error: message="+message+", httpStatus="+string(httpStatus)+", confirmationSent="+string(confirmationSent));
with self.loadingIndicator { instance_destroy(); }
