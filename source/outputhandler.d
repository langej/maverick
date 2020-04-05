module outputhandler;

import std.stdio;
import std.format;

/// erases the current line in the terminal via ansi escape sequence
const ERASE_LINE = "\033[2K";
/// moves the cursor in the terminal to the previous line via ansi escape sequence
const PREVIOUS = "\033[1F";

/// colors the given text red
string red(string text) pure {
    return format("%s%s%s", RED, text, DEFAULT);
}

/// colors the given text green
string green(string text) pure {
    return format("%s%s%s", GREEN, text, DEFAULT);
}

/// colors the given text yellow
string yellow(string text) pure {
    return format("%s%s%s", YELLOW, text, DEFAULT);
}

private const RED = "\033[0;31m";
private const LIGHT_RED = "\033[1;31m";
private const GREEN = "\033[0;32m";
private const LIGHT_GREEN = "\033[1;32m";
private const BROWN = "\033[0;33m";
private const YELLOW = "\033[1;33m";
private const BLUE = "\033[0;34m";
private const LIGHT_BLUE = "\033[1;34m";
private const PURPLE = "\033[0;35m";
private const LIGHT_PURPLE = "\033[1;35m";
private const CYAN = "\033[0;36m";
private const LIGHT_CYAN = "\033[1;36m";
private const WHITE = "\033[1;37m";
private const GRAY = "\033[0;30m";
private const LIGHT_GRAY = "\033[1;37m";
private const DEFAULT = "\033[0m";

private const UP_LEFT = "\r\033[1A\033[0K";
