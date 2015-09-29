// scrMatchListComplete(matches)

// Destroy the old list 
if ds_exists(matchesToDisplay,ds_type_list) {
    ds_list_destroy(matchesToDisplay);
}
// Set the new list of matches to display
matchesToDisplay = argument0;
// We are no longer loading
loading = false;
