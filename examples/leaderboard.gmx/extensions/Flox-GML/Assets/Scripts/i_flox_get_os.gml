/**
 * i_flox_get_os() String
 * Returns a human readable string of the current OS
 */

// TODO combine result with os_version

switch (os_type) {
    case os_windows: return "Windows";
    // "duplicate case statement found"
    //case os_win8native: return "Windows 8"; 
    //case os_win32: return "Windows 32bit";
    //case os_winphone: return "Windows Phone";
    case os_linux: return "Linux";
    case os_macosx: return "OSX";
    case os_ios: return "iOS";
    case os_android: return "Android";
    case os_tizen: return "Tizen";
    default: return "Unknown";
}