/**
 * i_flox_get_current_time_utc()
 * Returns a datetime with the current time in UTC
 * avoids modifying the current timezone
 */

var tz = date_get_timezone();
date_set_timezone(timezone_utc);
var result = date_current_datetime();
date_set_timezone(tz);
return result;
