/**
 * i_flox_get_display_resolution() String
 * Returns the display resolution as a human readable string
 * eg. 1920x1080
 */

var resW = string(display_get_width());
var resH = string(display_get_height());
return resW+"x"+resH;