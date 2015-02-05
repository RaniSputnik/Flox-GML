// scrLeaderboardLoadError(String error, Real httpStatus, List cachedResponse)

var error = argument0;
var httpStatus = argument1;
var cachedResponse = argument2;

// If we already have a list, destroy it
if ds_exists(self.list,ds_type_list) {
    ds_list_destroy(self.list);
}
// Set the list to the value from the cache (if any)
self.list = cachedResponse;
// Record the error
self.error = error;
// Destroy the loading indicator
with self.loadingIndicator instance_destroy();
// Clear the request
self.request = noone;
