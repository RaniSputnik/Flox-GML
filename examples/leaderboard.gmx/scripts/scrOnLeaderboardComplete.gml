/// scrOnLeaderboardComplete(scores)

var leaderboard = instance_find(objLeaderboard,0);
// Pass the highscores to objLeaderboard
leaderboard.scores = argument0;
// Destroy the leaderboard loader
instance_destroy();