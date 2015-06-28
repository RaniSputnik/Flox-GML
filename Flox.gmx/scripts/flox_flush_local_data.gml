/// flox_flush_local_data()
//
//  Saves all the flox data to disk. Changes are flushed to disk automatically
//  so most of the time you wont have to worry, however you can flush local data
//  at regular intervals to get more accurate session durations.

with i_flox_assert_initialized() {
    i_flox_persistent_save(id);
}
