// scrLeaderboardLoadComplete(List scores)

// If we already have a list of scores, destroy it
if ds_exists(self.list,ds_type_list) {
    ds_list_destroy(self.list);
}
// Set the new list of scores
self.list = argument0;
// Destroy the loading indicator
with self.loadingIndicator instance_destroy();
// Clear the request
self.request = noone;
