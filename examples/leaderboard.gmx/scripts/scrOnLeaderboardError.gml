/// scrOnLeaderboardError(error,httpStatus,cachedScores)

var error = argument0;
var httpStatus = argument1;
var cachedScores = argument2;

var leaderboard = instance_find(objLeaderboard,0);
// Pass the error message to objLeaderboard
leaderboard.error = error;
// Pass the cached highscores to objLeaderboard
leaderboard.scores = cachedScores;
// Destroy the leaderboard loader
instance_destroy();
