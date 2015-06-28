/// i_flox_assert(condition,message) 
//
//  Checks the given condition is true, if it isn't then
//  a flox error will be thrown with the given message.
//  The result of the condition is returned for easy use
//  eg. if not flox_assert(alive,"You must be alive") return false;

var condition = argument0;
var message = argument1;
if not condition == true {
    flox_die(message);
}
return condition;
