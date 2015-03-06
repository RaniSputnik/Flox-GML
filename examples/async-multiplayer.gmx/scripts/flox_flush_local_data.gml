/**
 * flox_flush_local_data()
 * Saves all the flox data to disk. Changes are flushed to disk automatically
 * so most of the time you wont have to worry, however session duration changes
 * don't trigger a save (otherwise you would save every frame), so on HTML5 you
 * will need to save the data whenever you can to get an accurate session duration
 */
 
with flox_assert_initialized() {
    i_flox_persistent_save(id);
}

