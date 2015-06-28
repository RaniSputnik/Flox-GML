/// flox_date_decode(date)
//
//  Takes a xs:DateTime string and parses it into a valid GameMaker datetime
//  eg: 2014-12-27T11:23:04.976Z
 
var str = argument0;
var originalStr = argument0;

if not i_flox_assert(is_string(str),
    "Can not decode date, invalid string '"+string(str)+"'") then exit;

// Parse timezone info
var offsetHours, offsetMinutes;
var timeStr = string_copy(str,string_pos("T",str)+1,string_length(str));
// If Z is present we are on UTC time so no time to add
if string_pos("Z",timeStr) != 0 {
    offsetHours = 0;
    offsetMinutes = 0;
    str = string_replace(str,"Z","");
}
// If + is present then we need to add hours and minutes
else if string_pos("+",timeStr) != 0 {
    var offsetStr = string_copy(timeStr,string_pos("+",timeStr),string_length(timeStr));
    offsetHours = real(string_copy(offsetStr,2,string_pos(":",offsetStr)-1));
    offsetMinutes = real(string_copy(offsetStr,string_pos(":",offsetStr)+1,string_length(offsetStr)));
    str = string_replace(str,offsetStr,"");
}
// And if - is present then we need to subtract hours and minutes
else {
    var offsetStr = string_copy(timeStr,string_pos("-",timeStr),string_length(timeStr));
    offsetHours = -real(string_copy(offsetStr,2,string_pos(":",offsetStr)-1));
    offsetMinutes = -real(string_copy(offsetStr,string_pos(":",offsetStr)+1,string_length(offsetStr)));
    show_debug_message(offsetStr);
    show_debug_message(offsetHours);
    show_debug_message(offsetMinutes);
    str = string_replace(str,offsetStr,"");
}

// Parse the date
var pos = string_pos("-",str);
var year = real(string_copy(str,1,pos-1));
str = string_delete(str,1,pos);
pos = string_pos("-",str);
var month = real(string_copy(str,1,pos-1));
str = string_delete(str,1,pos);
pos = string_pos("T",str);
var day = real(string_copy(str,1,pos-1));
str = string_delete(str,1,pos);

// Parse the time
pos = string_pos(":",str);
var hour = real(string_copy(str,1,pos-1));
str = string_delete(str,1,pos);
pos = string_pos(":",str);
var minute = real(string_copy(str,1,pos-1));
str = string_delete(str,1,pos);
var second = 0;
var millisecond = 0;
pos = string_pos(".",str);
if pos > 0 {
    second = real(string_copy(str,1,pos-1));
    // GameMaker doesn't support milliseconds so
    // we simply wont bother parsing that information
    // from the string
}
else second = real(str);

// Create the datetime
var tz = date_get_timezone();
date_set_timezone(timezone_utc);
var datetime = noone;
if date_valid_datetime(year,month,day,hour,minute,second) {
    datetime = date_create_datetime(year,month,day,hour,minute,second);
    // Add the timezone information
    datetime = date_inc_hour(datetime,offsetHours);
    datetime = date_inc_minute(datetime,offsetMinutes);
}
date_set_timezone(tz);

// Return the result
if datetime == noone return flox_die("Error decoding date string, datetime not valid '"+originalStr+"'");
else return datetime;
