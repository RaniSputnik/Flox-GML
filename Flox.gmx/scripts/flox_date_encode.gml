/// flox_date_encode(date)
//
//  Takes a GameMaker datetime and turns it into a xs:DateTime string
//  eg: 2014-12-27T11:23:04.976Z
 
var date = argument0;

if not i_flox_assert(is_real(date),
    "Can not encode date, invalid date-time '"+string(date)+"'") then exit;

var tz = date_get_timezone();
date_set_timezone(timezone_utc);

var day = date_get_day(date);
var month = date_get_month(date);
var hour = date_get_hour(date);
var minute = date_get_minute(date);
var second = date_get_second(date);
var millisecond = 0; // No GameMaker support for milliseconds

var sb = string(date_get_year(date));
sb += "-";
if month + 1 < 10 then sb += "0";
sb += string(month) ;
sb += "-";
if day < 10 then sb += "0";
sb += string(day);
sb += "T";
if hour < 10 then sb += "0";
sb += string(hour);
sb += ":";
if minute < 10 then sb += "0";
sb += string(minute);
sb += ":";
if second < 10 then sb += "0";
sb += string(second);
if millisecond > 0 {
    sb += ".";
    if millisecond < 100 then sb += "0";
    if millisecond < 10 then sb += "0";
    sb += string(millisecond);
}
sb += "Z"; //instead of: sb += "-00:00";

date_set_timezone(tz); // Don't modify the timezone
return sb; // Return the resulting string
