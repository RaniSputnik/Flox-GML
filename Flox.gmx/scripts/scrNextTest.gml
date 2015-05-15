/// Go to the next test

if room_exists(room_next(room)) {
    room_goto_next();
}
else {
    room_goto(room_next(room_first));
}

