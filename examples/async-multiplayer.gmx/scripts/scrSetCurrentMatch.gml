// scrSetCurrentMatch(match)

var match = argument0;

var game = instance_find(objGame,0);
game.currentMatch = match;
room_goto(rmMatch);
