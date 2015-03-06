/**
 * flox_persistent_save() Boolean
 * Saves the persistent data for the given game id,
 * Returns whether or not the save was successful
 */

var data = self._persistentData;
var result = true;

flox_debug_message("Saving persistent data"); 
// Create a string from the supplied data
var str = json_encode(data);
// Write the string to the persistent file
if not self._fatalErrorOccurred {
    if not self.preventPersistentDataSave {
        flox_debug_message("Data",str);
        var path = i_flox_persistent_filepath_get(self.gameID);
        var file = file_text_open_write(path);
        if file > -1 {
            file_text_write_string(file,str);
            file_text_close(file);
            flox_debug_message("Persisted data successfully");
        }
        else { 
            flox_debug_message("WARNING! Failed to open file for writing '"+path+"'");
            result = false;
        }
    }
    else {
        flox_debug_message("WARNING! Data will not be saved, 'preventPersistentDataSave' is enabled");
        result = false;
    }
}
else {
    flox_debug_message("WARNING! Data will not be saved, a fatal error forced flox to shut down");
    result = false;
}
return result;

