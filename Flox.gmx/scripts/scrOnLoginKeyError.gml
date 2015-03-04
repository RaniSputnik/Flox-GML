// scrOnLoginKeyError(String message, Real httpStatus)

var message = argument0;
var httpStatus = argument1;
show_message_async("Player login error: message="+message+", httpStatus="+string(httpStatus));
with self.loadingIndicator { instance_destroy(); }
