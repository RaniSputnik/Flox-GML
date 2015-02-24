/**
 * i_flox_callback(Instance context, Script callback, Any ...args) Boolean
 * Call the given script in the given context.
 * Returns whether or not the callback was successful.
 */
 
var context = argument[0];
var callback = argument[1];

if not script_exists(callback) return false;
with context {
    switch argument_count {
        case 2: script_execute(callback); break;
        case 3: script_execute(callback,argument[2]); break;
        case 4: script_execute(callback,argument[2],argument[3]); break;
        case 5: script_execute(callback,argument[2],argument[3],argument[4]); break;
        case 6: script_execute(callback,argument[2],argument[3],argument[4],argument[5]); break;
        case 7: script_execute(callback,argument[2],argument[3],argument[4],argument[5],argument[6]); break;
        case 8: script_execute(callback,argument[2],argument[3],argument[4],argument[5],argument[6],argument[7]); break;
        case 9: script_execute(callback,argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]); break;
        case 10: script_execute(callback,argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9]); break;
        case 11: script_execute(callback,argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10]); break;
        case 12: script_execute(callback,argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11]); break;
        case 13: script_execute(callback,argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12]); break;
        case 14: script_execute(callback,argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8],argument[9],argument[10],argument[11],argument[12],argument[13]); break;
    }
    return true;
}
return false;
