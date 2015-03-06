// scrTestOnLeaderboardError(error,httpStatus,cachedScores)

var error = argument0;
var httpStatus = argument1;
show_message_async("Failed to load leaderboard: "+error+", httpStatus: "+string(httpStatus));
global.scores = argument2;